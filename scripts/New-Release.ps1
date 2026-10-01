param(
    [Parameter(Mandatory = $true)][string]$Version,
    [Parameter(Mandatory = $true)][string]$SignedArtifactDirectory,
    [string]$ExpectedSignerPattern
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$artifactRoot = (Resolve-Path -LiteralPath $SignedArtifactDirectory).Path
$candidates = @(Get-ChildItem -LiteralPath $artifactRoot -Filter 'Offhand.exe' -File -Recurse)
if ($candidates.Count -ne 1) {
    throw "Expected exactly one signed Offhand.exe beneath $artifactRoot; found $($candidates.Count)."
}

$signature = Get-AuthenticodeSignature -LiteralPath $candidates[0].FullName
if ($signature.Status -ne 'Valid') {
    throw "Authenticode validation failed: $($signature.Status) $($signature.StatusMessage)"
}
if ($null -eq $signature.TimeStamperCertificate) {
    throw 'The signed executable does not contain a trusted timestamp.'
}
if ($ExpectedSignerPattern -and
    ($null -eq $signature.SignerCertificate -or $signature.SignerCertificate.Subject -notmatch $ExpectedSignerPattern)) {
    throw "Signer did not match '$ExpectedSignerPattern'; found '$($signature.SignerCertificate.Subject)'."
}

$versionInfo = $candidates[0].VersionInfo
if ($versionInfo.ProductName -ne 'Offhand Companion') {
    throw "Signed artifact product name is '$($versionInfo.ProductName)', not 'Offhand Companion'."
}
if ($versionInfo.ProductVersion -ne $Version) {
    throw "Signed artifact product version is '$($versionInfo.ProductVersion)', not '$Version'."
}

$releaseDir = Join-Path $root 'dist\release'
$stagingDir = Join-Path $root 'dist\package'
New-Item -ItemType Directory -Path $releaseDir,$stagingDir -Force | Out-Null

Copy-Item -LiteralPath $candidates[0].FullName -Destination (Join-Path $releaseDir 'Offhand.exe') -Force
foreach ($file in @('README.md','SECURITY.md','PRIVACY.md','CODE_SIGNING_POLICY.md','LICENSE','Linux.md','build.bat')) {
    Copy-Item -LiteralPath (Join-Path $root $file) -Destination $stagingDir -Force
}
Copy-Item -LiteralPath (Join-Path $root 'Source') -Destination $stagingDir -Recurse -Force
Copy-Item -LiteralPath (Join-Path $releaseDir 'Offhand.exe') -Destination $stagingDir -Force

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zipPath = Join-Path $releaseDir 'Offhand-Companion.zip'
if (Test-Path -LiteralPath $zipPath) { Remove-Item -LiteralPath $zipPath -Force }
$archive = [IO.Compression.ZipFile]::Open($zipPath, [IO.Compression.ZipArchiveMode]::Create)
try {
    $base = $stagingDir.TrimEnd('\','/') + [IO.Path]::DirectorySeparatorChar
    Get-ChildItem -LiteralPath $stagingDir -File -Recurse | Sort-Object FullName | ForEach-Object {
        $entryName = $_.FullName.Substring($base.Length).Replace('\','/')
        [IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
            $archive, $_.FullName, $entryName, [IO.Compression.CompressionLevel]::Optimal) | Out-Null
    }
} finally {
    $archive.Dispose()
}

$checksumPath = Join-Path $releaseDir 'checksums-sha256.txt'
$lines = foreach ($path in @((Join-Path $releaseDir 'Offhand.exe'),$zipPath)) {
    $item = Get-Item -LiteralPath $path
    $hash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
    "$hash  $($item.Name)"
}
$lines | Set-Content -LiteralPath $checksumPath -Encoding ASCII

Write-Output "Packaged signed Offhand Companion $Version"
Write-Output $signature.SignerCertificate.Subject
Write-Output $lines

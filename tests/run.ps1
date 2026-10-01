$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$sourcePath = Join-Path $root 'Source\Program.cs'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (-not (Test-Path -LiteralPath $compiler)) {
    $compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\csc.exe'
}
if (-not (Test-Path -LiteralPath $compiler)) { throw 'C# compiler unavailable' }

$testExe = Join-Path ([IO.Path]::GetTempPath()) ('Offhand-companion-tests-' + [guid]::NewGuid().ToString('N') + '.exe')
try {
    & $compiler /nologo /target:exe /main:Offhand.Companion.PreferencesTest "/out:$testExe" `
        /r:System.dll /r:System.Drawing.dll /r:System.Windows.Forms.dll `
        $sourcePath (Join-Path $PSScriptRoot 'CompanionPreferences.cs')
    if ($LASTEXITCODE -ne 0) { throw 'Companion test compilation failed' }

    & $testExe
    if ($LASTEXITCODE -ne 0) { throw 'Companion behavior tests failed' }

    $source = Get-Content -LiteralPath $sourcePath -Raw
    $constructor = [regex]::Match(
        $source,
        'public CompanionForm\(\)\s*\{(?<body>.*?)\n\s*\}\s*\n\s*private void CheckForUpdates',
        [Text.RegularExpressions.RegexOptions]::Singleline).Groups['body'].Value

    if ($constructor -match 'CheckForUpdates') {
        throw 'Update checks must not run during application startup.'
    }
    if ($source -notmatch 'btnCheckUpdates\.Click.*CheckForUpdates') {
        throw 'Update checks must require an explicit user action.'
    }
    if ($source -match 'Process\.GetProcesses\(\)' -or
        $source -notmatch 'Process\.GetProcessesByName\(processName\)') {
        throw 'Process discovery must remain limited to allowlisted WoW process names.'
    }
    if ($source -match 'Microsoft\.Win32|Registry\.(CurrentUser|LocalMachine)|OpenProcessToken|GetTokenInformation|TokenIntegrityLevel|advapi32\.dll|--minimized') {
        throw 'Companion must not add persistence or inspect process security tokens.'
    }
    if ($source -notmatch 'WebClient' -or $source -notmatch 'api\.github\.com/repos/N4UX-GIT/Offhand-Companion/releases/latest') {
        throw 'The disclosed user-initiated GitHub update check changed unexpectedly.'
    }
    if ($source -notmatch 'AssemblyInformationalVersionAttribute' -or
        $source -notmatch 'CompanionReleaseVersion\.TryParse') {
        throw 'Update checks must compare the complete Companion beta version.'
    }
    if ($source -notmatch 'AssemblyTitle\("Offhand Companion"\)' -or
        $source -notmatch 'AssemblyProduct\("Offhand Companion"\)') {
        throw 'Authenticode product metadata must identify Offhand Companion.'
    }
    if ($source -match 'HttpListener|TcpListener|UdpClient|NamedPipeServerStream|DownloadFile|DownloadData') {
        throw 'Unexpected inbound networking or executable download behavior found.'
    }

    Write-Output 'PASS: functional preference and monitor-selection tests'
    Write-Output 'PASS: update checks remain user initiated'
    Write-Output 'PASS: process discovery remains restricted to WoW names'
    Write-Output 'PASS: no startup persistence or token inspection'
    Write-Output 'PASS: signing metadata and network boundary checks'
} finally {
    if (Test-Path -LiteralPath $testExe) { Remove-Item -LiteralPath $testExe -Force }
}

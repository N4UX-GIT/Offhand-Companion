param([Parameter(Mandatory = $true)][string]$Tag)

$ErrorActionPreference = 'Stop'
$version = $Tag.TrimStart('v')
$sourcePath = Join-Path (Split-Path -Parent $PSScriptRoot) 'Source\Program.cs'
$source = Get-Content -LiteralPath $sourcePath -Raw

$informational = [regex]::Match($source, 'AssemblyInformationalVersion\("(?<value>[^"]+)"\)').Groups['value'].Value
if ([string]::IsNullOrWhiteSpace($informational)) {
    throw 'AssemblyInformationalVersion is missing.'
}
if ($informational -ne $version) {
    throw "Release tag $Tag does not match AssemblyInformationalVersion $informational."
}

$product = [regex]::Match($source, 'AssemblyProduct\("(?<value>[^"]+)"\)').Groups['value'].Value
if ($product -ne 'Offhand Companion') {
    throw "AssemblyProduct must be 'Offhand Companion', found '$product'."
}

Write-Output "PASS: release tag and product metadata match $informational"


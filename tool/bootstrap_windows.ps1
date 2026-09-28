$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$windowsPath = Join-Path $repoRoot "windows"

if (Test-Path $windowsPath) {
    Write-Host "windows/ already exists. Nothing changed."
    exit 0
}

$tempRoot = Join-Path $env:TEMP "team17_flutter_windows_bootstrap"

if (Test-Path $tempRoot) {
    Remove-Item -Recurse -Force $tempRoot
}

Write-Host "Creating temporary Flutter Windows scaffold..."
flutter create $tempRoot --platforms=windows --org com.team17 --project-name team17_flutter_project

Write-Host "Copying only windows/ into the repository..."
Copy-Item -Recurse (Join-Path $tempRoot "windows") $windowsPath

Remove-Item -Recurse -Force $tempRoot

Write-Host "Windows scaffold created safely."
Write-Host "Next: flutter pub get"
Write-Host "Then: flutter run -d windows"

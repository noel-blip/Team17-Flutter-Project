$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$androidPath = Join-Path $repoRoot "android"

if (Test-Path $androidPath) {
    Write-Host "android/ already exists. Nothing changed."
    exit 0
}

$tempRoot = Join-Path $env:TEMP "team17_flutter_android_bootstrap"

if (Test-Path $tempRoot) {
    Remove-Item -Recurse -Force $tempRoot
}

Write-Host "Creating temporary Flutter Android scaffold..."
flutter create $tempRoot --platforms=android --org com.team17 --project-name team17_flutter_project

Write-Host "Copying only android/ into the repository..."
Copy-Item -Recurse (Join-Path $tempRoot "android") $androidPath

Remove-Item -Recurse -Force $tempRoot

Write-Host "Android scaffold created safely."
Write-Host "Next: flutter pub get"
Write-Host "Then: flutter test"
Write-Host "Then: flutter run"

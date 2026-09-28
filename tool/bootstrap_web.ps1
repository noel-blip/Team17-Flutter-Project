$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$webPath = Join-Path $repoRoot "web"

if (Test-Path $webPath) {
    Write-Host "web/ already exists. Nothing changed."
    exit 0
}

$tempRoot = Join-Path $env:TEMP "team17_flutter_web_bootstrap"

if (Test-Path $tempRoot) {
    Remove-Item -Recurse -Force $tempRoot
}

Write-Host "Creating temporary Flutter web scaffold..."
flutter create $tempRoot --platforms=web --project-name team17_flutter_project

Write-Host "Copying only web/ into the repository..."
Copy-Item -Recurse (Join-Path $tempRoot "web") $webPath

Remove-Item -Recurse -Force $tempRoot

Write-Host "Web scaffold created safely."
Write-Host "Next: flutter pub get"
Write-Host "Then: flutter run -d chrome"

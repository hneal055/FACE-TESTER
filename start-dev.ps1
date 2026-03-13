# FACE-TESTER Daily Startup Script

Write-Host "`n=== FACE-TESTER Dev Environment ===" -ForegroundColor Cyan

# Flutter PATH
$flutterBin = "C:\Projects\FACE-TESTER\Tools\flutter\bin"
if ($env:Path -notlike "*$flutterBin*") {
    $env:Path += ";$flutterBin"
    Write-Host "[+] Flutter added to PATH" -ForegroundColor Green
} else {
    Write-Host "[✓] Flutter already in PATH" -ForegroundColor Green
}

# Verify Flutter
$flutterVersion = flutter --version 2>&1 | Select-String "Flutter"
Write-Host "[✓] $flutterVersion" -ForegroundColor Green

# Navigate to app
Set-Location "C:\Projects\FACE-TESTER\app"
Write-Host "[✓] Working directory: $PWD" -ForegroundColor Green

# Git status
Write-Host "`n--- Git Status ---" -ForegroundColor Yellow
git status --short
Write-Host "`n--- Remote ---" -ForegroundColor Yellow
git log origin/master..HEAD --oneline 2>$null | ForEach-Object { Write-Host "  [unpushed] $_" -ForegroundColor Magenta }

# flutter pub get
Write-Host "`n--- Dependencies ---" -ForegroundColor Yellow
flutter pub get

# Connected devices
Write-Host "`n--- Devices ---" -ForegroundColor Yellow
flutter devices

Write-Host "`n=== Ready. Run: flutter run ===" -ForegroundColor Cyan

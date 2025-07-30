Write-Host "========================================" -ForegroundColor Green
Write-Host "FINAL PROFESSIONAL BUILD SOLUTION" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "[1/5] Setting up environment..." -ForegroundColor Yellow
$env:GRADLE_HOME = "C:\Users\Success\Documents\gradle-home"
$env:GRADLE_USER_HOME = "C:\Users\Success\Documents\gradle-home"
$gradlePath = "C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1\bin\gradle.bat"

Write-Host "Gradle Home: $env:GRADLE_HOME" -ForegroundColor Cyan
Write-Host "Gradle Path: $gradlePath" -ForegroundColor Cyan

Write-Host ""
Write-Host "[2/5] Checking if Gradle exists..." -ForegroundColor Yellow
if (Test-Path $gradlePath) {
    Write-Host "✓ Gradle found" -ForegroundColor Green
} else {
    Write-Host "✗ Gradle not found at: $gradlePath" -ForegroundColor Red
    Write-Host "Please check if Gradle is properly installed" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[3/5] Cleaning previous build..." -ForegroundColor Yellow
& $gradlePath clean --no-daemon --gradle-user-home="$env:GRADLE_USER_HOME"
if ($LASTEXITCODE -ne 0) {
    Write-Host "[WARNING] Clean failed, continuing anyway..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[4/5] Building APK..." -ForegroundColor Yellow
& $gradlePath assembleDebug --no-daemon --gradle-user-home="$env:GRADLE_USER_HOME" --stacktrace
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Build failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "BUILD FAILED - PROFESSIONAL SOLUTIONS:" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "1. Use Android Studio (RECOMMENDED)" -ForegroundColor White
    Write-Host "2. Check your internet connection" -ForegroundColor White
    Write-Host "3. Try running as Administrator" -ForegroundColor White
    Write-Host "4. Clear Gradle cache manually" -ForegroundColor White
    Write-Host "========================================" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[5/5] Checking for APK file..." -ForegroundColor Yellow
$apkPath = "app\build\outputs\apk\debug\app-debug.apk"
if (Test-Path $apkPath) {
    $fileInfo = Get-Item $apkPath
    Write-Host "[SUCCESS] APK found!" -ForegroundColor Green
    Write-Host "Location: $apkPath" -ForegroundColor Cyan
    Write-Host "Size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "YOUR APK IS READY!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Location: $apkPath" -ForegroundColor White
    Write-Host ""
    Write-Host "To install on your device:" -ForegroundColor White
    Write-Host "1. Enable Developer Options on your phone" -ForegroundColor White
    Write-Host "2. Enable USB Debugging" -ForegroundColor White
    Write-Host "3. Connect phone to computer" -ForegroundColor White
    Write-Host "4. Run: adb install $apkPath" -ForegroundColor White
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host "[ERROR] APK file not found!" -ForegroundColor Red
    Write-Host "Expected location: $apkPath" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Build completed!" -ForegroundColor Green 
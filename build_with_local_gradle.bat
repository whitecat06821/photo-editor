@echo off
echo ========================================
echo    Building Photo Editor App
echo ========================================
echo.

echo Setting up environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1
set PATH=%GRADLE_HOME%\bin;%PATH%

echo Using local Gradle from: %GRADLE_HOME%
echo.

echo Cleaning project...
gradle clean
if errorlevel 1 (
    echo ERROR: Clean failed
    pause
    exit /b 1
)

echo.
echo Building debug APK...
gradle assembleDebug
if errorlevel 1 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo    BUILD SUCCESSFUL!
echo ========================================
echo.
echo APK Location: app\build\outputs\apk\debug\app-debug.apk
echo.
echo To install on device:
echo 1. Enable Developer Options on your device
echo 2. Enable USB Debugging
echo 3. Connect device via USB
echo 4. Run: adb install app\build\outputs\apk\debug\app-debug.apk
echo.

pause 
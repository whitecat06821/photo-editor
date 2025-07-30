@echo off
echo ========================================
echo    SIMPLE BUILD - APK GENERATION
echo ========================================
echo.

echo Setting up environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1
set PATH=%GRADLE_HOME%\bin;%PATH%

echo Building APK...
gradle assembleDebug --no-daemon --stacktrace

if errorlevel 1 (
    echo Build failed!
    echo.
    echo Trying alternative approach...
    gradle build --no-daemon --stacktrace
    if errorlevel 1 (
        echo All build attempts failed
        echo.
        echo RECOMMENDATION: Use Android Studio
        echo 1. Open Android Studio
        echo 2. Open project: E:\Software\Mobile\Kotlin\photo-editor
        echo 3. Build from Android Studio
        pause
        exit /b 1
    )
)

echo.
echo Checking for APK file...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo SUCCESS! APK found at: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo Your Photo Editor App is ready!
    echo Features:
    echo - Image selection from gallery
    echo - GPU-accelerated grayscale filters
    echo - Text overlay functionality
    echo - Drawing with finger
    echo - Save edited images
    echo.
    echo To install on device:
    echo 1. Enable Developer Options on your device
    echo 2. Enable USB Debugging
    echo 3. Connect device via USB
    echo 4. Run: adb install app\build\outputs\apk\debug\app-debug.apk
) else (
    echo APK not found. Build may have failed.
    echo.
    echo RECOMMENDATION: Use Android Studio
    echo 1. Open Android Studio
    echo 2. Open project: E:\Software\Mobile\Kotlin\photo-editor
    echo 3. Build from Android Studio
)

pause 
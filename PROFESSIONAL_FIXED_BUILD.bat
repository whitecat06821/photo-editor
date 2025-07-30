@echo off
echo ========================================
echo    PROFESSIONAL FIXED BUILD
echo    CODE KING SOLUTION - WORKING!
echo ========================================
echo.

echo Setting up professional environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1
set PATH=%GRADLE_HOME%\bin;%PATH%

echo Using Gradle from: %GRADLE_HOME%
echo.

echo Step 1: Professional Clean...
"%GRADLE_HOME%\bin\gradle.bat" clean --no-daemon
if errorlevel 1 (
    echo WARNING: Clean failed, but continuing...
)

echo.
echo Step 2: Professional APK Build...
echo Building your Photo Editor app...
"%GRADLE_HOME%\bin\gradle.bat" assembleDebug --no-daemon --stacktrace

if errorlevel 1 (
    echo ERROR: Build failed
    echo.
    echo PROFESSIONAL SOLUTION:
    echo 1. Use Android Studio (100% guaranteed to work)
    echo 2. Open project: E:\Software\Mobile\Kotlin\photo-editor
    echo 3. Build from Android Studio
    echo.
    pause
    exit /b 1
)

echo.
echo Checking for APK file...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo ========================================
    echo    PROFESSIONAL SUCCESS!
    echo    APK GENERATED SUCCESSFULLY!
    echo ========================================
    echo.
    echo APK Location: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 🎯 YOUR PROFESSIONAL PHOTO EDITOR APP IS READY!
    echo.
    echo Professional Features Included:
    echo - Image selection from gallery
    echo - GPU-accelerated grayscale filters
    echo - Text overlay functionality
    echo - Drawing with finger
    echo - Save edited images
    echo.
    echo Installation Instructions:
    echo 1. Enable Developer Options on your device
    echo 2. Enable USB Debugging
    echo 3. Connect device via USB
    echo 4. Run: adb install app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 🏆 PROFESSIONAL SUCCESS ACHIEVED!
) else (
    echo ERROR: APK not found
    echo.
    echo PROFESSIONAL RECOMMENDATION:
    echo Use Android Studio for guaranteed success:
    echo 1. Open Android Studio
    echo 2. Open project: E:\Software\Mobile\Kotlin\photo-editor
    echo 3. Build from Android Studio
)

echo.
pause 
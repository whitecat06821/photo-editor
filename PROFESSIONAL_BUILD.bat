@echo off
echo ========================================
echo    PROFESSIONAL PHOTO EDITOR BUILD
echo ========================================
echo.

echo Setting up environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1
set PATH=%GRADLE_HOME%\bin;%PATH%
set GRADLE_OPTS=-Dorg.gradle.daemon=false -Dorg.gradle.parallel=false

echo Using local Gradle from: %GRADLE_HOME%
echo.

echo Step 1: Cleaning project...
gradle clean --no-daemon --offline
if errorlevel 1 (
    echo WARNING: Clean failed, continuing anyway...
)

echo.
echo Step 2: Downloading dependencies (this may take a while)...
gradle --refresh-dependencies --no-daemon
if errorlevel 1 (
    echo WARNING: Dependency refresh failed, trying offline mode...
    gradle --offline --no-daemon
    if errorlevel 1 (
        echo ERROR: Offline mode also failed
        pause
        exit /b 1
    )
)

echo.
echo Step 3: Building debug APK...
gradle assembleDebug --no-daemon --offline
if errorlevel 1 (
    echo ERROR: Build failed
    echo.
    echo Troubleshooting:
    echo 1. Check your internet connection
    echo 2. Try running as administrator
    echo 3. Disable antivirus temporarily
    echo 4. Use Android Studio instead
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
echo Your Photo Editor App is ready!
echo Features included:
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
echo.

pause 
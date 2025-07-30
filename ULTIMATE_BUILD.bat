@echo off
echo ========================================
echo    ULTIMATE PROFESSIONAL BUILD
echo    Photo Editor Android App
echo ========================================
echo.

echo Setting up professional build environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1
set PATH=%GRADLE_HOME%\bin;%PATH%
set GRADLE_OPTS=-Dorg.gradle.daemon=false -Dorg.gradle.parallel=false

echo Using local Gradle: %GRADLE_HOME%
echo.

echo Step 1: Professional Clean...
gradle clean --no-daemon --stacktrace
if errorlevel 1 (
    echo WARNING: Clean failed, but continuing...
)

echo.
echo Step 2: Downloading Dependencies (Professional Mode)...
echo This may take 5-10 minutes depending on your internet connection...
gradle --refresh-dependencies --no-daemon --stacktrace --info
if errorlevel 1 (
    echo WARNING: Online dependency download failed
    echo Trying offline mode with cached dependencies...
    gradle --offline --no-daemon --stacktrace
    if errorlevel 1 (
        echo ERROR: All build attempts failed
        echo.
        echo PROFESSIONAL TROUBLESHOOTING:
        echo 1. Check internet connection
        echo 2. Try running as Administrator
        echo 3. Temporarily disable antivirus
        echo 4. Use Android Studio instead
        echo.
        pause
        exit /b 1
    )
)

echo.
echo Step 3: Building Professional APK...
gradle assembleDebug --no-daemon --stacktrace
if errorlevel 1 (
    echo ERROR: Build failed
    echo.
    echo PROFESSIONAL DIAGNOSIS:
    echo - Check the error messages above
    echo - Verify all dependencies are downloaded
    echo - Try running as Administrator
    echo - Use Android Studio for easier debugging
    pause
    exit /b 1
)

echo.
echo ========================================
echo    PROFESSIONAL BUILD SUCCESSFUL!
echo ========================================
echo.
echo APK Location: app\build\outputs\apk\debug\app-debug.apk
echo.
echo YOUR PHOTO EDITOR APP IS READY!
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
echo Professional Build Complete!
echo.

pause 
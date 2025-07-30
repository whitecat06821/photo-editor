@echo off
echo ========================================
echo    PROFESSIONAL OFFLINE BUILD
echo    CODE KING SOLUTION
echo ========================================
echo.

echo 🚀 PROFESSIONAL CODE KING BUILD STARTING...
echo.

echo Setting up professional environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1
set PATH=%GRADLE_HOME%\bin;%PATH%
set GRADLE_OPTS=-Dorg.gradle.daemon=false -Dorg.gradle.parallel=false -Dorg.gradle.configureondemand=false

echo Using professional Gradle: %GRADLE_HOME%
echo.

echo Step 1: Professional Clean (Offline Mode)...
gradle clean --no-daemon --offline --stacktrace
if errorlevel 1 (
    echo WARNING: Clean failed, but continuing with professional approach...
)

echo.
echo Step 2: Professional Dependency Resolution (Offline)...
echo This will use cached dependencies to avoid network issues...
gradle --offline --no-daemon --stacktrace
if errorlevel 1 (
    echo WARNING: Offline dependency resolution failed
    echo Trying professional fallback approach...
    gradle --no-daemon --stacktrace --refresh-dependencies
    if errorlevel 1 (
        echo ERROR: All professional attempts failed
        echo.
        echo PROFESSIONAL DIAGNOSIS:
        echo - Network connectivity issues detected
        echo - Dependencies not cached locally
        echo - Using Android Studio is recommended
        echo.
        pause
        exit /b 1
    )
)

echo.
echo Step 3: PROFESSIONAL APK BUILD...
echo Building your Photo Editor app with professional precision...
gradle assembleDebug --no-daemon --offline --stacktrace
if errorlevel 1 (
    echo ERROR: Professional build failed
    echo.
    echo PROFESSIONAL SOLUTION:
    echo 1. Use Android Studio (recommended)
    echo 2. Check internet connection
    echo 3. Run as Administrator
    echo 4. Disable antivirus temporarily
    pause
    exit /b 1
)

echo.
echo ========================================
echo    PROFESSIONAL BUILD SUCCESSFUL!
echo    CODE KING SOLUTION COMPLETE!
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
echo.

pause 
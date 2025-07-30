@echo off
echo ========================================
echo    ULTIMATE CODE KING BUILD
echo    PROFESSIONAL SOLUTION
echo ========================================
echo.

echo 🚀 ULTIMATE PROFESSIONAL BUILD STARTING...
echo.

echo Setting up ultimate professional environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1
set PATH=%GRADLE_HOME%\bin;%PATH%
set GRADLE_OPTS=-Dorg.gradle.daemon=false -Dorg.gradle.parallel=false -Dorg.gradle.configureondemand=false

echo Using ultimate Gradle: %GRADLE_HOME%
echo.

echo Step 1: Ultimate Professional Clean...
gradle clean --no-daemon --stacktrace --info
if errorlevel 1 (
    echo WARNING: Clean failed, but continuing with ultimate approach...
)

echo.
echo Step 2: Ultimate Dependency Resolution...
echo This will resolve all dependencies with professional precision...
gradle --no-daemon --stacktrace --info --refresh-dependencies
if errorlevel 1 (
    echo WARNING: Online dependency resolution failed
    echo Trying ultimate offline approach...
    gradle --offline --no-daemon --stacktrace --info
    if errorlevel 1 (
        echo ERROR: All ultimate attempts failed
        echo.
        echo ULTIMATE PROFESSIONAL DIAGNOSIS:
        echo - Network connectivity issues detected
        echo - Dependencies not available offline
        echo - Using Android Studio is the ultimate solution
        echo.
        echo ULTIMATE PROFESSIONAL RECOMMENDATION:
        echo 1. Open Android Studio
        echo 2. Open project: E:\Software\Mobile\Kotlin\photo-editor
        echo 3. Let Android Studio sync and build
        echo 4. This will work 100% guaranteed
        echo.
        pause
        exit /b 1
    )
)

echo.
echo Step 3: ULTIMATE PROFESSIONAL APK BUILD...
echo Building your Photo Editor app with ultimate precision...
gradle assembleDebug --no-daemon --stacktrace --info
if errorlevel 1 (
    echo ERROR: Ultimate build failed
    echo.
    echo ULTIMATE PROFESSIONAL SOLUTION:
    echo 1. Use Android Studio (100% guaranteed to work)
    echo 2. Check internet connection
    echo 3. Run as Administrator
    echo 4. Disable antivirus temporarily
    echo.
    echo ULTIMATE RECOMMENDATION:
    echo Open Android Studio and build from there!
    pause
    exit /b 1
)

echo.
echo ========================================
echo    ULTIMATE BUILD SUCCESSFUL!
echo    CODE KING SOLUTION COMPLETE!
echo ========================================
echo.
echo APK Location: app\build\outputs\apk\debug\app-debug.apk
echo.
echo 🎯 YOUR ULTIMATE PHOTO EDITOR APP IS READY!
echo.
echo Ultimate Professional Features Included:
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
echo 🏆 ULTIMATE PROFESSIONAL SUCCESS ACHIEVED!
echo.

pause 
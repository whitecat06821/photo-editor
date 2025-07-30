@echo off
echo ========================================
echo ULTIMATE PROFESSIONAL BUILD SOLUTION
echo ========================================
echo.

echo [1/5] Setting up environment...
set GRADLE_HOME=C:\Users\Success\Documents\gradle-home
set GRADLE_USER_HOME=C:\Users\Success\Documents\gradle-home
echo Gradle Home: %GRADLE_HOME%

echo.
echo [2/5] Using full Gradle path...
set GRADLE_PATH=C:\Users\Success\Documents\gradle-home\wrapper\dists\gradle-7.6.1-bin\2clxi94ab3brv6467628wnxmd\gradle-7.6.1\bin\gradle.bat

echo.
echo [3/5] Cleaning with full path...
"%GRADLE_PATH%" clean --no-daemon --gradle-user-home="%GRADLE_USER_HOME%"
if errorlevel 1 (
    echo [WARNING] Clean failed, continuing anyway...
)

echo.
echo [4/5] Building APK with full path...
"%GRADLE_PATH%" assembleDebug --no-daemon --gradle-user-home="%GRADLE_USER_HOME%" --stacktrace
if errorlevel 1 (
    echo [ERROR] Build failed!
    goto :error
)

echo.
echo [5/5] Checking for APK file...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo [SUCCESS] APK found at: app\build\outputs\apk\debug\app-debug.apk
    echo [INFO] File size: 
    dir "app\build\outputs\apk\debug\app-debug.apk" | find "app-debug.apk"
    echo.
    echo ========================================
    echo YOUR APK IS READY!
    echo ========================================
    echo Location: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo To install on your device:
    echo 1. Enable Developer Options on your phone
    echo 2. Enable USB Debugging
    echo 3. Connect phone to computer
    echo 4. Run: adb install app\build\outputs\apk\debug\app-debug.apk
    echo ========================================
) else (
    echo [ERROR] APK file not found!
    goto :error
)

goto :end

:error
echo.
echo ========================================
echo BUILD FAILED - ULTIMATE SOLUTIONS:
echo ========================================
echo 1. Use Android Studio (RECOMMENDED)
echo 2. Check if Gradle is properly installed
echo 3. Try running as Administrator
echo 4. Clear all Gradle caches manually
echo ========================================
pause
exit /b 1

:end
echo.
echo Press any key to exit...
pause >nul 
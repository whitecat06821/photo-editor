@echo off
echo ========================================
echo PROFESSIONAL PHOTO EDITOR BUILD SCRIPT
echo ========================================
echo.

echo [1/5] Cleaning previous build...
call gradlew clean --no-daemon --offline
if errorlevel 1 (
    echo [WARNING] Clean failed, continuing anyway...
)

echo.
echo [2/5] Refreshing dependencies...
call gradlew --refresh-dependencies --no-daemon
if errorlevel 1 (
    echo [WARNING] Dependency refresh failed, trying offline mode...
    call gradlew --offline --no-daemon
    if errorlevel 1 (
        echo [ERROR] Offline build also failed
        goto :error
    )
)

echo.
echo [3/5] Building debug APK...
call gradlew assembleDebug --no-daemon --stacktrace
if errorlevel 1 (
    echo [ERROR] Build failed!
    goto :error
)

echo.
echo [4/5] Checking for APK file...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo [SUCCESS] APK found at: app\build\outputs\apk\debug\app-debug.apk
    echo [INFO] File size: 
    dir "app\build\outputs\apk\debug\app-debug.apk" | find "app-debug.apk"
) else (
    echo [ERROR] APK file not found!
    goto :error
)

echo.
echo [5/5] Build completed successfully!
echo ========================================
echo YOUR APK IS READY: app\build\outputs\apk\debug\app-debug.apk
echo ========================================
goto :end

:error
echo.
echo ========================================
echo BUILD FAILED - PROFESSIONAL SOLUTIONS:
echo ========================================
echo 1. Try using Android Studio instead of command line
echo 2. Check your internet connection
echo 3. Clear Gradle cache: gradlew cleanBuildCache
echo 4. Update Gradle wrapper: gradlew wrapper --gradle-version 7.6.1
echo ========================================
pause
exit /b 1

:end
echo.
echo Press any key to exit...
pause >nul 
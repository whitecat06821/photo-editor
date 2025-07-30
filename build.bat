@echo off
echo ========================================
echo    Photo Editor App - Build Script
echo ========================================
echo.

echo Checking Java installation...
java -version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java Development Kit (JDK) 8 or higher
    pause
    exit /b 1
)

echo Java found. Starting build process...
echo.

if exist "gradlew.bat" (
    echo Using Gradle Wrapper...
    echo Cleaning project...
    call gradlew.bat clean
    
    echo Building debug APK...
    call gradlew.bat assembleDebug
    
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
    
) else (
    echo ERROR: Gradle wrapper not found
    echo Please run this script from the project root directory
    echo or use Android Studio to build the project
)

pause 
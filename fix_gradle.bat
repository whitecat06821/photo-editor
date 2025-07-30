@echo off
echo ========================================
echo    Fixing Gradle Distribution Issue
echo ========================================
echo.

echo Creating new Gradle home directory in Documents...
set GRADLE_HOME=%USERPROFILE%\Documents\gradle-home
if not exist "%GRADLE_HOME%" (
    mkdir "%GRADLE_HOME%"
    echo Created %GRADLE_HOME%
) else (
    echo %GRADLE_HOME% already exists
)

echo.
echo Setting environment variable...
set GRADLE_USER_HOME=%GRADLE_HOME%

echo.
echo Clearing old Gradle cache...
if exist "%USERPROFILE%\.gradle" (
    rmdir /s /q "%USERPROFILE%\.gradle"
    echo Cleared old Gradle cache
)

echo.
echo ========================================
echo    Fix Complete!
echo ========================================
echo.
echo Now in Android Studio:
echo 1. Go to File → Settings → Build, Execution, Deployment → Gradle
echo 2. Set "Gradle user home" to: %GRADLE_HOME%
echo 3. Set "Gradle JDK" to: Eclipse Temurin version 17
echo 4. Click Apply and OK
echo 5. File → Invalidate Caches and Restart
echo.
echo After restart, your project should sync successfully!
echo.

pause 
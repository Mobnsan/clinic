@echo off
echo Terminating running FromzaEMR.exe and dotnet.exe processes...
taskkill /F /IM FromzaEMR.exe 2>nul
taskkill /F /IM dotnet.exe 2>nul
timeout /t 2 /nobreak >nul

echo Running dotnet build...
cd /d "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR"
dotnet build -v n > build_full.log 2>&1
if %ERRORLEVEL% EQU 0 (
    echo.
    echo =========================================
    echo BUILD SUCCESSFUL! Starting application...
    echo =========================================
    dotnet run
) else (
    echo.
    echo =========================================
    echo BUILD FAILED! Extracting error...
    echo =========================================
    findstr /i /c:": error " build_full.log
    pause
)

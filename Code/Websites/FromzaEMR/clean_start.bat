@echo off
echo Fermeture de tous les anciens processus...
taskkill /F /IM FromzaEMR.exe 2>nul
taskkill /F /IM dotnet.exe 2>nul

echo Verification du port 5000...
for /f "tokens=5" %%a in ('netstat -aon ^| find "5000" ^| find "LISTENING"') do (
    echo Liberation forcee du port 5000 (PID: %%a)...
    taskkill /F /PID %%a 2>nul
)

timeout /t 2 /nobreak >nul
echo.
echo Demarrage du serveur (Compilation des correctifs C#)...
dotnet run
pause

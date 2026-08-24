@echo off
cd /d "%~dp0"
echo Killing previous processes...
taskkill /F /IM FromzaEMR.exe 2>nul
taskkill /F /IM dotnet.exe 2>nul
timeout /t 2 /nobreak >nul
echo Starting dotnet build and run...
dotnet run
pause

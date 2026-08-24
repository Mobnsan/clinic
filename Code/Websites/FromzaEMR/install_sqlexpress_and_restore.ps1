param (
    [switch]$IsElevated
)

# Request elevation if not already elevated
if (-not $IsElevated) {
    Write-Host "Restarting script with Administrator privileges..." -ForegroundColor Cyan
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`" -IsElevated" -Verb RunAs
    exit
}

Write-Host "1/5. Downloading SQL Server 2022 Express... (This might take 1-2 minutes)" -ForegroundColor Cyan
$installerPath = "$env:TEMP\SQL2022-SSEI-Expr.exe"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/p/?linkid=2215158" -OutFile $installerPath

Write-Host "2/5. Installing SQL Server Express with FILESTREAM... (THIS CAN TAKE 5-15 MINUTES!)" -ForegroundColor Yellow
Write-Host "DO NOT CLOSE THIS WINDOW. Be patient while the installer runs silently." -ForegroundColor Red

# /QS = Quiet Simple (shows progress UI but no prompts)
$installArgs = "/QS /ACTION=Install /FEATURES=SQL /INSTANCENAME=SQLEXPRESS /IACCEPTSQLSERVERLICENSETERMS /FILESTREAMLEVEL=2 /FILESTREAMSHARENAME=SQLEXPRESS /TCPENABLED=1 /NPENABLED=1 /UPDATEENABLED=0"
$process = Start-Process $installerPath -ArgumentList $installArgs -Wait -PassThru

if ($process.ExitCode -ne 0 -and $process.ExitCode -ne 3010) {
    Write-Host "SQL Express Installation failed with exit code $($process.ExitCode)." -ForegroundColor Red
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}
Write-Host "SQL Express Installed Successfully!" -ForegroundColor Green

Write-Host "3/5. Starting SQL Server service..." -ForegroundColor Cyan
Start-Service "MSSQL`$SQLEXPRESS" -ErrorAction SilentlyContinue

Write-Host "4/5. Updating connection strings in codebase to use .\SQLEXPRESS" -ForegroundColor Cyan
$appsettingsPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\appsettings.json"
if (Test-Path $appsettingsPath) {
    (Get-Content $appsettingsPath) -replace '\(localdb\)\\MSSQLLocalDB', '.\SQLEXPRESS' | Set-Content $appsettingsPath
    Write-Host "Updated appsettings.json!"
}

Write-Host "5/5. Restoring the Database..." -ForegroundColor Cyan
$restoreScriptPath = Join-Path (Split-Path $PSCommandPath) "restore_db_sqlexpress.ps1"
if (Test-Path $restoreScriptPath) {
    & $restoreScriptPath
} else {
    Write-Host "Could not find restore_db_sqlexpress.ps1" -ForegroundColor Red
}

Write-Host "ALL DONE! Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

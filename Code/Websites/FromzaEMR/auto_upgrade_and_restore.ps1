param (
    [switch]$IsElevated
)

# Request elevation if not already elevated
if (-not $IsElevated) {
    Write-Host "Restarting script with Administrator privileges..." -ForegroundColor Cyan
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`" -IsElevated" -Verb RunAs
    exit
}

$msiUrl = "https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SqlLocalDB.msi"
$msiPath = "$env:TEMP\SqlLocalDB_2022.msi"

Write-Host "1/4. Downloading SQL Server 2022 LocalDB from Microsoft..." -ForegroundColor Cyan
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $msiUrl -OutFile $msiPath
} catch {
    Write-Host "Failed to download SQL Server LocalDB. Please download it manually." -ForegroundColor Red
    exit
}

Write-Host "2/4. Installing SQL Server 2022 LocalDB silently..." -ForegroundColor Cyan
$installArgs = "/i `"$msiPath`" /qn IACCEPTSQLLOCALDBLICENSETERMS=YES"
$installProcess = Start-Process msiexec.exe -ArgumentList $installArgs -Wait -PassThru
if ($installProcess.ExitCode -ne 0 -and $installProcess.ExitCode -ne 3010) {
    Write-Host "Installation failed with exit code $($installProcess.ExitCode)." -ForegroundColor Red
    exit
}

Write-Host "3/4. Restarting LocalDB instance..." -ForegroundColor Cyan
& "C:\Program Files\Microsoft SQL Server\160\Tools\Binn\SqlLocalDB.exe" stop MSSQLLocalDB | Out-Null
& "C:\Program Files\Microsoft SQL Server\160\Tools\Binn\SqlLocalDB.exe" delete MSSQLLocalDB | Out-Null
& "C:\Program Files\Microsoft SQL Server\160\Tools\Binn\SqlLocalDB.exe" create MSSQLLocalDB | Out-Null
& "C:\Program Files\Microsoft SQL Server\160\Tools\Binn\SqlLocalDB.exe" start MSSQLLocalDB | Out-Null

Write-Host "4/4. Restoring Database from backup..." -ForegroundColor Cyan
$restoreScriptPath = Join-Path (Split-Path $PSCommandPath) "restore_db.ps1"
if (Test-Path $restoreScriptPath) {
    & $restoreScriptPath
} else {
    Write-Host "Could not find restore_db.ps1" -ForegroundColor Red
}

Write-Host "ALL DONE! Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

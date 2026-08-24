$tempDir = "C:\Temp\SqlDeveloperFiles"
if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
}

Write-Host "1/3. Moving files to C:\Temp to bypass Windows Permissions..." -ForegroundColor Cyan

$origBackupPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\2. EMR-Db\FromzaInternationalDB\Dev_DanpheEMR_INT1.bak"
$backupPath = "C:\Temp\Dev_DanpheEMR_INT1.bak"

Write-Host "Copying backup file to C:\Temp... (Please wait)" -ForegroundColor Yellow
Copy-Item -Path $origBackupPath -Destination $backupPath -Force

$mdfPath = Join-Path $tempDir "DEV_FromzaEMR_INT.mdf"
$ldfPath = Join-Path $tempDir "DEV_FromzaEMR_INT_log.ldf"
$fsPath = Join-Path $tempDir "DEV_FromzaEMR_INT_PatientFiles"

$connString = "Server=localhost;Initial Catalog=master;Integrated Security=True;MultipleActiveResultSets=true;TrustServerCertificate=True"

$killSql = @"
DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('DEV_FromzaEMR_INT')
EXEC(@kill);
"@

$restoreSql = @"
RESTORE DATABASE [DEV_FromzaEMR_INT] 
FROM DISK = '$backupPath' 
WITH REPLACE,
MOVE 'Danphe_MNK_FINAL' TO '$mdfPath',
MOVE 'Danphe_MNK_FINAL_log' TO '$ldfPath',
MOVE 'Danphe_PatientFiles' TO '$fsPath'
"@

$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connString
$conn.Open()

$cmd = $conn.CreateCommand()

Write-Host "2/3. Killing active connections (if any)..." -ForegroundColor Cyan
$cmd.CommandText = $killSql
try { $cmd.ExecuteNonQuery() | Out-Null } catch {}

Write-Host "3/3. Restoring database from backup. This can take 1-3 minutes..." -ForegroundColor Yellow
$cmd.CommandText = $restoreSql
$cmd.CommandTimeout = 600
try {
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Database DEV_FromzaEMR_INT restored successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to restore database: $_" -ForegroundColor Red
}

$conn.Close()
Write-Host "ALL DONE! Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

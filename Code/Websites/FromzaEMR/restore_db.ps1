$baseDir = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\LocalDbFiles"
if (-not (Test-Path $baseDir)) {
    New-Item -ItemType Directory -Force -Path $baseDir | Out-Null
}

$mdfPath = Join-Path $baseDir "DEV_FromzaEMR_INT.mdf"
$ldfPath = Join-Path $baseDir "DEV_FromzaEMR_INT_log.ldf"
$fsPath = Join-Path $baseDir "DEV_FromzaEMR_INT_PatientFiles"

$backupPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\2. EMR-Db\FromzaInternationalDB\Dev_DanpheEMR_INT1.bak"
$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True;MultipleActiveResultSets=true"

# First, disconnect active connections
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

Write-Host "Killing active connections..." -ForegroundColor Cyan
$cmd = $conn.CreateCommand()
$cmd.CommandText = $killSql
$cmd.ExecuteNonQuery() | Out-Null

Write-Host "Restoring database from backup. This might take a minute..." -ForegroundColor Yellow
$cmd.CommandText = $restoreSql
try {
    $cmd.CommandTimeout = 300 # 5 minutes
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Database DEV_FromzaEMR_INT restored successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to restore database: $_" -ForegroundColor Red
}

$conn.Close()

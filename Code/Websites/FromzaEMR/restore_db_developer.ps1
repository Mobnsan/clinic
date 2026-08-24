$baseDir = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\SqlDeveloperFiles"
if (-not (Test-Path $baseDir)) {
    New-Item -ItemType Directory -Force -Path $baseDir | Out-Null
}

$mdfPath = Join-Path $baseDir "DEV_FromzaEMR_INT.mdf"
$ldfPath = Join-Path $baseDir "DEV_FromzaEMR_INT_log.ldf"
$fsPath = Join-Path $baseDir "DEV_FromzaEMR_INT_PatientFiles"

$backupPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\2. EMR-Db\FromzaInternationalDB\Dev_DanpheEMR_INT1.bak"
$connString = "Server=localhost;Initial Catalog=master;Integrated Security=True;MultipleActiveResultSets=true;TrustServerCertificate=True"

# First, attempt to enable FILESTREAM via SQL (might require a service restart if not enabled in setup)
$enableFilestreamSql = @"
EXEC sp_configure filestream_access_level, 2;  
RECONFIGURE;  
"@

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
try {
    $conn.Open()
} catch {
    Write-Host "Could not connect to SQL Server Developer. Make sure the service is running." -ForegroundColor Red
    exit
}

$cmd = $conn.CreateCommand()

Write-Host "Enabling FILESTREAM feature on SQL Server..." -ForegroundColor Cyan
try {
    $cmd.CommandText = $enableFilestreamSql
    $cmd.ExecuteNonQuery() | Out-Null
} catch {
    Write-Host "Warning: Could not enable FILESTREAM automatically. If the restore fails, you will need to enable it in SQL Server Configuration Manager." -ForegroundColor Yellow
}

Write-Host "Killing active connections (if any)..." -ForegroundColor Cyan
$cmd.CommandText = $killSql
try { $cmd.ExecuteNonQuery() | Out-Null } catch {}

Write-Host "Restoring database from backup. This can take 1-3 minutes..." -ForegroundColor Yellow
$cmd.CommandText = $restoreSql
$cmd.CommandTimeout = 600 # 10 minutes
try {
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Database DEV_FromzaEMR_INT restored successfully!" -ForegroundColor Green
    
    # Update appsettings.json
    Write-Host "Updating appsettings.json connection strings..." -ForegroundColor Cyan
    $appsettingsPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\appsettings.json"
    if (Test-Path $appsettingsPath) {
        (Get-Content $appsettingsPath) -replace '\(localdb\)\\MSSQLLocalDB', 'localhost' | Set-Content $appsettingsPath
    }
} catch {
    Write-Host "Failed to restore database: $_" -ForegroundColor Red
    Write-Host "If the error mentions FILESTREAM, you must enable it in SQL Server Configuration Manager!" -ForegroundColor Red
}

$conn.Close()

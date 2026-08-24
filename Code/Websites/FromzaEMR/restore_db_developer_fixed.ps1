param (
    [switch]$IsElevated
)

if (-not $IsElevated) {
    Write-Host "Restarting script with Administrator privileges to fix folder permissions..." -ForegroundColor Cyan
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`" -IsElevated" -Verb RunAs
    exit
}

$baseDir = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\SqlDeveloperFiles"
if (-not (Test-Path $baseDir)) {
    New-Item -ItemType Directory -Force -Path $baseDir | Out-Null
}

$backupDir = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\2. EMR-Db\FromzaInternationalDB"
$backupPath = Join-Path $backupDir "Dev_DanpheEMR_INT1.bak"

Write-Host "1/3. Fixing Folder Permissions (SQL Server needs access to your Desktop)..." -ForegroundColor Cyan
# Grant Everyone Full Control to the Data directory
$aclData = Get-Acl $baseDir
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$aclData.AddAccessRule($rule)
Set-Acl -Path $baseDir -AclObject $aclData

# Grant Everyone Full Control to the Backup directory
$aclBackup = Get-Acl $backupDir
$aclBackup.AddAccessRule($rule)
Set-Acl -Path $backupDir -AclObject $aclBackup


$mdfPath = Join-Path $baseDir "DEV_FromzaEMR_INT.mdf"
$ldfPath = Join-Path $baseDir "DEV_FromzaEMR_INT_log.ldf"
$fsPath = Join-Path $baseDir "DEV_FromzaEMR_INT_PatientFiles"

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
    Write-Host "If the error mentions FILESTREAM, you must enable it in SQL Server Configuration Manager!" -ForegroundColor Red
}

$conn.Close()
Write-Host "ALL DONE! Press any key to exit..." -ForegroundColor Green
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

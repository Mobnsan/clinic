$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True;MultipleActiveResultSets=true"
$backupPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\2. EMR-Db\FromzaInternationalDB\Dev_DanpheEMR_INT1.bak"
$sqlText = "RESTORE FILELISTONLY FROM DISK = '$backupPath'"

$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connString
$conn.Open()
$cmd = $conn.CreateCommand()
$cmd.CommandText = $sqlText
$reader = $cmd.ExecuteReader()
while ($reader.Read()) {
    Write-Host "LogicalName: " $reader["LogicalName"] ", Type: " $reader["Type"]
}
$conn.Close()

$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DEV_FromzaEMR_INT;Integrated Security=True;MultipleActiveResultSets=true"
$sqlText = @"
SELECT TOP 10 CreatedOn FROM PAT_Patient ORDER BY CreatedOn DESC;
"@

$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connString
$conn.Open()
$cmd = $conn.CreateCommand()
$cmd.CommandText = $sqlText
$reader = $cmd.ExecuteReader()
while ($reader.Read()) {
    Write-Host "Patient CreatedOn:" $reader["CreatedOn"]
}
$conn.Close()

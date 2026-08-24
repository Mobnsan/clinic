$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DEV_FromzaEMR_INT;Integrated Security=True;MultipleActiveResultSets=true"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()
$cmd = $conn.CreateCommand()

$tables = @(
    'PAT_Patient',
    'PAT_PatientVisits',
    'EMP_Employee',
    'MST_Department',
    'CORE_CFG_Parameters',
    'MST_Municipality',
    'CFG_PrintExportSettings'
)

foreach ($t in $tables) {
    $cmd.CommandText = "SELECT COUNT(*) FROM sys.tables WHERE name = '$t'"
    $exists = $cmd.ExecuteScalar()
    if ($exists -gt 0) {
        $cmd.CommandText = "SELECT COUNT(*) FROM $t"
        $count = $cmd.ExecuteScalar()
        Write-Host "Table $t : EXISTS (Rows: $count)"
    } else {
        Write-Host "Table $t : MISSING"
    }
}

$conn.Close()

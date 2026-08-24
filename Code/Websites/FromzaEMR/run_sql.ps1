$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DEV_FromzaEMR_INT;Integrated Security=True;MultipleActiveResultSets=true"
$sqlPath = ".\setup_database.sql"
$sqlText = [System.IO.File]::ReadAllText("$PWD\setup_database.sql")
$batches = [System.Text.RegularExpressions.Regex]::Split($sqlText, '(?m)^\s*GO\s*$', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connString
$conn.Open()

foreach ($batch in $batches) {
    if (-not [string]::IsNullOrWhiteSpace($batch)) {
        try {
            $cmd = $conn.CreateCommand()
            $cmd.CommandText = $batch
            $cmd.ExecuteNonQuery() | Out-Null
        } catch {
            Write-Host "Error executing batch: $_" -ForegroundColor Red
            Write-Host "Batch content: $batch" -ForegroundColor Yellow
        }
    }
}
$conn.Close()
Write-Host "Mise à jour de la base de données terminée avec succès !" -ForegroundColor Green

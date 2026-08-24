$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DEV_FromzaEMR_INT;Integrated Security=True;MultipleActiveResultSets=true"
$sqlPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\setup_database.sql"

if (-not (Test-Path $sqlPath)) {
    Write-Host "[ERR] setup_database.sql not found at $sqlPath" -ForegroundColor Red
    exit 1
}

$sqlContent = Get-Content -Raw -Path $sqlPath
# Split the SQL content by GO statement (case-insensitive, on its own line)
$batches = [regex]::Split($sqlContent, "(?mi)^\s*GO\s*$")

Write-Host "Connecting to LocalDB and executing setup batches..." -ForegroundColor Yellow

$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
try {
    $conn.Open()
    $cmd = $conn.CreateCommand()
    $cmd.CommandTimeout = 120

    $batchIndex = 0
    foreach ($batch in $batches) {
        $cleanBatch = $batch.Trim()
        if ([string]::IsNullOrWhiteSpace($cleanBatch)) { continue }
        
        $batchIndex++
        try {
            $cmd.CommandText = $cleanBatch
            $cmd.ExecuteNonQuery() | Out-Null
            Write-Host "[OK] Executed SQL batch $batchIndex" -ForegroundColor Green
        } catch {
            Write-Host "[ERR] Failed to execute SQL batch $batchIndex" -ForegroundColor Red
            Write-Host "Error Details: $_" -ForegroundColor DarkRed
            # Write snippet of failing batch for debugging
            $snippet = $cleanBatch.Substring(0, [Math]::Min(100, $cleanBatch.Length))
            Write-Host "Batch Snippet: $snippet..." -ForegroundColor Gray
        }
    }
} catch {
    Write-Host "[ERR] Database connection failed: $_" -ForegroundColor Red
} finally {
    if ($conn.State -eq 'Open') { $conn.Close() }
}

Write-Host "`nSetup complete!" -ForegroundColor Green

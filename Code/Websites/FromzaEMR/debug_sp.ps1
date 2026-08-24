$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DEV_FromzaEMR_INT;Integrated Security=True;MultipleActiveResultSets=true"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()

Write-Host "=== TESTING DASHBOARD STORED PROCEDURES ==="

function Test-SP($spName, $params) {
    Write-Host "`nTesting: $spName"
    try {
        $cmd = $conn.CreateCommand()
        $cmd.CommandType = [System.Data.CommandType]::StoredProcedure
        $cmd.CommandText = $spName
        foreach ($p in $params.Keys) {
            $val = $params[$p]
            if ($val -eq $null) {
                $cmd.Parameters.AddWithValue($p, [System.DBNull]::Value) | Out-Null
            } else {
                $cmd.Parameters.AddWithValue($p, $val) | Out-Null
            }
        }
        $adapter = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
        $ds = New-Object System.Data.DataSet
        $adapter.Fill($ds) | Out-Null
        Write-Host "SUCCESS! Tables returned: $($ds.Tables.Count)"
        for ($i = 0; $i -lt $ds.Tables.Count; $i++) {
            Write-Host "  Table[$i] rows: $($ds.Tables[$i].Rows.Count), columns: $($ds.Tables[$i].Columns.Count)"
        }
    } catch {
        Write-Host "FAILED: $_"
        if ($_.Exception.InnerException) {
            Write-Host "INNER EXCEPTION: $($_.Exception.InnerException.Message)"
        }
    }
}

Test-SP "SP_Dashboard_PAT_CardSummaryCalculation" @{ "@FromDate" = "2026-01-01"; "@ToDate" = "2026-12-31" }
Test-SP "SP_Dashboard_PAT_PatientCountByDay" @{ "@FromDate" = "2026-01-01"; "@ToDate" = "2026-12-31" }
Test-SP "SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup" @{ "@FromDate" = "2026-01-01"; "@ToDate" = "2026-12-31" }
Test-SP "SP_Dashboard_PAT_DepartmentWiseAppointment" @{ "@FromDate" = "2026-01-01"; "@ToDate" = "2026-12-31" }
Test-SP "SP_Dashboard_PAT_VisitByMembership" @{ "@FromDate" = "2026-01-01"; "@ToDate" = "2026-12-31" }
Test-SP "SP_Dashboard_PAT_PatientDistributionBasedOnRank" @{ "@FromDate" = "2026-01-01"; "@ToDate" = "2026-12-31"; "@DepartmentId" = $null }
Test-SP "SP_Dashboard_PAT_HospitalManagement" @{ "@FromDate" = "2026-01-01"; "@ToDate" = "2026-12-31" }

$conn.Close()

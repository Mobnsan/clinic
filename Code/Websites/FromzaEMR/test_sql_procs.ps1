$connString = "Data Source=(localdb)\MSSQLLocalDB; Initial Catalog=DEV_FromzaEMR_INT; Integrated Security=True"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()

$procs = @(
    @{ Name = "SP_Dashboard_PAT_CardSummaryCalculation"; HasDept = $false },
    @{ Name = "SP_Dashboard_PAT_PatientCountByDay"; HasDept = $false },
    @{ Name = "SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup"; HasDept = $false },
    @{ Name = "SP_Dashboard_PAT_DepartmentWiseAppointment"; HasDept = $false },
    @{ Name = "SP_Dashboard_PAT_VisitByMembership"; HasDept = $false },
    @{ Name = "SP_Dashboard_PAT_PatientDistributionBasedOnRank"; HasDept = $true },
    @{ Name = "SP_Dashboard_PAT_HospitalManagement"; HasDept = $false }
)

foreach ($p in $procs) {
    $procName = $p.Name
    try {
        $cmd = $conn.CreateCommand()
        $cmd.CommandType = [System.Data.CommandType]::StoredProcedure
        $cmd.CommandText = $procName
        $cmd.Parameters.AddWithValue("@FromDate", "2026-01-01") | Out-Null
        $cmd.Parameters.AddWithValue("@ToDate", "2026-12-31") | Out-Null
        if ($p.HasDept) {
            $cmd.Parameters.AddWithValue("@DepartmentId", [System.DBNull]::Value) | Out-Null
        }
        $adapter = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
        $ds = New-Object System.Data.DataSet
        $adapter.Fill($ds) | Out-Null
        Write-Host "Proc $procName: SUCCESS (Tables returned: $($ds.Tables.Count))"
    } catch {
        Write-Host "Proc $procName: FAILED -> $_"
    }
}

try {
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "SELECT OpdNewPatientServiceItemId, OpdOldPatientServiceItemId, FollowupServiceItemId FROM MST_Department"
    $cmd.ExecuteScalar() | Out-Null
    Write-Host "Table MST_Department: SUCCESS (Columns exist)"
} catch {
    Write-Host "Table MST_Department: FAILED -> $_"
}

$conn.Close()

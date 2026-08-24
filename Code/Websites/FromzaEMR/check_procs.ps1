$connString = "Data Source=(localdb)\MSSQLLocalDB; Initial Catalog=DEV_FromzaEMR_INT; Integrated Security=True"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()
$cmd = $conn.CreateCommand()

$procs = @(
    'SP_Dashboard_PAT_CardSummaryCalculation',
    'SP_Dashboard_PAT_PatientCountByDay',
    'SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup',
    'SP_Dashboard_PAT_DepartmentWiseAppointment',
    'SP_Dashboard_PAT_VisitByMembership',
    'SP_Dashboard_PAT_PatientDistributionBasedOnRank',
    'SP_Dashboard_PAT_HospitalManagement'
)

foreach ($p in $procs) {
    $cmd.CommandText = "SELECT COUNT(*) FROM sys.objects WHERE type = 'P' AND name = '$p'"
    $exists = $cmd.ExecuteScalar()
    Write-Host "$p : $(if ($exists -gt 0) { 'EXISTS' } else { 'MISSING' })"
}

$conn.Close()

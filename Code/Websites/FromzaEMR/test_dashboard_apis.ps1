$endpoints = @(
    "http://127.0.0.1:5000/api/PatientDashboard/GetPatientDashboardCardSummaryCalculation?FromDate=2026-01-01&ToDate=2026-12-31",
    "http://127.0.0.1:5000/api/PatientDashboard/GetPatientCountByDay?FromDate=2026-01-01&ToDate=2026-12-31",
    "http://127.0.0.1:5000/api/PatientDashboard/GetAverageTreatmentCostbyAgeGroup?FromDate=2026-01-01&ToDate=2026-12-31",
    "http://127.0.0.1:5000/api/PatientDashboard/GetDepartmentWiseAppointment?FromDate=2026-01-01&ToDate=2026-12-31",
    "http://127.0.0.1:5000/api/PatientDashboard/GetPAtVisitByMembership?FromDate=2026-01-01&ToDate=2026-12-31",
    "http://127.0.0.1:5000/api/PatientDashboard/GetPatientDistributionBasedOnRank?FromDate=2026-01-01&ToDate=2026-12-31",
    "http://127.0.0.1:5000/api/PatientDashboard/GetHospitalManagement?FromDate=2026-01-01&ToDate=2026-12-31"
)

foreach ($ep in $endpoints) {
    try {
        $res = Invoke-RestMethod -Uri $ep -Method Get -UseBasicParsing
        Write-Host "Endpoint: $ep"
        Write-Host "Status: $($res.Status)"
        if ($res.Status -ne "OK") {
            Write-Host "ErrorMessage: $($res.ErrorMessage)"
        }
        Write-Host "--------------------------------"
    } catch {
        Write-Host "Endpoint $ep threw exception: $_"
        Write-Host "--------------------------------"
    }
}

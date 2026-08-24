$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DEV_FromzaEMR_INT;Integrated Security=True;MultipleActiveResultSets=true"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()
$cmd = $conn.CreateCommand()

# 1. SP_Dashboard_PAT_CardSummaryCalculation
$cmd.CommandText = @"
CREATE OR ALTER PROCEDURE [dbo].[SP_Dashboard_PAT_CardSummaryCalculation]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Table 0: Patients
    SELECT 
        ISNULL(COUNT(1), 0) AS Total,
        ISNULL(SUM(CASE WHEN CAST(CreatedOn AS DATE) = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END), 0) AS Today,
        ISNULL(SUM(CASE WHEN CAST(CreatedOn AS DATE) = CAST(DATEADD(day, -1, GETDATE()) AS DATE) THEN 1 ELSE 0 END), 0) AS Yesterday
    FROM PAT_Patient;

    -- Table 1: Doctors
    SELECT 
        ISNULL(COUNT(1), 0) AS Total,
        ISNULL(SUM(CASE WHEN EmployeeRole = 'Consultant' THEN 1 ELSE 0 END), 0) AS Consultants,
        ISNULL(SUM(CASE WHEN EmployeeRole = 'Medical Officer' THEN 1 ELSE 0 END), 0) AS MedicalOfficers,
        ISNULL(SUM(CASE WHEN EmployeeRole = 'Anaesthetist' THEN 1 ELSE 0 END), 0) AS Anaesthetists
    FROM EMP_Employee WHERE IsActive = 1;

    -- Table 2: Appointments
    SELECT 
        ISNULL(COUNT(1), 0) AS Total,
        ISNULL(SUM(CASE WHEN VisitType = 'outpatient' THEN 1 ELSE 0 END), 0) AS [New],
        ISNULL(SUM(CASE WHEN VisitStatus = 'followup' THEN 1 ELSE 0 END), 0) AS FollowUp,
        ISNULL(SUM(CASE WHEN VisitStatus = 'referral' THEN 1 ELSE 0 END), 0) AS Referrals,
        ISNULL(SUM(CASE WHEN VisitStatus = 'cancelled' THEN 1 ELSE 0 END), 0) AS Cancelled,
        ISNULL(SUM(CASE WHEN VisitStatus = 'returned' THEN 1 ELSE 0 END), 0) AS Returned
    FROM PAT_PatientVisits;

    -- Table 3: ReAdmission
    SELECT 
        ISNULL(COUNT(1), 0) AS Total
    FROM PAT_PatientVisits WHERE VisitType = 'inpatient';
END;
"@
try { $cmd.ExecuteNonQuery(); Write-Host "Created SP_Dashboard_PAT_CardSummaryCalculation" } catch { Write-Host "Err 1: $_" }

# 2. SP_Dashboard_PAT_PatientCountByDay
$cmd.CommandText = @"
CREATE OR ALTER PROCEDURE [dbo].[SP_Dashboard_PAT_PatientCountByDay]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        CAST(CreatedOn AS DATE) AS [Label],
        VisitType,
        COUNT(1) AS PatientCount
    FROM PAT_PatientVisits
    WHERE CreatedOn BETWEEN @FromDate AND @ToDate
    GROUP BY CAST(CreatedOn AS DATE), VisitType;
END;
"@
try { $cmd.ExecuteNonQuery(); Write-Host "Created SP_Dashboard_PAT_PatientCountByDay" } catch { Write-Host "Err 2: $_" }

# 3. SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup
$cmd.CommandText = @"
CREATE OR ALTER PROCEDURE [dbo].[SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        'Male' AS Gender,
        '0-18' AS AgeRange,
        0.0 AS Total
    UNION ALL
    SELECT 'Female', '0-18', 0.0
    UNION ALL
    SELECT 'Others', '0-18', 0.0;
END;
"@
try { $cmd.ExecuteNonQuery(); Write-Host "Created SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup" } catch { Write-Host "Err 3: $_" }

# 4. SP_Dashboard_PAT_DepartmentWiseAppointment
$cmd.CommandText = @"
CREATE OR ALTER PROCEDURE [dbo].[SP_Dashboard_PAT_DepartmentWiseAppointment]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        d.DepartmentName,
        COUNT(v.PatientVisitId) AS AppointmentCount
    FROM MST_Department d
    LEFT JOIN PAT_PatientVisits v ON d.DepartmentId = v.DepartmentId AND v.CreatedOn BETWEEN @FromDate AND @ToDate
    GROUP BY d.DepartmentName;
END;
"@
try { $cmd.ExecuteNonQuery(); Write-Host "Created SP_Dashboard_PAT_DepartmentWiseAppointment" } catch { Write-Host "Err 4: $_" }

# 5. SP_Dashboard_PAT_VisitByMembership
$cmd.CommandText = @"
CREATE OR ALTER PROCEDURE [dbo].[SP_Dashboard_PAT_VisitByMembership]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        'General' AS MembershipTypeName,
        COUNT(1) AS [Count]
    FROM PAT_PatientVisits
    WHERE CreatedOn BETWEEN @FromDate AND @ToDate;
END;
"@
try { $cmd.ExecuteNonQuery(); Write-Host "Created SP_Dashboard_PAT_VisitByMembership" } catch { Write-Host "Err 5: $_" }

# 6. SP_Dashboard_PAT_PatientDistributionBasedOnRank
$cmd.CommandText = @"
CREATE OR ALTER PROCEDURE [dbo].[SP_Dashboard_PAT_PatientDistributionBasedOnRank]
    @FromDate DATETIME,
    @ToDate DATETIME,
    @DepartmentId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        'General' AS Rank,
        COUNT(1) AS [Count]
    FROM PAT_Patient
    WHERE CreatedOn BETWEEN @FromDate AND @ToDate;
END;
"@
try { $cmd.ExecuteNonQuery(); Write-Host "Created SP_Dashboard_PAT_PatientDistributionBasedOnRank" } catch { Write-Host "Err 6: $_" }

# 7. SP_Dashboard_PAT_HospitalManagement
$cmd.CommandText = @"
CREATE OR ALTER PROCEDURE [dbo].[SP_Dashboard_PAT_HospitalManagement]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        'Total Patients' AS ManagementName,
        COUNT(1) AS [Count]
    FROM PAT_Patient;
END;
"@
try { $cmd.ExecuteNonQuery(); Write-Host "Created SP_Dashboard_PAT_HospitalManagement" } catch { Write-Host "Err 7: $_" }

$conn.Close()

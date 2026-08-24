-- ============================================================================
-- setup_database.sql
-- ============================================================================

-- PAT_Patient
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'PAT_Patient')
BEGIN
    CREATE TABLE [dbo].[PAT_Patient] (
        PatientId INT IDENTITY(1,1) PRIMARY KEY,
        PatientNo INT NULL,
        EMPI NVARCHAR(50) NULL,
        Salutation NVARCHAR(10) NULL,
        FirstName NVARCHAR(100) NULL,
        LastName NVARCHAR(100) NULL,
        MiddleName NVARCHAR(100) NULL,
        FatherName NVARCHAR(100) NULL,
        MotherName NVARCHAR(100) NULL,
        Gender NVARCHAR(10) NULL,
        Age NVARCHAR(20) NULL,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NULL,
        IsActive BIT DEFAULT 1,
        CountrySubDivisionId INT NULL,
        CountryId INT NULL,
        DateOfBirth DATETIME NULL,
        PhoneNumber NVARCHAR(50) NULL,
        Address NVARCHAR(500) NULL,
        PatientCode NVARCHAR(50) NULL,
        BloodGroup NVARCHAR(10) NULL,
        MaritalStatus NVARCHAR(20) NULL,
        Race NVARCHAR(50) NULL,
        MunicipalityId INT NULL,
        EthnicGroup NVARCHAR(100) NULL,
        IsVaccinationPatient BIT DEFAULT 0,
        MembershipTypeId INT NULL,
        Occupation NVARCHAR(100) NULL,
        Email NVARCHAR(100) NULL,
        LandlineNumber NVARCHAR(50) NULL,
        IDCardNumber NVARCHAR(50) NULL,
        PANNumber NVARCHAR(50) NULL
    );
END
GO

-- EMP_Employee
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'EMP_Employee')
BEGIN
    CREATE TABLE [dbo].[EMP_Employee] (
        EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
        FirstName NVARCHAR(100) NULL,
        LastName NVARCHAR(100) NULL,
        MiddleName NVARCHAR(100) NULL,
        Gender NVARCHAR(10) NULL,
        DateOfBirth DATETIME NULL,
        DateOfJoining DATETIME NULL,
        EmployeeRole NVARCHAR(100) NULL,
        DepartmentId INT NULL,
        Designation NVARCHAR(100) NULL,
        Qualification NVARCHAR(200) NULL,
        IsActive BIT DEFAULT 1,
        IsAppointmentApplicable BIT DEFAULT 0,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NULL,
        EmployeeRoleId INT NULL,
        Salutation NVARCHAR(20) NULL,
        ContactNumber NVARCHAR(50) NULL,
        Email NVARCHAR(100) NULL,
        MedCertificationNo NVARCHAR(100) NULL,
        FullName NVARCHAR(300) NULL
    );
END
GO

-- MST_Department
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'MST_Department')
BEGIN
    CREATE TABLE [dbo].[MST_Department] (
        DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
        DepartmentName NVARCHAR(200) NULL,
        DepartmentCode NVARCHAR(50) NULL,
        Description NVARCHAR(500) NULL,
        IsActive BIT DEFAULT 1,
        IsAppointmentApplicable BIT DEFAULT 0,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NULL,
        ParentDepartmentId INT NULL,
        NoticeText NVARCHAR(MAX) NULL,
        RoomNumber NVARCHAR(50) NULL
    );
END
GO

-- PAT_PatientVisits
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'PAT_PatientVisits')
BEGIN
    CREATE TABLE [dbo].[PAT_PatientVisits] (
        PatientVisitId INT IDENTITY(1,1) PRIMARY KEY,
        PatientId INT NULL,
        VisitDate DATETIME DEFAULT GETDATE(),
        VisitType NVARCHAR(50) NULL,
        VisitStatus NVARCHAR(50) NULL,
        ProviderId INT NULL,
        DepartmentId INT NULL,
        BillingStatus NVARCHAR(50) NULL,
        AppointmentType NVARCHAR(50) NULL,
        VisitCode NVARCHAR(50) NULL,
        IsActive BIT DEFAULT 1,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NULL,
        ParentVisitId INT NULL,
        IsVisitContinued BIT DEFAULT 0,
        IsSignedVisitSummary BIT NULL,
        QueueNo INT NULL,
        Remarks NVARCHAR(500) NULL,
        ReferredByProvider NVARCHAR(200) NULL,
        TransferredProviderId INT NULL,
        ClaimCode BIGINT NULL,
        SchemeId INT NULL,
        PriceCategoryId INT NULL
    );
END
GO

-- MST_Municipality
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'MST_Municipality')
BEGIN
    CREATE TABLE [dbo].[MST_Municipality] (
        MunicipalityId INT IDENTITY(1,1) PRIMARY KEY,
        MunicipalityName NVARCHAR(200) NULL,
        CountrySubDivisionId INT NULL,
        Type NVARCHAR(100) NULL,
        IsActive BIT DEFAULT 1,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NULL
    );
END
GO

-- CORE_CFG_Parameters
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'CORE_CFG_Parameters')
BEGIN
    CREATE TABLE [dbo].[CORE_CFG_Parameters] (
        ParameterId INT IDENTITY(1,1) PRIMARY KEY,
        ParameterGroupName NVARCHAR(200) NULL,
        ParameterName NVARCHAR(200) NULL,
        ParameterValue NVARCHAR(MAX) NULL,
        ValueDataType NVARCHAR(50) NULL,
        Description NVARCHAR(500) NULL,
        ParameterNameDescription NVARCHAR(500) NULL
    );
END
GO

-- CFG_PrintExportSettings
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'CFG_PrintExportSettings')
BEGIN
    CREATE TABLE [dbo].[CFG_PrintExportSettings] (
        PrintExportSettingId INT IDENTITY(1,1) PRIMARY KEY,
        SettingName NVARCHAR(200) NULL,
        PageHeaderText NVARCHAR(500) NULL,
        ReportDescription NVARCHAR(500) NULL,
        ModuleName NVARCHAR(200) NULL,
        IsActive BIT DEFAULT 1
    );
END
GO

-- MST_Country
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'MST_Country')
BEGIN
    CREATE TABLE [dbo].[MST_Country] (
        CountryId INT IDENTITY(1,1) PRIMARY KEY,
        CountryName NVARCHAR(200) NULL,
        CountryShortName NVARCHAR(10) NULL,
        ISDCode NVARCHAR(10) NULL,
        IsActive BIT DEFAULT 1,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NULL
    );
END
GO

-- MST_CountrySubDivision
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'MST_CountrySubDivision')
BEGIN
    CREATE TABLE [dbo].[MST_CountrySubDivision] (
        CountrySubDivisionId INT IDENTITY(1,1) PRIMARY KEY,
        CountrySubDivisionName NVARCHAR(200) NULL,
        CountryId INT NULL,
        IsActive BIT DEFAULT 1,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NULL,
        MapAreaId INT NULL
    );
END
GO

-- 1. SP_Dashboard_PAT_CardSummaryCalculation
IF OBJECT_ID('SP_Dashboard_PAT_CardSummaryCalculation','P') IS NOT NULL
    DROP PROCEDURE SP_Dashboard_PAT_CardSummaryCalculation;
GO
CREATE PROCEDURE [dbo].[SP_Dashboard_PAT_CardSummaryCalculation]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        ISNULL(COUNT(1), 0) AS Total,
        ISNULL(SUM(CASE WHEN CAST(CreatedOn AS DATE) = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END), 0) AS Today,
        ISNULL(SUM(CASE WHEN CAST(CreatedOn AS DATE) = CAST(DATEADD(day, -1, GETDATE()) AS DATE) THEN 1 ELSE 0 END), 0) AS Yesterday
    FROM PAT_Patient;

    SELECT 
        ISNULL(COUNT(1), 0) AS Total,
        ISNULL(SUM(CASE WHEN r.EmployeeRoleName = 'Consultant' THEN 1 ELSE 0 END), 0) AS Consultants,
        ISNULL(SUM(CASE WHEN r.EmployeeRoleName = 'Medical Officer' THEN 1 ELSE 0 END), 0) AS MedicalOfficers,
        ISNULL(SUM(CASE WHEN r.EmployeeRoleName = 'Anaesthetist' THEN 1 ELSE 0 END), 0) AS Anaesthetists
    FROM EMP_Employee e 
    LEFT JOIN EMP_EmployeeRole r ON e.EmployeeRoleId = r.EmployeeRoleId
    WHERE e.IsActive = 1;

    SELECT 
        ISNULL(COUNT(1), 0) AS Total,
        ISNULL(SUM(CASE WHEN VisitType = 'outpatient' THEN 1 ELSE 0 END), 0) AS [New],
        ISNULL(SUM(CASE WHEN VisitStatus = 'followup' THEN 1 ELSE 0 END), 0) AS FollowUp,
        ISNULL(SUM(CASE WHEN VisitStatus = 'referral' THEN 1 ELSE 0 END), 0) AS Referrals,
        ISNULL(SUM(CASE WHEN VisitStatus = 'cancelled' THEN 1 ELSE 0 END), 0) AS Cancelled,
        ISNULL(SUM(CASE WHEN VisitStatus = 'returned' THEN 1 ELSE 0 END), 0) AS Returned
    FROM PAT_PatientVisits;

    SELECT 
        ISNULL(COUNT(1), 0) AS Total
    FROM PAT_PatientVisits WHERE VisitType = 'inpatient';
END;
GO

-- 2. SP_Dashboard_PAT_PatientCountByDay
IF OBJECT_ID('SP_Dashboard_PAT_PatientCountByDay','P') IS NOT NULL
    DROP PROCEDURE SP_Dashboard_PAT_PatientCountByDay;
GO
CREATE PROCEDURE [dbo].[SP_Dashboard_PAT_PatientCountByDay]
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
GO

-- 3. SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup
IF OBJECT_ID('SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup','P') IS NOT NULL
    DROP PROCEDURE SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup;
GO
CREATE PROCEDURE [dbo].[SP_Dashboard_PAT_AverageTreatmentCostbyAgeGroup]
    @FromDate DATETIME,
    @ToDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 'Male' AS Gender, '0-18' AS AgeRange, 0.0 AS Total
    UNION ALL
    SELECT 'Female', '0-18', 0.0
    UNION ALL
    SELECT 'Others', '0-18', 0.0;
END;
GO

-- 4. SP_Dashboard_PAT_DepartmentWiseAppointment
IF OBJECT_ID('SP_Dashboard_PAT_DepartmentWiseAppointment','P') IS NOT NULL
    DROP PROCEDURE SP_Dashboard_PAT_DepartmentWiseAppointment;
GO
CREATE PROCEDURE [dbo].[SP_Dashboard_PAT_DepartmentWiseAppointment]
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
GO

-- 5. SP_Dashboard_PAT_VisitByMembership
IF OBJECT_ID('SP_Dashboard_PAT_VisitByMembership','P') IS NOT NULL
    DROP PROCEDURE SP_Dashboard_PAT_VisitByMembership;
GO
CREATE PROCEDURE [dbo].[SP_Dashboard_PAT_VisitByMembership]
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
GO

-- 6. SP_Dashboard_PAT_PatientDistributionBasedOnRank
IF OBJECT_ID('SP_Dashboard_PAT_PatientDistributionBasedOnRank','P') IS NOT NULL
    DROP PROCEDURE SP_Dashboard_PAT_PatientDistributionBasedOnRank;
GO
CREATE PROCEDURE [dbo].[SP_Dashboard_PAT_PatientDistributionBasedOnRank]
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
GO

-- 7. SP_Dashboard_PAT_HospitalManagement
IF OBJECT_ID('SP_Dashboard_PAT_HospitalManagement','P') IS NOT NULL
    DROP PROCEDURE SP_Dashboard_PAT_HospitalManagement;
GO
CREATE PROCEDURE [dbo].[SP_Dashboard_PAT_HospitalManagement]
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
GO

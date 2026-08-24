$connString = "Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DEV_FromzaEMR_INT;Integrated Security=True;MultipleActiveResultSets=true"
$sqlText = @"
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lab_Mst_Gov_Report_Items]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Lab_Mst_Gov_Report_Items](
    [ReportItemId] [int] IDENTITY(1,1) NOT NULL,
    [SerialNumber] [int] NOT NULL,
    [TestName] [nvarchar](255) NULL,
    [GroupName] [nvarchar](255) NULL,
    [DisplayName] [nvarchar](255) NULL,
    [HasInnerItems] [bit] NOT NULL,
    [InnerTestGroupName] [nvarchar](255) NULL,
    [IsActive] [bit] NOT NULL,
    CONSTRAINT [PK_Lab_Mst_Gov_Report_Items] PRIMARY KEY CLUSTERED ([ReportItemId] ASC)
)

CREATE UNIQUE NONCLUSTERED INDEX [Unique_Gov_Lab_ReportItem_Name] ON [dbo].[Lab_Mst_Gov_Report_Items] ([TestName]) WHERE [TestName] IS NOT NULL
CREATE UNIQUE NONCLUSTERED INDEX [Unique_Gov_Lab_ReportItem_SerialNumber] ON [dbo].[Lab_Mst_Gov_Report_Items] ([SerialNumber])
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lab_Gov_Report_Mapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Lab_Gov_Report_Mapping](
    [ReportMapId] [int] IDENTITY(1,1) NOT NULL,
    [ReportItemId] [int] NOT NULL,
    [LabItemId] [bigint] NOT NULL,
    [IsActive] [bit] NOT NULL,
    [IsComponentBased] [bit] NOT NULL,
    [ComponentId] [int] NULL,
    [IsResultCount] [bit] NOT NULL,
    [PositiveIndicator] [nvarchar](max) NULL,
    CONSTRAINT [PK_Lab_Gov_Report_Mapping] PRIMARY KEY CLUSTERED ([ReportMapId] ASC)
)
END
"@

$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connString
$conn.Open()
try {
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = $sqlText
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Table Lab_Mst_Gov_Report_Items verified/created successfully!" -ForegroundColor Green
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
$conn.Close()

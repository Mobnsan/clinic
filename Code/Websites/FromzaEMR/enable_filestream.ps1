param (
    [switch]$IsElevated
)

if (-not $IsElevated) {
    Write-Host "Restarting script with Administrator privileges to enable FILESTREAM..." -ForegroundColor Cyan
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`" -IsElevated" -Verb RunAs
    exit
}

Write-Host "Attempting to enable FILESTREAM automatically via WMI..." -ForegroundColor Cyan

try {
    $namespace = "root\Microsoft\SqlServer\ComputerManagement16"
    $filestreamProp = Get-WmiObject -Namespace $namespace -Class SqlServiceAdvancedProperty | Where-Object { $_.SqlServiceType -eq 1 -and $_.PropertyName -eq "FILESTREAM" }
    
    if ($filestreamProp) {
        $filestreamProp.PropertyNumValue = 1 # 1 = Enable for T-SQL
        $filestreamProp.Put() | Out-Null
        
        Write-Host "FILESTREAM enabled! Restarting SQL Server service..." -ForegroundColor Yellow
        Restart-Service -Name "MSSQLSERVER" -Force
        
        # Now configure it in SQL
        $connString = "Server=localhost;Initial Catalog=master;Integrated Security=True;TrustServerCertificate=True"
        $conn = New-Object System.Data.SqlClient.SqlConnection
        $conn.ConnectionString = $connString
        $conn.Open()
        $cmd = $conn.CreateCommand()
        $cmd.CommandText = "EXEC sp_configure filestream_access_level, 1; RECONFIGURE;"
        $cmd.ExecuteNonQuery() | Out-Null
        $conn.Close()

        Write-Host "Successfully enabled FILESTREAM and restarted the server!" -ForegroundColor Green
    } else {
        Write-Host "Could not find FILESTREAM WMI property. You will need to enable it manually." -ForegroundColor Red
    }
} catch {
    Write-Host "Automatic FILESTREAM enablement failed. Please follow the manual GUI instructions." -ForegroundColor Red
}

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

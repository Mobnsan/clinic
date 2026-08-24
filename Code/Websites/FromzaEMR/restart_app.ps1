# Kill existing server processes
Stop-Process -Name "FromzaEMR" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "dotnet" -Force -ErrorAction SilentlyContinue

# Kill anything on port 5000
$tcpConns = Get-NetTCPConnection -LocalPort 5000 -ErrorAction SilentlyContinue
if ($tcpConns) {
    foreach ($conn in $tcpConns) {
        Stop-Process -Id $conn.OwningProcess -Force -ErrorAction SilentlyContinue
    }
}
Start-Sleep -Seconds 2

# Clean build directory and run
Set-Location "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR"
Write-Host "Starting server with dotnet run..." -ForegroundColor Green
dotnet run

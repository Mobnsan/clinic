Get-Process -Name "FromzaEMR" -ErrorAction SilentlyContinue | Stop-Process -Force
Get-Process -Name "dotnet" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2
Write-Host "Killed existing processes."

Set-Location "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR"
dotnet build
if ($LASTEXITCODE -eq 0) {
    Write-Host "Build succeeded!"
} else {
    Write-Host "Build failed with code $LASTEXITCODE"
}

Write-Host "Cleaning up Windows Temp folders to free up space..." -ForegroundColor Cyan

# 1. Clear User Temp
$userTemp = $env:TEMP
if (Test-Path $userTemp) {
    Write-Host "Cleaning $userTemp..."
    Get-ChildItem -Path $userTemp -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer } | Remove-Item -Force -ErrorAction SilentlyContinue
}

# 2. Clear System Temp
$sysTemp = "C:\Windows\Temp"
if (Test-Path $sysTemp) {
    Write-Host "Cleaning $sysTemp..."
    Get-ChildItem -Path $sysTemp -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer } | Remove-Item -Force -ErrorAction SilentlyContinue
}

# 3. Clear Recycle Bin
Write-Host "Emptying Recycle Bin..."
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host "Cleanup Complete! Let's check your free space now:" -ForegroundColor Green
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object DeviceID, @{Name="FreeSpace(GB)";Expression={[math]::Round($_.FreeSpace/1GB, 2)}} | Format-Table -AutoSize

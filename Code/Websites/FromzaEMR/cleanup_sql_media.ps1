$bytesFreed = 0
function Remove-SafePath {
    param($Path)
    if (Test-Path $Path) {
        $size = (Get-ChildItem $Path -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
        if ($size -gt 0) {
            Write-Host "Cleaning $Path ($([math]::Round($size/1MB, 2)) MB)..."
            Remove-Item -Recurse -Force $Path -ErrorAction SilentlyContinue
            return $size
        }
    }
    return 0
}

Write-Host "Freeing up SQL Server Installation Media space..." -ForegroundColor Cyan
$bytesFreed += Remove-SafePath "C:\SQL2022"
$bytesFreed += Remove-SafePath "$env:TEMP\SqlLocalDB_2022.msi"
$bytesFreed += Remove-SafePath "$env:TEMP\SQL2022-SSEI-Expr.exe"

# Also try clearing browser caches or other temp folders that might have regenerated
$bytesFreed += Remove-SafePath "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache"
$bytesFreed += Remove-SafePath "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"

Write-Host "`nTotal Extra Space Freed: $([math]::Round($bytesFreed/1MB, 2)) MB" -ForegroundColor Green

Write-Host "`nCurrent Free Space on C: Drive:" -ForegroundColor Yellow
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object DeviceID, @{Name="FreeSpace(GB)";Expression={[math]::Round($_.FreeSpace/1GB, 2)}} | Format-Table -AutoSize

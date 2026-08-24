Write-Host "Running Aggressive Developer Cleanup..." -ForegroundColor Cyan

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

# 1. NuGet Cache
$bytesFreed += Remove-SafePath "$env:USERPROFILE\.nuget\packages"
$bytesFreed += Remove-SafePath "$env:LOCALAPPDATA\NuGet\v3-cache"

# 2. NPM Cache
$bytesFreed += Remove-SafePath "$env:LOCALAPPDATA\npm-cache"
$bytesFreed += Remove-SafePath "$env:APPDATA\npm-cache"

# 3. Yarn Cache
$bytesFreed += Remove-SafePath "$env:LOCALAPPDATA\Yarn\Cache"

# 4. Windows Software Distribution Download (Windows Updates cache)
$bytesFreed += Remove-SafePath "C:\Windows\SoftwareDistribution\Download"

# 5. Composer/Pip/pipenv caches
$bytesFreed += Remove-SafePath "$env:LOCALAPPDATA\pip\cache"

Write-Host "`nTotal Space Freed: $([math]::Round($bytesFreed/1GB, 2)) GB" -ForegroundColor Green

Write-Host "`nCurrent Free Space on C: Drive:" -ForegroundColor Yellow
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object DeviceID, @{Name="FreeSpace(GB)";Expression={[math]::Round($_.FreeSpace/1GB, 2)}} | Format-Table -AutoSize

# Create cache folders on the D: drive
$dDrive = "D:\"
if (-not (Test-Path $dDrive)) {
    Write-Host "Wait, you don't seem to have a D:\ drive! Please check your drive letters." -ForegroundColor Red
    exit
}

$nugetCache = "D:\NuGetCache"
$npmCache = "D:\npm-cache"

if (-not (Test-Path $nugetCache)) { New-Item -ItemType Directory -Force -Path $nugetCache | Out-Null }
if (-not (Test-Path $npmCache)) { New-Item -ItemType Directory -Force -Path $npmCache | Out-Null }

Write-Host "1/2. Pointing .NET (NuGet) to use D: drive..." -ForegroundColor Cyan
[Environment]::SetEnvironmentVariable("NUGET_PACKAGES", $nugetCache, "User")
[Environment]::SetEnvironmentVariable("NUGET_PACKAGES", $nugetCache, "Process")

Write-Host "2/2. Pointing Node.js (NPM) to use D: drive..." -ForegroundColor Cyan
npm config set cache $npmCache

Write-Host "Done! Your C:\ drive is now safe from package downloads!" -ForegroundColor Green
Write-Host "IMPORTANT: You MUST close your terminal window and open a NEW ONE for the changes to take effect." -ForegroundColor Yellow

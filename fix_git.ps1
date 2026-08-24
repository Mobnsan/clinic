$rootDir = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr"
Push-Location $rootDir

Write-Host "Removing diagnostic and helper scripts..." -ForegroundColor Yellow
$filesToRemove = @(
    "check_password.ps1"
    "check_tables.ps1"
    "reset_password.ps1"
    "restore_admin_db.ps1"
    "verify_login.ps1"
    "verify_login2.ps1"
    "verify_login3.ps1"
    "push_to_github.ps1"
)

foreach ($file in $filesToRemove) {
    $filePath = Join-Path $rootDir $file
    if (Test-Path $filePath) {
        Remove-Item -Force $filePath
        Write-Host "Deleted $file"
    }
}

Write-Host "`nWiping old git history to start clean..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Remove-Item -Recurse -Force ".git" -ErrorAction SilentlyContinue
}

Write-Host "Re-initializing Git..." -ForegroundColor Cyan
git init

Write-Host "Adding GitHub remote..."
git remote add origin https://github.com/Mobnsan/clinic.git

Write-Host "Updating .gitignore..."
$gitignorePath = Join-Path $rootDir ".gitignore"
$newContent = @(
    "**/node_modules/"
    "**/bin/"
    "**/obj/"
    "**/packages/"
    "**/.vs/"
    "*.bak"
    "*.zip"
    "*.log"
    "*.lock"
    "package-lock.json"
    ".tfignore"
    "*.txt"
    "*.xlsx"
)
$newContent | Out-File -FilePath $gitignorePath -Encoding UTF8

Write-Host "Staging files (only source files will be staged)..."
git add .

Write-Host "Committing..."
git commit -m "Initial commit"

Write-Host "Pushing to GitHub..." -ForegroundColor Green
git branch -M main
git push -u origin main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nSuccess! Your code is now successfully pushed to GitHub without the massive files or helper scripts!" -ForegroundColor Green
    Pop-Location
    
    # Self-delete this script
    Write-Host "Cleaning up this script..." -ForegroundColor Yellow
    Remove-Item $MyInvocation.MyCommand.Path -Force
} else {
    Write-Host "`nPush failed. Please check the error above." -ForegroundColor Red
    Pop-Location
}

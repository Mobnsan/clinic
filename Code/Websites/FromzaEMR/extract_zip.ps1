$zipPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\2. EMR-Db\FromzaInternationalDB\Dev_FromzaEMR_INT1.zip"
$destPath = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Database\2. EMR-Db\FromzaInternationalDB\extracted"

if (Test-Path $destPath) {
    Remove-Item -Recurse -Force $destPath
}
New-Item -ItemType Directory -Force -Path $destPath | Out-Null
Expand-Archive -Path $zipPath -DestinationPath $destPath -Force
Get-ChildItem -Path $destPath -Recurse | Select-Object FullName

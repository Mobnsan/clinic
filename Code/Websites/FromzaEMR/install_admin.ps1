Start-Process "msiexec.exe" -ArgumentList "/i "C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\SqlLocalDB.msi" /qn IACCEPTSQLLOCALDBLICENSETERMS=YES" -Wait
"DONE" | Out-File "C:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr\Code\Websites\FromzaEMR\install_done.txt"

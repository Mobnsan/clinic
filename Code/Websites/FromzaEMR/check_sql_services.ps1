Get-Service | Where-Object {$_.Name -like 'MSSQL*'} | Select-Object Name, Status, DisplayName

$connString = "Data Source=(localdb)\MSSQLLocalDB; Initial Catalog=DEV_FromzaEMR_INT; Integrated Security=True"
$conn = New-Object System.Data.SqlClient.SqlConnection($connString)
$conn.Open()
$cmd = $conn.CreateCommand()

$cmd.CommandText = "SELECT COUNT(*) FROM MST_Country"
try { Write-Host "MST_Country: " ($cmd.ExecuteScalar()) } catch { Write-Host "MST_Country error: $_" }

$cmd.CommandText = "SELECT COUNT(*) FROM MST_CountrySubDivision"
try { Write-Host "MST_CountrySubDivision: " ($cmd.ExecuteScalar()) } catch { Write-Host "MST_CountrySubDivision error: $_" }

$cmd.CommandText = "SELECT COUNT(*) FROM MST_Municipality"
try { Write-Host "MST_Municipality: " ($cmd.ExecuteScalar()) } catch { Write-Host "MST_Municipality error: $_" }

$conn.Close()

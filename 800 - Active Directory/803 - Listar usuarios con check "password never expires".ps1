# Listado de usuarios del active directory con el check de "la contraseña nunca expira"
Get-ADUser -Filter * -Properties * | select name, passwordneverexpires

# Lo mismo pero exportando la salida a un CSV
Get-ADUser -Filter * -Properties * | select name, passwordneverexpires | export-csv -path c:\temp\password_nunca_expira.csv

# Lo mismo pero con salida en una vista de cuadrícula
Get-ADUser -Filter * -Properties * | select name, passwordneverexpires | Out-GridView

#~Lo mismo pero con un filtro para una UO del AD
Get-ADUser -SearchBase "OU=Usuarios,OU=Madrid,DC=empresa,DC=local" -Filter * -Properties passwordneverexpires | select name, passwordneverexpires


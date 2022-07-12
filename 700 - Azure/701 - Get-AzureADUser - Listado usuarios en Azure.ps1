## OBTENER LISTA DE TODOS LOS USUARIOS DE AD
Get-AzureADUser -all $true

## Filtrado por cadena o patrón en el nombre
Get-AzureADUser -SearchString "admin" 

## Filtrado y selección de un campo en concreto de salida
Get-AzureADUser -SearchString "@contoso.com" | select UserPrincipalName

Get-AzureADUser -SearchString "@contoso.com" | select DisplayName,UserPrincipalName

## Podemos guardarlo en un array
$array_de_usuarios = Get-AzureADUser -SearchString "juan" | select DisplayName,UserPrincipalName

## Escribiendo el nombre del array nos lo muetsra por pantalla
$array_de_usuarios
## o sólo uno o varios elementos del array, empezando en [0]
$array_de_usuarios[3]

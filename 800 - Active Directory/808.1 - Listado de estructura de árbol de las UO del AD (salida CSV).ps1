Import-Module ActiveDirectory

# Creamos un ArrayList (no da problemas con +=)
$resultado = New-Object System.Collections.ArrayList

function Get-OUTreeCSV {
    param (
        [string]$SearchBase,
        [int]$Level = 0
    )

    $ous = Get-ADOrganizationalUnit -Filter * `
        -SearchBase $SearchBase `
        -SearchScope OneLevel |
        Sort-Object Name

    foreach ($ou in $ous) {

        $null = $resultado.Add([PSCustomObject]@{
            Nivel               = $Level
            OU_Indentada        = (' ' * ($Level * 4)) + $ou.Name
            NombreOU            = $ou.Name
            DistinguishedName   = $ou.DistinguishedName
            RutaCanonica        = $ou.CanonicalName
        })

        Get-OUTreeCSV -SearchBase $ou.DistinguishedName -Level ($Level + 1)
    }
}

$domainDN = (Get-ADDomain).DistinguishedName
Get-OUTreeCSV -SearchBase $domainDN

$resultado | Export-Csv ".\AD_Arbol_OU.csv" -NoTypeInformation -Encoding UTF8

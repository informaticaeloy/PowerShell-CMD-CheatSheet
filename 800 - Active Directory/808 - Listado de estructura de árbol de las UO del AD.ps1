function Get-OUTree {
    param (
        [string]$SearchBase,
        [int]$Level = 0
    )

    $ous = Get-ADOrganizationalUnit -Filter * -SearchBase $SearchBase `
        -SearchScope OneLevel | Sort-Object Name

    foreach ($ou in $ous) {
        Write-Host (" " * ($Level * 2)) "+-- " $ou.Name
        Get-OUTree -SearchBase $ou.DistinguishedName -Level ($Level + 1)
    }
}

$domainDN = (Get-ADDomain).DistinguishedName
Write-Host $domainDN
Get-OUTree -SearchBase $domainDN

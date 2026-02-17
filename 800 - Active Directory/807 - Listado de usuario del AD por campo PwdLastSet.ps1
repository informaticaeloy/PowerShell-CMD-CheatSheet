Get-ADUser -Filter "*" -Properties PwdLastSet | Sort-Object Name | 
    Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}} | 
    Export-Csv -Path "c:\temp\test.csv" -NoTypeInformation

# Añadiendo el distinguisedName
Get-ADUser -Filter "*" -Properties PwdLastSet, distinguishedName | Sort-Object Name | 
    Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}}, distinguishedName | 
    Export-Csv -Path "c:\temp\test.csv" -NoTypeInformation

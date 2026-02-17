Get-ADUser -Filter "*" -Properties PwdLastSet | Sort-Object Name | 
    Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}} | 
    Export-Csv -Path "c:\temp\test.csv" -NoTypeInformation

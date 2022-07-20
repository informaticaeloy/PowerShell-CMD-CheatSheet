Get-MsolUser -All | Select-Object UserPrincipalName, DisplayName, Department, UsageLocation, licenses | Sort-Object licenses | ft -GroupBy licenses

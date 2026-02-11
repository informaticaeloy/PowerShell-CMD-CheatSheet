# Obtener el espacio libre de tus discos de forma rápida y legible en PowerShell

'''
Get-Volume | Select-Object DriveLetter, FriendlyName, FileSystemType, 
    @{Name="Total(GB)";Expression={[math]::Round($_.Size / 1GB,2)}},
    @{Name="Libre(GB)";Expression={[math]::Round($_.SizeRemaining / 1GB,2)}},
    HealthStatus | Format-Table -AutoSize
'''
<img width="816" height="243" alt="image" src="https://github.com/user-attachments/assets/bb5caa37-26b9-4a1d-b1e4-f4a778179e76" />
    

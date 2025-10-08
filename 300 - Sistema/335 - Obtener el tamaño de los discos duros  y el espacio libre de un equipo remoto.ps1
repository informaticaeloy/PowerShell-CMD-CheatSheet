    Invoke-Command -ComputerName "nombre_equipo_remoto" -ScriptBlock {
        Get-CimInstance -ClassName Win32_LogicalDisk |
        Select-Object DeviceID,
        @{Name="Size (GB)"; Expression={[math]::Round($_.Size / 1GB, 2)}},
        @{Name="FreeSpace (GB)"; Expression={[math]::Round($_.FreeSpace / 1GB, 2)}}
    }

    

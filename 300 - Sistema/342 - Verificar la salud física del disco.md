## Verificar la "salud" física del disco

#### Si el uso es del 100% pero la velocidad de transferencia es muy baja (pocos KB/s), el disco podría estar fallando físicamente. Compruébalo con:

```
Get-PhysicalDisk | Select-Object FriendlyName, HealthStatus, OperationalStatus
```

<img width="871" height="133" alt="image" src="https://github.com/user-attachments/assets/8f8bea91-a169-4466-9c69-a38636d40f06" />

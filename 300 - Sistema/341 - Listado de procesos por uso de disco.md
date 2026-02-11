## Identificar procesos por uso de disco

### A diferencia de la RAM o CPU, obtener el uso de disco por proceso en PowerShell requiere consultar los contadores de rendimiento. Ejecuta este comando como Administrador para ver qué procesos están leyendo/escribiendo más datos:

```
Get-Counter -Counter "\Proceso(*)\Bytes de lectura de ES/s", "\Proceso(*)\Bytes de escritura de ES/s" -MaxSamples 1 | 
Select-Object -ExpandProperty CounterSamples | 
Sort-Object CookedValue -Descending | 
Select-Object -First 10 InstanceName, @{Name="MB/s";Expression={[math]::Round($_.CookedValue / 1MB, 2)}}
```

<img width="1227" height="342" alt="image" src="https://github.com/user-attachments/assets/016b1afb-3cb4-41ae-9712-fcb4fe418995" />

### Si te da error o tarda mucho en sacar los datos, seguramente será por que los nombres de los contadores tienen otros nombres, debido a idiomas distintos o versiones distintas del sistema operativo. 
### Para ver los nombres reales de tu equipo y usar el comando correctamente, puedes usar el siguiente comando para ver los nombres correctos:

```
Get-Counter -ListSet Proceso | Select-Object -ExpandProperty Paths
```

<img width="943" height="554" alt="image" src="https://github.com/user-attachments/assets/93f0a677-8704-497b-997e-8b30e94252aa" />

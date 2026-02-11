## Listado combinado (RAM y CPU) 

### Si quieres una tabla que muestre ambos valores simultáneamente, puedes usar este comando: 

```
Get-Process | Sort-Object -Property WorkingSet -Descending | Select-Object -First 15 -Property Name, @{Name="CPU(s)";Expression={$_.CPU}}, @{Name="RAM(MB)";Expression={[math]::Round($_.WorkingSet / 1MB, 2)}} | Format-Table -AutoSize

```

<img width="1108" height="440" alt="image" src="https://github.com/user-attachments/assets/7dea37c1-0c92-4bb0-a5aa-265623356ffa" />

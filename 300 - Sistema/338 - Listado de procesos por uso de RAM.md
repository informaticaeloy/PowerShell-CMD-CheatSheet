## Listado por uso de RAM (Memoria) 

###Este comando muestra los 10 procesos que más memoria RAM están consumiendo actualmente, convirtiendo el valor a Megabytes para que sea legible: 

```
Get-Process | Sort-Object -Property WorkingSet -Descending | Select-Object -First 10 -Property Name, @{Name="RAM(MB)";Expression={$_.WorkingSet / 1MB}}, Id
```

<img width="1108" height="373" alt="image" src="https://github.com/user-attachments/assets/8eda102f-7331-4146-92a3-64153dd94411" />

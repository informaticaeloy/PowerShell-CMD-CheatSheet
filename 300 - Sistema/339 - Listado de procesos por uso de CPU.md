## Listado por uso de CPU

### Este comando muestra los 10 procesos con mayor tiempo de procesador acumulado

```
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 -Property Name, CPU, Id
```

<img width="1081" height="275" alt="image" src="https://github.com/user-attachments/assets/ee2ca0aa-de49-45b3-9cf3-7f679971ee45" />

Nota: El valor de CPU en este comando representa el tiempo total del procesador en segundos que el proceso ha utilizado desde que se inició, no necesariamente el porcentaje de uso instantáneo

### Cambiar el nombre del equipo local

Este comando cambia el nombre del equipo local a 'MiEquipo13' y, a continuación, lo reinicia para que el cambio sea efectivo.

```shell
Rename-Computer -NewName "MiEquipo13" -DomainCredential MiDominio\Administrador -Restart
```

### Cambiar el nombre de un equipo remoto

Este comando cambia el nombre del equipo 'MiEquipo13' a 'MiEquipo14'. El equipo no se reinicia.

- El parámetro DomainCredential especifica las credenciales de un usuario que tiene permiso para cambiar el nombre de los equipos del dominio.

- El parámetro Force suprime el mensaje de confirmación.

```shell
Rename-Computer -ComputerName "MiEquipo13" -NewName "MiEquipo14" -DomainCredential MiDominio\Administrador -Force
```

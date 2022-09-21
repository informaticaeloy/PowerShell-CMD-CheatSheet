### IMPORTANTE

Si alguna de las conexiones de Windows está configurada como "pública", Windows deshabilita automáticamente el servicio "resgistro remoto". Para que dicho servicio quede activo, todas las conexiones han de estar configuradas como "privadas"

### Restaurar la configuración de WinRM

Para restaurar la configuración de WinRM a su estado predeterminado, siga estos pasos:

1- Abra una ventana del símbolo del sistema.

2- En el símbolo del sistema, escriba el siguiente comando y presione ENTRAR:

```shell
winrm quickconfig  
```

### Eliminar el agente de escucha de WinRM en el puerto 5985

1- Abra una ventana del símbolo del sistema.

2- En el símbolo del sistema, escriba el siguiente comando y presione ENTRAR para enumerar todos los agentes de escucha que WinRM usa actualmente

```shell
winrm enumerate winrm/config/listener  
```

3- Busque el agente de escucha que tenga los siguientes parámetros y valores:

> Port=5985

> Transport=HTTP

4- Tenga en cuenta el valor que aparece para el parámetro Address del agente de escucha.

5- Escriba el siguiente comando y presione ENTRAR:

```shell
winrm delete winrm/config/Listener? Address= Address +Transport=HTTP
```

En este comando, el marcador de posición Dirección es el valor que anotó en el paso 4.


## Conexión de dispositivos USB a WSL en Windows
### Prerrequisitos
+ Windows 10 o Windows 11
+ WSL instalado y configurado
+ Distribución Linux establecida en WSL2

### Instalar USBIPD
Descargamos el MSI deseado de https://github.com/dorssel/usbipd-win/releases y lo instalamos

### Configuraciones en powershell
+ Abrimos Powershell como administrador
+ Conectamos el dispositivo USB
+ Para listar todos los dispoitivos disponibles en Windows, ejecutamos:

  ```
  usbipd list
  ```
+ Nos fijamos en el BSUID de la salida, que mostrará algo como:
```
BUSID  VID:PID    DEVICE                                STATE
2-4    152d:2329  Dispositivo de almacenamiento USB     Not shared
2-6    8652:a253  Realtek Bluetooth Adapter             Not shared 
```
+ En este caso, nos interesa el marcado como "2-4". Con el comando "bind" lo compartimos:  
```
usbipd bind --busid <busid>
Ej: usbipd bind --busid 2-4
```
+ Lo atachamos al WSL con el comendo "attach"
```
usbipd attach --wsl --busid <busid>
Ej: usbipd attach --wsl --busid 2-4
```
### Uso en WSL
+ Ahora ya podemos usarlo en nuestro WSL. podemos verso por ejemplo iusando el comando "lsusb"
```
lsusb
```
### Desconexión del doispositivo externo del WSL
+ Si queremos desconectar el dispositivo del WSl, podemos hacerlo con el comando "detach":
```
usbipd detach --busid <busid>
Ej: usbipd detach --busid 2-4
```

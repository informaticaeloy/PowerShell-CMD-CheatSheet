### Comprobar estado de BitLocker

#### En el equipo local

```shell
manage-bde.exe -status <volume>
```

<kbd>![image](https://github.com/informaticaeloy/PowerShell-CMD-CheatSheet/assets/20743678/dcbc729a-c066-438c-a5da-f22151286974)</kbd>

#### En un equipo remoto

```shell
manage-bde -status -cn <hostname>
```

```shell
manage-bde -status -cn 192.168.xxx.xxx
```

Si no indicamos nada en el parámetro <volume>, se mostrará el estado de todos los volúmenes

### Descifrado de volúmenes 

#### En el equipo local

```shell
manage-bde.exe -off <volume>
```

#### En un equipo remoto

```shell
manage-bde -off -cn <hostname>
```

```shell
manage-bde -off -cn 192.168.xxx.xxx
```

### Cifrado de volúmenes

#### En el equipo local

```shell
manage-bde.exe -on <volume>
```

#### En un equipo remoto

```shell
manage-bde -off -cn <hostname>
```

```shell
manage-bde -off -cn 192.168.xxx.xxx
```

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

### Descifrado de volúmenes 

#### En el equipo local

```shell
manage-bde.exe -off <volume>
```

#### En un equipo remoto

```shell
manage-bde -off -cn <hostname>
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

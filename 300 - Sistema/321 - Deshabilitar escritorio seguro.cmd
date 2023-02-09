Cambiar clave de registro para escritorio seguro

(si se ejecuta con runas, en equipos de dominio tiene que ser el usuario administrador local o administrador de dominio) 

- Desactivar escritorio seguro
• reg add hklm\software\microsoft\windows\currentversion\policies\system /v promptonsecuredesktop /t REG_DWORD /d 0 /f


- Activar escritorio seguro
• reg add hklm\software\microsoft\windows\currentversion\policies\system /v promptonsecuredesktop /t REG_DWORD /d 1 /f

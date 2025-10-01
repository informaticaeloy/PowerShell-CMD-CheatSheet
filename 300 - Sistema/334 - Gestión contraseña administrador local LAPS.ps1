# Conceder permisos a los administradores de dominio para ver/resetear passwords.
Set-LAPSADResetPasswordPermission -Identity "OU=.." -AllowedPrincipals "DOM\GA_Adm_LAPS_passwordreset_Sede"

# Ejemplo: Set-LAPSADResetPasswordPermission -Identity "OU=OFICINAMADRID,OU=EUROPA,DC=DOM,DC=LOC" -AllowedPrincipals "DOM\GA_Adm_LAPS_passwordreset_Zuera"

# Para ver las contraseñas, podrá utilizar la herramienta “Usuarios y equipos de Aactive Directory” o a través de powershell, con los siguientes comandos.

# (Mostrar contraseña administrador local en un equipo)
Get-LAPSADPassword -Identity COMPUTER -AsPlainText 

# (Mostrar contraseña actual e historial de contrasañas del administrador local en un equipo)
Get-LAPSADPassword COMPUTER -IncludeHistory -AsPlainText 

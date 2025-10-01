# Conceder permisos a los administradores de dominio para ver/resetear passwords.
Set-LAPSADResetPasswordPermission -Identity "OU=.." -AllowedPrincipals "DOM\GA_Adm_LAPS_passwordreset_Sede"

# Ejemplo: Set-LAPSADResetPasswordPermission -Identity "OU=OFICINAMADRID,OU=EUROPA,DC=DOM,DC=LOC" -AllowedPrincipals "DOM\GA_Adm_LAPS_passwordreset_Zuera"

# Para ver las contraseñas, podrá utilizar la herramienta “Usuarios y equipos de Aactive Directory” o a través de powershell, con los siguientes comandos.

# (Mostrar contraseña administrador local en un equipo)
Get-LAPSADPassword -Identity COMPUTER -AsPlainText 

# (Mostrar contraseña actual e historial de contrasañas del administrador local en un equipo)
Get-LAPSADPassword COMPUTER -IncludeHistory -AsPlainText 

# Reset-LAPSPassword (Resetear password, si se tiene permisos)
Invoke-Command -ComputerName COMPUTER -ScriptBlock {Reset-LAPSPassword}

# Resetear contraseña en equipo remoto. (Establece la hora de expiración como la hora actual. En la siguiente evaluación de la polítca, rota la contraseña)
Set-LapsADPasswordExpirationTime -Identity COMPUTER 

# Permisos sobre una OU
Find-LapsADExtendedRights -Identity "OU=.." | fl 

# Fuerza la aplicación de la política sin tener que espera a que cumpla el tiempo de 1h
Invoke-LapsPolicyProcessing 

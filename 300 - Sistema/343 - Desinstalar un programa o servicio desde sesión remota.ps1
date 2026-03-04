# Podemos desinatalar un software o servicio entrando en un equipo remoto

# Primero nos conectamos al equito mediante conexión remota de Powershell
Enter-PSsession -ComputerName <nombre_del_equipo>

# Listamos las aplicaciones con un filtro para identificar el promrama que queremos desinstalar
Get-Package -Provider Programs | Where-Object {$_.Name -like "*texto_a_buscar*"}

# Una vez encontrado lo desinstalamos
Uninstall-Package -Name <nombre_de_la_aplicación_a_desinstalar>

# Si no nos sale, puede que sea por que es un servicio. Listamos los servicios con un filtro para encontrar el deseado:
Get-Service | Where-Object {$_.DisplayName -like "*texto_a_buscar*"}

# Primero paramos el servicio
Stop-Service -Name "servicio_a_parar" -Force
# Luego lo eliminamos
sc.exe delete "servicio_a_eliminar"

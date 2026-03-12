### CSV to XML Zabbix Importer
Script de PowerShell que convierte un archivo CSV en un archivo XML listo para importar equipos en Zabbix.

#### ¿Qué hace?
Lee un archivo CSV con equipos, grupos y plantillas, y genera un XML compatible con la importación masiva de Zabbix. Cada equipo se configura con interfaz SNMP.

#### Formato del CSV
El archivo debe llamarse 111 - CSV to XML Zabbix importer.csv y tener este formato (separado por punto y coma) o modificar el script con tus rutas:

```
nombre;ip;grupo;plantilla
servidor01.dominio.com;192.168.1.10;Servidores;Template OS Linux SNMP
switch01.dominio.com;192.168.1.20;Redes;Template SNMP Generic
```
#### Cómo usarlo
Coloca el archivo CSV en la misma carpeta que el script

Ejecuta el script:
```
.\"111 - CSV to XML Zabbix importer.ps1"
```
Se generará el archivo 111 - CSV to XML Zabbix importer.xml (o el nombre que hayas definido en el script)

#### Importar en Zabbix
El XML generado se importa directamente desde:

Zabbix → Recopilación de datos → Importar

Personalizar comunidad SNMP
Por defecto usa "public". Para cambiarlo, edita esta línea en el script:
```
$SNMP_COMMUNITY = "public"
```

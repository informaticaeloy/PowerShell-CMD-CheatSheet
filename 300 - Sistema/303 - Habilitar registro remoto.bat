# SERVICIO "ESCRITORIO REMOTO"
# Este servicio permite conectarnos a equipos remotos para cambiar, eliminar o agregar claves y valores de registro,
# el cual nos permite conectarnos directamente a las estructuras de registro en otro ordenador usando regedit.

# Activar el autoarranque del servicio 
sc \\<NombreDeEquipo_o_IP> config remoteregistry start= auto

# Arrancar el servicio
sc \\<NombreDeEquipo_o_IP> start remoteregistry

# Para el servicio
sc \\<NombreDeEquipo_o_IP> stop remoteregistry

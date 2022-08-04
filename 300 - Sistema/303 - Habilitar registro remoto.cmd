# SERVICIO "ESCRITORIO REMOTO"
# Este servicio permite conectarnos a equipos remotos para cambiar, eliminar o agregar claves y valores de registro,
# el cual nos permite conectarnos directamente a las estructuras de registro en otro ordenador usando regedit.

# Activar el autoarranque del servicio 
sc \\<NombreDeEquipo_o_IP> config remoteregistry start= auto

# Devuelve algo similar a esto con el resultado:
C:\Users\usuario>sc \\PC-INF019 config remoteregistry start= auto
[SC] ChangeServiceConfig CORRECTO

# Arrancar el servicio
sc \\<NombreDeEquipo_o_IP> start remoteregistry

# Devuelve algo similar a esto con el resultado:
# NOMBRE_SERVICIO: remoteregistry
#         TIPO               : 30  WIN32
#         ESTADO             : 3  STOP_PENDING
#                                 (STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)
#         CÓD_SALIDA_WIN32   : 1066  (0x42a)
#         CÓD_SALIDA_SERVICIO: 0  (0x0)
#         PUNTO_COMPROB.     : 0x2
#         INDICACIÓN_INICIO  : 0xbb8
        
# Para el servicio
sc \\<NombreDeEquipo_o_IP> stop remoteregistry

# Devuelve algo similar a esto con el resultado:
# NOMBRE_SERVICIO: remoteregistry
#         TIPO               : 30  WIN32
#         ESTADO             : 2  START_PENDING
#                                 (NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)
#         CÓD_SALIDA_WIN32   : 0  (0x0)
#         CÓD_SALIDA_SERVICIO: 0  (0x0)
#         PUNTO_COMPROB.     : 0x1
#         INDICACIÓN_INICIO  : 0xbb8
#         PID                : 11584
#         MARCAS         :

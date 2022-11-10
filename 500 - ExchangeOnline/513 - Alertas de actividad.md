### Creación de alertas de actividad en Exchange Online

El siguiente post muestra cómo crear dos alertas con PowerShell en Exchange online para recibir notificaciones por mail cada vez que un usuario de nuestra organización cree una regla en su buzón usando OWA

Sería interesante monitorizar estas alertas, ya que uno de los primeros pasos de un ciberdelincuente cuando compromete una cuenta es crear reglas para reenviar correos a otra cuenta, marcar como leídos los mails que llegan o incluso borrar ciertos mensajes para evitar ser detectados mientras usan nuestro buzón.

* ⚠ IMPORTANTE: Las alertas de actividad han sido ya declaradas obsoletas dentro del panel de Office 365 y Exchange Online

> 📃 Referencia: https://learn.microsoft.com/en-us/microsoft-365/compliance/create-activity-alerts?view=o365-worldwide

> Activity alerts are being deprecated. We recommend that you start using alert policies in the security and compliance center instead of creating new activity alerts. Alert policies provide additional functionality such as the ability to create an alert policy that triggers an alert when any user performs a specified activity, and displaying alerts on the View alerts page in the security and compliance center. For more information, see Alert policies.

Las alertas de actividad no es posible crearlas actualmente a través de entorno gráfico por lo que será necesario crearlas a través de PowerShell

Para ello, en primer lugar deberemos conectarnos al centro de seguridad y cumplimiento

1- :computer: Ejecuta PowerShell ISE como administrador

2- Ahora conéctate al centro de seguridad y cumplimiento siguiendo los pasos indicados en el artículo

> 📃 https://learn.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps

O si conoces su manejo, con el siguiente comando:

```shell
Connect-IPPSSession
```

Una vez conectado deberemos crear 2 reglas de alerta, una para la detección de la creacion y otra para la detección de la modificación. 

```shell
New-ProtectionAlert -Name "NuevaRegla" -NotifyUser user@domain.com -ThreatType Activity -Operation New-InboxRule -Description "Creation of new inbox rule using OWA" -AggregationType None -Category Others
```

```shell
New-ProtectionAlert -Name "ModificacionRegla" -NotifyUser user@domain.com -ThreatType Activity -Operation Set-InboxRule -Description "Modification inbox rule using OWA" -AggregationType None -Category Others
```

Documentación oficial del comando

> 📃 https://learn.microsoft.com/en-us/powershell/module/exchange/new-protectionalert?view=exchange-ps

Una vez creadas podrá visualizarlas aquí:

> :globe_with_meridians: https://compliance.microsoft.com/alertpolicies


Por último y dado que estas alertas están basadas en los registros de auditoría, es importante comprobar que los registros de auditoría están habilitados en la organización y que puedes ver esas actividades registradas en ellos.

> 📃 https://learn.microsoft.com/en-us/microsoft-365/compliance/turn-audit-log-search-on-or-off?view=o365-worldwide

<kbd>![image](https://user-images.githubusercontent.com/20743678/201095758-cf87b8f2-d320-47f6-b5a6-d71de03421d8.png)</kbd>

Si no los tenemos habilitados, podemos hacerlo con el comando:

```shell
set-AdminAuditLogConfig -unifiedauditlogingestionenabled $true
```

<kbd>![image](https://user-images.githubusercontent.com/20743678/201096290-d186265a-e07f-4dd0-a20d-25e7e577016f.png)</kbd>

Puedes revisar estas actividades a través de entorno gráfico en Auditar, dentro de Microsoft Purview

O bien a través de powershell

```shell
Search-UnifiedAuditLog -StartDate 2022/11/02 -EndDate 2022/11/03 -Operations New-InboxRule
```

<kbd>![image](https://user-images.githubusercontent.com/20743678/201098912-5929430d-f900-4047-a4d0-52d00b4f225c.png)</kbd>

> 📃 https://learn.microsoft.com/en-us/powershell/module/exchange/search-unifiedauditlog?view=exchange-ps

Para ejecutar este último comando debes estar conectado a Exchange On Line. Si no lo has hecho anteriormente , sigue estos pasos:

1- :computer: Ejecuta Powershell ISE como administrador

2- :computer: Ejecuta (Haz clic en "sí a todo")

```shell
Set-executionPolicy remotesigned 
```

3- :computer: Ejecuta (Para instalar el módulo)

```shell
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.3
```

4- :computer: Ejecuta (Para importar el módulo)

```shell
Import-Module ExchangeOnlineManagement 
```

5- :computer: Ejecuta (Indica la cuenta de Administrador Global)

```shell
Connect-ExchangeOnline -UserPrincipalName user@domain.com -ShowProgress $true 
```

Las alertas de actividad han sido ya declaradas obsoletas dentro del panel de Office 365 y Exchange Online

> Referencia: https://learn.microsoft.com/en-us/microsoft-365/compliance/create-activity-alerts?view=o365-worldwide

> Activity alerts are being deprecated. We recommend that you start using alert policies in the security and compliance center instead of creating new activity alerts. Alert policies provide additional functionality such as the ability to create an alert policy that triggers an alert when any user performs a specified activity, and displaying alerts on the View alerts page in the security and compliance center. For more information, see Alert policies.

Las alertas de actividad no es posible crearlas actualmente a través de entorno gráfico por lo que será necesario crearlas a través de powershell

Para ello, en primer lugar deberemos conectarnos al centro de seguridad y cumplimiento

1- Ejecute PowerShell ISE como administrador

2- Ahora conéctese al centro de seguridad y cumplimiento siguiendo los pasos indicados en el artículo

> https://learn.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps

Una vez conectado deberemos crear 2 reglas de alerta, una para la deteccion de la creacion y otra para la deteccion de la modificación. 

New-ProtectionAlert -Name "NuevaRegla" -NotifyUser user@domain.com -ThreatType Activity -Operation New-InboxRule -Description "Creation of new inbox rule using OWA" -AggregationType None -Category Others

New-ProtectionAlert -Name "ModificacionRegla" -NotifyUser user@domain.com -ThreatType Activity -Operation Set-InboxRule -Description "Modification inbox rule using OWA" -AggregationType None -Category Others

Documentación oficial del comando

https://learn.microsoft.com/en-us/powershell/module/exchange/new-protectionalert?view=exchange-ps

Una vez creadas podrá visualizarlas aqui:

https://compliance.microsoft.com/alertpolicies


Por último y dado que estas alertas están basadas en los registrios de auditoria, es importante comprobar que los registros de auditoria están habilitados en su organización y que puede ver esas actividades registradas en ellos.

> https://learn.microsoft.com/en-us/microsoft-365/compliance/turn-audit-log-search-on-or-off?view=o365-worldwide

Puede revisar estas actividades a través de entorno gráfico

Auditar: Microsoft Purview

O bien a través de powershell

Search-UnifiedAuditLog -StartDate 2022/11/02 -EndDate 2022/11/03 -Operations New-InboxRule

> https://learn.microsoft.com/en-us/powershell/module/exchange/search-unifiedauditlog?view=exchange-ps

Para ejecutar este último comando debe estar conectado a exchanbge on line. Si no lo ha hecho anteriormente , siga estos pasos:

1-Ejecute Powershell ISE como administrador

2-Ejecute ( Haga clic en "sí a todo")

```shell
Set-executionPolicy remotesigned 
```

3-Ejecute  (Para instalar el modiulo)

```shell
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.3
```

4-Ejecute (Para importar el modulo)

```shell
Import-Module ExchangeOnlineManagement 
```

5-Ejecute (Indique la cuenta de Administrador Global)

```shell
Connect-ExchangeOnline -UserPrincipalName user@domain.com -ShowProgress $true 
```





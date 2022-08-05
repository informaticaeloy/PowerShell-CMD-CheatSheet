(Search-UnifiedAuditLog -UserIds johndoe@contoso.com -StartDate "2022-08-04 00:00:00z" -EndDate "2022-08-04 14:28:00z" ).auditdata | ConvertFrom-Json -ErrorAction SilentlyContinue | Select CreationTime, UserID, LogonError, ClientIP, Operation, ResultStatus
 
 ## Salida:
<# CreationTime : 2022-08-04T00:17:40
  UserId       : johndoe@contoso.com
  LogonError   :
  ClientIP     : 161.75.13.44
  Operation    : UserLoggedIn
  ResultStatus : Success

  CreationTime : 2022-08-04T00:17:40
  UserId       : johndoe@contoso.com
  LogonError   :
  ClientIP     : 122.98.13.14
  Operation    : UserLoggedIn
  ResultStatus : Success
  #>
  
(Search-UnifiedAuditLog -UserIds johndoe@contoso.com -StartDate "2022-08-04 00:00:00z" -EndDate "2022-08-04 14:28:00z" ).auditdata  | ConvertFrom-Json -ErrorAction SilentlyContinue | Select CreationTime, UserID, LogonError, ClientIP, Operation, ResultStatus | Format-Table

## Salida:
<#
CreationTime        UserId                          LogonError                ClientIP     Operation       ResultStatus
------------        ------                          ----------                --------     ---------       ------------
2022-08-04T12:08:41 johndoe@contoso.com                                       172.78.231.9 UserLoggedIn    Success
2022-08-04T12:08:37 johndoe@contoso.com                                       154.44.112.1 UserLoggedIn    Success
2022-08-04T11:34:31 johndoe@contoso.com                                       172.78.231.9 UserLoggedIn    Success
2022-08-04T11:23:21 johndoe@contoso.com                                       154.44.112.1 UserLoggedIn    Success
2022-08-04T09:54:24 johndoe@contoso.com             InvalidUserNameOrPassword 154.44.112.1 UserLoginFailed Failed
2022-08-04T09:19:23 johndoe@contoso.com                                       154.44.112.1 UserLoggedIn    Success
2022-08-04T09:18:51 johndoe@contoso.com             InvalidUserNameOrPassword 154.44.112.1 UserLoginFailed Success
2022-08-04T08:06:58 johndoe@contoso.com                                       154.44.112.1 UserLoggedIn    Success
2022-08-04T07:22:59 johndoe@contoso.com                                       154.44.112.1 UserLoggedIn    Success
2022-08-04T07:17:45 johndoe@contoso.com                                       172.78.231.9 UserLoggedIn    Success
#>

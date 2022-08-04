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

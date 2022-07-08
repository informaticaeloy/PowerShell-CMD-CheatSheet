Get-InboxRule -Mailbox <mail del usuario> | select -Property *

<#
  .OUTPUT
  Enabled                               : True
Identity                              : usuario\165932246589780049
InError                               : False
ErrorType                             : None
Name                                  : Alarma Bascula 
Priority                              : 5
RuleIdentity                          : 165921246689730049
SupportedByTask                       : False
Legacy                                :
BodyContainsWords                     : {}
ExceptIfBodyContainsWords             : {}
FlaggedForAction                      :
ExceptIfFlaggedForAction              :
FromAddressContainsWords              : {}
ExceptIfFromAddressContainsWords      : {}
From                                  : {"correoorigen@contoso.com" [SMTP:correoorigen@contoso.com]}
ExceptIfFrom                          :
HasAttachment                         : False
ExceptIfHasAttachment                 : False
HasClassification                     :
ExceptIfHasClassification             :
HeaderContainsWords                   : {}
ExceptIfHeaderContainsWords           : {}
MessageTypeMatches                    :
ExceptIfMessageTypeMatches            :
MyNameInCcBox                         : False
ExceptIfMyNameInCcBox                 : False
MyNameInToBox                         : False
ExceptIfMyNameInToBox                 : False
MyNameInToOrCcBox                     : False
ExceptIfMyNameInToOrCcBox             : False
MyNameNotInToBox                      : False
ExceptIfMyNameNotInToBox              : False
ReceivedAfterDate                     :
ExceptIfReceivedAfterDate             :
ReceivedBeforeDate                    :
ExceptIfReceivedBeforeDate            :
RecipientAddressContainsWords         : {}
ExceptIfRecipientAddressContainsWords : {}
SentOnlyToMe                          : False
ExceptIfSentOnlyToMe                  : False
SentTo                                :
ExceptIfSentTo                        :
SubjectContainsWords                  : {Bascula  Intermedia Service ping on 192.168.1.151}
ExceptIfSubjectContainsWords          : {}
SubjectOrBodyContainsWords            : {}
ExceptIfSubjectOrBodyContainsWords    : {}
WithImportance                        :
ExceptIfWithImportance                :
WithinSizeRangeMaximum                :
ExceptIfWithinSizeRangeMaximum        :
WithinSizeRangeMinimum                :
ExceptIfWithinSizeRangeMinimum        :
WithSensitivity                       :
ExceptIfWithSensitivity               :
ApplyCategory                         : {}
ApplySystemCategory                   : {}
CopyToFolder                          :
DeleteMessage                         : False
DeleteSystemCategory                  : {}
ForwardAsAttachmentTo                 :
ForwardTo                             :
MarkAsRead                            : False
MarkImportance                        :
MoveToFolder                          :
PinMessage                            : False
RedirectTo                            :
SendTextMessageNotificationTo         : {}
SoftDeleteMessage                     : False
StopProcessingRules                   : False
MailboxOwnerId                        : usernamedelusuario
IsValid                               : True
ObjectState                           : Unchanged

RunspaceId                            : 208eebe2-62d9-43b2-81f2-8c0b7bbc8be1
Description                           : Si el mensaje:
                                                el mensaje se recibió de 'maildelusuario@contoso.com'
                                                e el mensaje incluye palabras específicas en el asunto 'Bascula Intermedia Service ping on 192.168.1.150'

#>

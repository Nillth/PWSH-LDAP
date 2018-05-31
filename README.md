# PWSH-LDAP
LDAP Scripts for PowerShell

LDAP-Query.ps1

Get Users & Groups via LDAP Query, without having to install the AD Powershell Module


.EXAMPLE Groups:

Get-LDAPGroup -Prefix "XXX" 		#Returns All Groups with a Name Starting with XXX

Get-LDAPGroup -Name "YYY" 			#Returns the Group with the Name 'YYY'

Get-LDAPGroup -Name "ZZZ*" 			#Returns All Groups with a Name Starting with 'ZZZ*'

.EXAMPLE Users:

Get-LDAPUser -SAMAccountName Marc 	#Returns the User Account Properties for the Account Marc

Get-LDAPUser -SAMAccountName '*'	#Returns All Accounts in the Active Directory

Get-LDAPUser -SAMAccountName 'svc_' #Returns All Accounts in the Active Directory that start with SVC_


<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.150
	 Created on:   	5/04/2018 8:41 AM
	 Created by:   	Marc Collins
	 Filename:     	LDAP-Query.ps1
	===========================================================================
	.DESCRIPTION
		Get Users & Groups via LDAP Query.
		Without having to install AD Powershell Module

	.EXAMPLE Groups:
		Get-LDAPGroup -Prefix "XXX" 		#Returns All Groups with a Name Starting with XXX
		Get-LDAPGroup -Name "YYY" 			#Returns the Group with the Name 'YYY'
		Get-LDAPGroup -Name "ZZZ*" 			#Returns All Groups with a Name Starting with 'ZZZ*'

	.EXAMPLE Users:
		Get-LDAPUser -SAMAccountName Marc 	#Returns the User Account Properties for the Account Marc
		Get-LDAPUser -SAMAccountName '*'	#Returns All Accounts in the Active Directory
		Get-LDAPUser -SAMAccountName 'svc_' #Returns All Accounts in the Active Directory that start with SVC_

	.LINK
		https://github.com/Nillth/PWSH-LDAP
#>


function Get-LDAPGroup
{
	[CmdletBinding(DefaultParameterSetName = 'GroupName')]
	param
	(
		[Parameter(ParameterSetName = 'GroupPrefix')]
		[string]$Prefix,
		[Parameter(ParameterSetName = 'GroupName')]
		[string]$Name
	)
	
	switch ($PSCmdlet.ParameterSetName)
	{
		GroupPrefix{ $Filter = "(&(objectCategory=group)(cn=$Prefix*))" }
		GroupName{ $Filter = "(&(objectCategory=group)(cn=$Name))" }
	}
	
	$Searcher = New-Object DirectoryServices.DirectorySearcher
	$Searcher.Filter = $Filter
	$FoundGroups = $Searcher.FindAll()
	return $FoundGroups
}

function Get-LDAPUser
{
	param
	(
		[string]$SAMAccountName
	)
	
	$Filter = "(&(objectCategory=User)(samAccountName=$($SAMAccountName)))"
	$Searcher = New-Object DirectoryServices.DirectorySearcher
	$Searcher.Filter = $Filter
	$FoundUser = $Searcher.FindAll()
	$UserEntry = $FoundUser.GetDirectoryEntry()
	return $UserEntry
}


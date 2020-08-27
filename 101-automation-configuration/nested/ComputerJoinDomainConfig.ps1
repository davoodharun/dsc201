<#PSScriptInfo
.VERSION 1.0.0
.GUID a8b9b735-a13d-4901-8edd-a2eb3a589183
.AUTHOR Microsoft Corporation
.COMPANYNAME Microsoft Corporation
.COPYRIGHT (c) Microsoft Corporation. All rights reserved.
.TAGS DSCConfiguration
.LICENSEURI https://github.com/PowerShell/ComputerManagementDsc/blob/master/LICENSE
.PROJECTURI https://github.com/PowerShell/ComputerManagementDsc
.ICONURI
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES First version.
.PRIVATEDATA 2016-Datacenter,2016-Datacenter-Server-Core
#>

#Requires -module ComputerManagementDsc

<#
    .DESCRIPTION
        This configuration sets the machine name to 'Server01' and
        joins the 'Contoso' domain.
        Note: this requires an AD credential to join the domain.
#>
Configuration ComputerJoinDomainConfig
{


    Import-DscResource -Module ComputerManagementDsc
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    $domainCredential = Get-AutomationPSCredential 'Credential'
    Node localhost
    {
        Computer JoinDomain
        {
            Name       = 'Server01'
            DomainName = 'contoso.local'
            Credential = $domainCredential # Credential to join to domain
        }

        RemoteDesktopAdmin RemoteDesktopSettings
        {
            IsSingleInstance   = 'yes'
            Ensure             = 'Present'
            UserAuthentication = 'Secure'
        }
    }
}

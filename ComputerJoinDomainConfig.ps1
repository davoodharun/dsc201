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
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [PSCredential] $DomainMembership_Credential,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String] $DomainMembership_DomainName
    )


    Import-DscResource -Module ComputerManagementDsc
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node localhost
    {
        Computer JoinDomain
        {
            Name       = 'DC'
            DomainName = $DomainMembership_DomainName
            Credential = $DomainMembership_Credential # Credential to join to domain
        }
    }
}

<#
.SYNOPSIS
Search AD and list all DPM servername
.DESCRIPTION
Check all the computerobject that has DPM sub container.
.EXAMPLE
Find-ADDPMServerName "OU=Servers,DC=contoso,DC=com"
#>
param(
    [Parameter(Mandatory=$False, 
        HelpMessage='SearchBase Example: OU=Servers,DC=contoso,DC=com')] 
    [string]$SearchBase
)
Process{
    if(!$script:ADDPMServerNameSearch){
        $script:ADDPMServerNameSearch = New-Object System.DirectoryServices.DirectorySearcher
    }
    if( $SearchBase ){
        $script:ADDPMServerNameSearch.SearchRoot = New-Object DirectoryServices.DirectoryEntry("LDAP://$SearchBase")
    }
    $script:ADDPMServerNameSearch.filter = "(&(objectClass=connectionPoint)(name=MSDPM))"
    $script:ADDPMServerNameSearch.FindAll() | ForEach-Object{
        Write-Host ([string]$_.Path) -replace "LDAP://CN=MSDPM,CN=","" -replace ",.*",""
    }
}
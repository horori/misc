<#
.SYNOPSIS
Sample code to count how many e-mails received per day from redmine_helpdesk log on desktop.
.DESCRIPTION
Sample code to count how many e-mails received per day from redmine_helpdesk log on desktop.
https://www.redmineup.com/pages/plugins/helpdesk
.EXAMPLE
.\Trace-RedmineUPHelpDeskLog.ps1 | Export-CSV -NoTypeInformation "$env:USERPROFILE\Desktop\Result.csv"
#>
param(
    [Parameter(Mandatory=$True, 
        HelpMessage='Path to redmine_helpdesk.log from RedmineUP HelpDesk Plugin')] 
    [string]$LogFile
)
Process{
    $current = $null
    $i = 0

    Get-Content $LogFile | ForEach-Object{
        $logLine = $_
        if( $logLine -match "^\[INFO\] - " ){
            $date = $logLine.Substring(9,6) # Get '22 Jan'
            if( $date -eq $current ){
                $i++
            }else{
                Write-Output "$current, $i" # Output '22 Jan, <E-mail Count>'
                $i = 1
                $current = $date
            }
        }
    }
}

<#
.SYNOPSIS
Parse Redmine ./log/production.log on Windows Client
.DESCRIPTION
Parse Redmine ./log/production.log on Windows Client
.EXAMPLE
.\Trace-RedmineProductionLog.ps1 | Export-CSV -NoTypeInformation "$env:USERPROFILE\Desktop\Result.csv"
#>
param(
    [Parameter(Mandatory=$True, 
        HelpMessage='Path to production.log from Redmine')] 
    [string]$LogFile
)
Process{
    $current = $null
    Get-Content $LogFile | ForEach-Object{
        $line = $_

        #$line = 'Started GET "/redmine/projects/procurement/issues" for 127.0.0.1 at 2016-09-27 13:10:10 +0900'
        #$line = 'Completed 200 OK in 406.2ms (Views: 140.6ms | ActiveRecord: 140.6ms)'

        if( $line -match "^Started " ){
            if( $current ){
                Write-Output $current
            }
            $array = $line -split " "
            $current = [PSCustomObject]@{
                Type = $array[1]
                Query = $array[2] -replace '"'
                For = $array[4]
                Date = $array[6] + " " + $array[7]
                Offset = $array[8]
                Status = ""
                ProcessTime = ""
            }
        }

        if( $line -match "^Completed" ){
            $array = $line -split " "
            if( $current ){
                $current.Status = $array[1]
                $current.ProcessTime = $array[4]
                Write-Output $current
            }else{

            }
        }
    }
}

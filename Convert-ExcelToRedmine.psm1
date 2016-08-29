function Convert-ExcelToRedmine{ 
  <# 
  .SYNOPSIS 
  Convert tab delimited Excel cells to Redmine wiki table 
  .DESCRIPTION 
  Simply replace tab to "|" charactor between the cells.
  .EXAMPLE 
  Convert-ExcelToRedmine @"
  <PASTE EXCEL CELLS HERE>
  "@
  .PARAMETER computername 
  The computer name to query. Just one. 
  .PARAMETER logname 
  The name of a file to write failed computer names to. Defaults to errors.txt. 
  #> 
  [CmdletBinding()] 
  param 
  ( 
    [Parameter(Mandatory=$True, 
    ValueFromPipeline=$True)] 
    [string]$cells
  ) 
  process { 
    $cells.Split("`n")|?{$_.Length-gt1}|%{"| $($_-replace"`t"," | ") |"}
  } 
}

Export-ModuleMember -Function Convert-ExcelToRedmine
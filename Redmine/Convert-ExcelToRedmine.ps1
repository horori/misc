<# 
.SYNOPSIS 
Convert tab delimited Excel cells to Redmine wiki table 
.DESCRIPTION 
Simply replace tab to "|" charactor between the cells.
.EXAMPLE 
Convert-ExcelToRedmine @"
<PASTE EXCEL CELLS HERE>
"@
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


. (Join-Path $PSScriptRoot Apache-logs.ps1)
. (Join-Path $PSScriptRoot parsing_apache_logs.ps1)
clear

findIp -pageVisited 'index.html' -httpCode '200' -browserName 'chrome'
$tableRecords | Format-Table -AutoSize -Wrap 

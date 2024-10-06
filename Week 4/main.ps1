. (Join-Path $PSScriptRoot Apache-logs.ps1)

clear

findIp -pageVisited 'index.html' -httpCode '200' -browserName 'chrome' 

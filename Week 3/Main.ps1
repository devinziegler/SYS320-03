. (Join-Path $PSScriptRoot functions_event_logs.ps1)

clear

$StartStopTable = LoginEvent(15)
$StartStopTable

$StartStopTable = StartShutTime(25)
$StartStopTable

# Get-EventLog System -source Microsoft-Windows-winlogon
Function LoginEvent($days) {

$loginouts = Get-EventLog System -source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$days)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].EventId -eq 7001) {$event="Logon"}
if($loginouts[$i].EventId -eq 7002) {$event="Logoff"}

$id = $loginouts[$i].ReplacementStrings[1]
$SID = New-Object System.Security.Principal.SecurityIdentifier($id)
$user = $SID.Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].EventID; `
                                    "Event" = $event;
                                     "User" = $user.value;                     
                                     }

}
return $loginoutsTable
}

Function StartShutTime{
$startstop = Get-EventLog System -After (Get-Date).AddDays(-30)

$StartStopTable = @()
for ($i=0; $i -lt $startstop.Count; $i++){

$event = ""
if($startstop[$i].EventId -eq 6005) {$event="Startup"}
if($startstop[$i].EventId -eq 6006) {$event="Shutdown"}

$StartStopTable += [pscustomobject]@{"Time" = $startstop[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].EventID; `
                                    "Event" = $event;
                                     "User" = "System"                   
                                     }

return $StartStopTable
}
}



#LoginEvent(30)
StartShutTime

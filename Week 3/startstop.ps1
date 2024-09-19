Function StartShutTime{
$startstop = Get-EventLog System -After (Get-Date).AddDays(-30)

$StartStopTable = @()
for ($i=0; $i -lt $startstop.Count; $i++){

$event = ""
if($startstop[$i].EventId -eq 6005) {$event="Startup"}
if($startstop[$i].EventId -eq 6006) {$event="Shutdown"}

$StartStopTable += [pscustomobject]@{"Time" = $startstop[$i].TimeGenerated; `
                                       "Id" = $startstop[$i].EventID; `
                                    "Event" = $event;
                                     "User" = "System"                   
                                     }

return $StartStopTable
}
}
StartShutTime
# Get-EventLog System -source Microsoft-Windows-winlogon

$loginouts = Get-EventLog System -source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].EventId -eq 7001) {$event="Logon"}
if($loginouts[$i].EventId -eq 7002) {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].EventID; `
                                    "Event" = $event;
                                     "User" = $user;                     
                                     }

}

$loginoutsTable


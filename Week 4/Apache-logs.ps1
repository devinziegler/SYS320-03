Function Test ($pageVisited, $httpCode, $browserName) { 
    
    # Parse the access log based on the given HTTP code
    $httpFilter = Get-Content C:\xampp\apache\logs\access.log | Select-String $httpCode 

    #Define a regex for IP addresses
    $regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"
    
    # Parse $httpFilter for Ips
    $ips = @()
    foreach ($line in $httpFilter){
        if ($line -match $pageVisited -and $line -match $browserName) {
            $address = $regex.Matches($line)
            foreach ($address in $line) {
                $getIP += $address.Value
            }
        }    
    }

    $finalAddresses = @()
    foreach ($ip in $ipsUnorganized) { $ips += [pscustomobject]@{"IP" = $ip }}

    

# Return IP addresses that have visited the given page with http code and browser name
return $finalAddresses | Sort-Object IP | Get-Unique
}

Test -pageVisisted 'index.html' -httpCode '200' -browserName 'chrome'
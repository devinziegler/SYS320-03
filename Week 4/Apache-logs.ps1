Function findIp ($pageVisited, $httpCode, $browserName) { 
    
    # Parse the access log based on the given HTTP code
    $httpFilter = Get-Content C:\xampp\apache\logs\access.log | Select-String $httpCode 

    #Define a regex for IP addresses
    $regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"
    
    # Parse $httpFilter for Ips
    $ips = @()
    foreach ($line in $httpFilter) {
        if ($line -match $pageVisited -and $line -match $browserName) {
            foreach ($address in $regex.Matches($line)) {
                $ips += $address.Value
            }
        }    
    }

    $finalAddresses = @()
    foreach ($ip in $ips) { $finalAddresses += [pscustomobject]@{"IP" = $ip }}

    

    # Return IP addresses that have visited the given page with http code and browser name
    $ipsoftens = $finalAddresses | Where-Object { $_.IP -ilike "10.*"}
    $counts = $ipsoftens | Group IP
    return $counts | Select-Object Count, Name
}


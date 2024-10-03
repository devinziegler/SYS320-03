#Get-Content C:\xampp\apache\logs\access.log

#Get-Content C:\xampp\apache\logs\access.log -tail 5

#Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern ' 404 ',' 400 '

#Get-Content C:\xampp\apache\logs\access.log | Where-Object { $_ -notmatch ' 200 '}

#$A = Get-Childitem C:\xampp\apache\logs\*.log | Select-String 'error'
#$A[-5..-1]

# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

#Define a regex for IP addresses
$regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"

#Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Matches($notfounds)

#Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
    
}
#$ips | Where-Object { $_.IP -ilike "10.*"}

# Count ips from number 8
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*"}
$counts = $ipsoftens | Group IP
$counts | Select-Object Count, Name
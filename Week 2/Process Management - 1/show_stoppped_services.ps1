$stoppedServices = Get-Service | Where-Object {$_.Status -eq "Stopped"}
$stoppedServices

$stoppedServices | Export-Csv -Path stoppedServices


if (Get-Process -Name chrome -ErrorAction ignore) {
    Stop-Process -Name chrome
}
else {
    Start-Process -Filepath "C:\Program Files\Google\Chrome\Application\Chrome" -ArgumentList "Champlain.edu"
}
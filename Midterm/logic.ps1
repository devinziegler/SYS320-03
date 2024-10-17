function getIoc() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.5/IOC.html

    $trs = $page.ParsedHtml.body.GetElementsByTagName("tr")

    $FullTable = @()
    for($i=1; $i -lt $trs.length; $i++) {

        $tds = $trs[$i].getElementsByTagName("td")

        $FullTable += [PSCustomObject]@{
            "Pattern" = $tds[0].innerText; `
            "Description" = $tds[1].innerText; `

        }
    }
    return $FullTable 
}

function getApacheLogs(){
    $logsNotFormatted = Get-Content C:\Users\champuser\Desktop\SYS320-03\Midterm\access.log
    $tableRecords = @()

    for($i=0; $i -lt $logsNotFormatted.Count; $i++) {
        $Words = $logsNotFormatted[$i].split(" ");

        $tableRecords += [PSCustomObject]@{ "IP" = $words[0]; `
                                            "Time" = $words[3].Trim('['); `
                                            "Method" = $words[5].Trim('"'); `
                                            "Page" = $words[6]; `
                                            "Protocol" = $words[7]; `
                                            "Response" = $words[8]; `
                                            "Referrer" = $words[10]; `
                                            "Client" = $words[11];}
    }
    return $tableRecords | Where-Object { $_.IP -like "10.*" }
}

function getIndicator($tableRecords, $indicator) {

    $indicator = $tableRecords | Where-Object { ($_."Page" -match "cmd=*")}  
                                
    return $indicator
}
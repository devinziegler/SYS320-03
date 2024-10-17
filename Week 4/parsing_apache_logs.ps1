﻿function ApacheLogs1(){
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
$tableRecords = Apachelogs1

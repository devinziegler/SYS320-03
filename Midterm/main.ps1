. (Join-Path $PSScriptRoot logic.ps1)

#$fullTable = getIoc
#$fullTable | Select-Object "Pattern", "Description" | Format-Table

$tableRecords = getApacheLogs
#$tableRecords | Format-Table -AutoSize -Wrap

$indicator = getIndicator($tableRecords, "cmd=")
$indicator | Format-Table -Autosize -Wrap
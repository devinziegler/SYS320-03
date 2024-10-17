. (Join-Path $PSScriptRoot logic.ps1)

$fullTable = getIoc

$fullTable | Select-Object "Pattern", "Description" | Format-Table

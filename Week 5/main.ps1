. (Join-Path $PSScriptRoot scraping_champlain_classes.ps1)

# gatherClasses
$output = gatherClasses

$FullTable = daysTranslator($output)

# list all the classes of Instructor Furkin Paligu
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
Where-Object { $_."Instructor" -ilike "Furkan Paligu"}

# List all the classes of JOYCE 310 on Mondays, only display Class Code and Times
# Sort by Start Time
$FullTable = daysTranslator($output)
$FullTable | Where-Object { ( $_.Location -ilike "JOYCE 310") -and ($_.Days -contains "Monday") } | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code"




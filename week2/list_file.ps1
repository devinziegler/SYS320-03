$files=(Get-ChildItem)
for ($j=0; $j -le $files.Count; $j++){

    if ($files[$j].Name -ilike "*ps1"){
        write-host $files[$j].Name
    }
}
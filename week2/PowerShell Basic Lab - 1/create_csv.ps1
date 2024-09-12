
$files=(Get-ChildItem)

$folderpath = "C:\Users\champuser\Documents\Ps1 Files/outfolder/"
$filepath = $folderpath + "out.csv"

$files | Where-Object {$_.Extension -eq ".ps1"} | `
Export-Csv -Path $filePath

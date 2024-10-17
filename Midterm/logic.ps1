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
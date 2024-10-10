$scraped_page = Invoke-WebRequest -URI http://10.0.17.10/ToBeScraped.html

# Get a count of the links in the page
$scraped_page.links.Count

# Display links as HTML Element
$scraped_page.links

#Display Only URL and its text
$scraped_page.Links.Href

# Get Outer text of every element with the tag h2
$h2s=$scraped_page.ParsedHtml.body.GetElementsByTagName("h2") | select outerText

$h2s

# Print innerText of every div element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1
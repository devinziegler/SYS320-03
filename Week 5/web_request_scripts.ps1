$scraped_page = Invoke-WebRequest -URI http://10.0.17.10/ToBeScraped.html

# Get a count of the links in the page
$scraped_page.links.Count

# Display links as HTML Element
$scraped_page.links

#Display Only URL and its text
$scraped_page.Links.Href

# Get Outer tect of every element with the tag h2
$h2s=$scraped_page.ParsedHtml.body.GetElementsByTagName("h2") | where { $_.getAttributeNode("class").Value -ilike "div-3"}

$h2s
#! /bin/bash

# This is the link we will scrape
link="10.0.17.6/IOC.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//html//body//table//tr")

# Processing HTML with sed
# 1- Replacing every </tr> with a line break
 echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g' | \
		     sed -e 's/&#13;//g' | \
		     sed -e 's/<th[^>]*>//g' | \
		     sed -r 's/<\/th>//g' | \
		     awk  -F';' 'NR > 1 && $1 != "" {print $1}' | \
		     sed '/^$/d' > IOC.txt






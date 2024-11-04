#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs() {
	allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function ips() {
	ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

function pageCount() {
	pagesAccessed=$(cat "$file" | cut -d' ' -f7 | tr -d "[" | sort | uniq -c)
}

pageCount
echo"$pagesAccessed"



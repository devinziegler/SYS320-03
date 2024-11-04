#!/bin/bash

# Usage: bash ActiveIPList.bash 10.0.17

[ $# -ne 1 ] && "Usage: $0 <Prefix>" && exit 1

# Prefix is the first input

prefix=$1

# Vefify input lenth
[ ${#prefix} -lt  5  ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {1..254}
do 
         ping -c 1 "$prefix.$i" | grep "bytes from" | \
	 grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
done


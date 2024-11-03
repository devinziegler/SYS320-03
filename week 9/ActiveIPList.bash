#!/bin/bash

# Usage: bash ActiveIPList.bash 10.0.17

[ $# -ne 1] && "Usage: $0 <Prefix>" && exit 1

# Prefix is the first input

prefix=$1

# Vefify input lenth
 15 [ ${#prefix} -lt  5  ] && \
 16 printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
 17 exit 1
 18 
 19 for i in {1..254}
 20 do 
 21         ping -c 1 "$prefix.$i" | grep "success"
 22 done


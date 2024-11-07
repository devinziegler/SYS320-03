#!/bin/bash

# String Length
mystring="Hello World"

echo "${mystring}"
echo "${#mystring}"
echo $((8-"${#mystring}"))


echo "Here in loops:"

for (( i=1; i<=${#mystring}; i++ ));
do
	echo "${mystring:0:$i}"
done

newVarBinary="11011"
newVarDec=$((2#"${newVarBinary}"))
echo "${newVarDec}"

newVarLastTwo="${newVarBinary:0:2}"
echo "${newVarLastTwo}"

echo "Loop Over given"

for i in 1 2 3 4 5 6 
do 
	printf '%02d\n' "${i}"
done


while read id xtra
do 
	let cnt [$id]++
done

echo "${cnt[192.168.241.1]}"
echo "${cnt[@]}"
echo "${!cnt[@]}"




#!/bin/sh
#=========Remarks===========================
#assigning values, only the right-hand side needs $ for variable.

#"if [ $# != 2 ]"is same as "if test $# -ne 2"

#easy way of forloop control:
#for ((i=0;i < $1;i++)) 
#do
#	echo "$2"
#done
#============================================

# check for correct num args
if test $# -ne 2
then
	echo "Usage: ./echon.sh <number of lines> <string>"
	exit
fi

# check for valid args
if test $1 -lt 0
then
	echo "$0: argument 1 must be a non-negative integer"
	exit
fi

count=0
while test $count -lt $1
do
	echo $2
	count=$((count+1)) #Quesiton!what does $(count+1) do??
done

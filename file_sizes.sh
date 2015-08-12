#!/bin/sh 
#==============Remarks====================
#"for file in blah", the list blah can be the 
#   from executed output of `some commands`
#

#word form "-lt" is for numeric comparison

#when assigning values from output of cmd to a variable, 
#no space before or next to =
#
#========================================
sMax=10 
mMax=100 

for file in `ls * | sort -n`
do 
    size=`wc -l < $file`
    if [ $size -lt $sMax ] 
    then 
        small_files="$small_files $file" 
    elif [ `wc -l < $file` -lt $mMax ]
    then 
        medium_files="$medium_files $file" 
    else 
        large_files="$large_files $file" 
    fi 
done

echo "Small files:$small_files"
echo "Medium-sized files:$medium_files"
echo "Large files:$large_files"


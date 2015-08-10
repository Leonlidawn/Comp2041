#!/bin/sh

#=========Remarks===========================
#$@ is by default if $@ is not typed after "read variable"
#tr and sed can do the same job but sed is more convinient in a complicated way.
#sed 's/[0-4]/</g;s/[6-9]/>/g'
#actually the loop is can be omitted since sed or tr is a builtin program which can handle input
#============================================


#read input from stdin
while read input $@
do
	echo $input | tr '012346789' '<<<<<>>>>' 

done

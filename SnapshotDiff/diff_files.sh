#!/bin/bash


##
#	code1=$(mmls -a $first_snap |egrep "Linux" | tr -s " " |cut -f3 -d" ");
#	code2=$(mmls -a $second_snap |egrep "Linux" | tr -s " " |cut -f3 -d" ");
##	fls -r -p -o $code1 $first_snap | tr "*" " " | tr -s " " | cut -f3 -d" " > temp_file1
##	fls -r -p -o $code2 $second_snap | tr "*" " " | tr -s " " | cut -f3 -d" " > temp_file2
#	fls -p -r -o $code1 $first_snap >temp_file1
#	fls -p -r -o $code2 $second_snap >temp_file2
#	diff --suppress-common-lines temp_file1 temp_file2

cd $3

if [ -f temp_file1 ]
then
       rm temp_file1
fi

if [ -f temp_file2 ]
then
      rm temp_file2
fi

for temp_counter in $(mmls -a $1 | tr -s " " |cut -f3 -d" "|tail -n +6)
do
	fls -p -r -o $temp_counter $1 | egrep "home/.*/" | egrep -v "(\/\.)|(realloc)" >>temp_file1
done

 for temp_counter2 in $(mmls -a $2| tr -s " " |cut -f3 -d" "| tail -n +6)
 do
        fls -p -r -o $temp_counter2 $2 | egrep "home/.*/" |egrep -v "(\/\.)|(realloc)"  >>temp_file2
 done

 #END


#!/bin/bash

### Color  Variables
green='\e[32m'
blue='\e[34m'
red='\e[31m'
clear='\e[0m'

### Color Functions

ColorGreen(){
        echo -ne $green$1$clear
}
ColorBlue(){
        echo -ne $blue$1$clear
}
ColorRed(){
        echo -ne $red$1$clear
}

### code
## MD5 si SHA1 pentru img disk-urilor date ca parametri

cd $3
if [ -f sum.txt ]
then
	rm sum.txt
else
md5_1=$(md5sum $1|cut -f1 -d" ");
md5_2=$(md5sum $2|cut -f1 -d" ");
sha1_1=$(sha1sum $1|cut -f1 -d" ");
sha1_2=$(sha1sum $2|cut -f1 -d" ");

echo "$(ColorGreen ''$1'')" >>sum.txt
echo "$(ColorRed 'MD5:  ')$md5_1" >> sum.txt
echo "$(ColorRed 'SHA1: ')$sha1_1" >>sum.txt
echo " " >>sum.txt
echo "$(ColorGreen ''$2'')" >>sum.txt
echo "$(ColorRed 'MD5:  ')$md5_2" >> sum.txt
echo "$(ColorRed 'SHA1: ')$sha1_2" >>sum.txt

fi

#END

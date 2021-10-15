#!/bin/bash

#### Color  Variables
green='\e[32m'
blue='\e[34m'
red='\e[31m'
yellow='\e[33m'
clear='\e[0m'
curr_scripts_path=$(pwd)

#### Color Functions

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}
ColorRed(){
	echo -ne $red$1$clear
}
ColorYellow(){
	echo -ne $yellow$1$clear
}


##################################################################################################################################################################
##################################################################################################################################################################
# 									FUNCTIONALITATI

##
declare -i fisiere_sterse_error=0
function fisiere_sterse()
{
	IFS=$'\n'
	echo "$(ColorBlue 'Fisierele sterse sunt: ')"
	echo " "
	for i in $(cat temp_file1 |cut -f2 -d":"|tr -d '\t')
	do
		if cat temp_file2 | egrep -q "$i$" ;
		then
		echo -ne ""	#nothing
		else
		echo "$i"
		fi
	done
	echo " "
	IFS=" "
	echo -ne "$(ColorGreen 'Inapoi la meniu') [y/n]$(ColorGreen '? ')";
	read c
	case $c in
		y)clear;
			meniu_functionalitati;;
		n)clear;
			exit 0 ;;
		*)fisiere_sterse_error=$fisiere_sterse_error+1;clear; echo -e "$(ColorRed 'Wrong option (+'$fisiere_sterse_error').Choose a valid option!')";fisiere_sterse;;
	esac

}

##
declare -i fisiere_adaugate_error=0
function fisiere_adaugate()
{
	IFS=$'\n'
	echo "$(ColorBlue 'Fisierele adaugate sunt: ')"
	echo " "
        for j in $(cat temp_file2| cut -f2 -d":"|tr -d '\t')
        do
                if cat temp_file1 | egrep -q "$j$" ;
                then
                echo -ne ""     #nothing
                else
                        echo "$j"
                fi
        done
        echo " "
	IFS=" "
        echo -ne "$(ColorGreen 'Inapoi la meniu') [y/n]$(ColorGreen '? ')"
        read d
        case $d in
                y)clear;
                        meniu_functionalitati;;
                n)clear;
                        exit 0 ;;
                *)fisiere_adaugate_error=$fisiere_adaugate_error+1;clear; echo -e "$(ColorRed 'Wrong option (+'$fisiere_adaugate_error').Choose a valid option!')";fisiere_adaugate;;
        esac
}

##
declare -i fisiere_modificate_error=0
function fisiere_modificate()
{
	if [ -f temp_out_file1.txt ]
	then 
		rm temp_out_file1.txt
	fi
	if [ -f temp_out_file2.txt ]
	then 
		rm temp_out_file2.txt
	fi
        IFS=$'\n'
	echo "$(ColorBlue 'Fisierele modificate sunt: ')"
	echo " "
        for i in $(cat temp_file1|cut -f2 -d":"|tr -d '\t')
        do
		if cat temp_file2|grep "r/r" | egrep -q "$i$";
                then
               		innode1=$(cat temp_file1| egrep "$i"| tr '\t' " " |cut -f2 -d" " | tr -d ":")
			innode2=$(cat temp_file2| egrep "$i"| tr '\t' " " |cut -f2 -d" " | tr -d ":")
			for temp_counter in $(mmls -a $first_snap | tr -s " " |cut -f3 -d" "|tail -n +6)
			do
       		        icat -o $temp_counter $first_snap $innode1 1>>temp_out_file1.txt 2>/dev/null
			done
				md5_file1=$(md5sum temp_out_file1.txt|cut -f1 -d" ")
			for temp_counter2 in $(mmls -a $second_snap | tr -s " " |cut -f3 -d" "|tail -n +6)
                        do
                        icat -o $temp_counter2 $second_snap $innode2 1>>temp_out_file2.txt 2>/dev/null
			done
                                md5_file2=$(md5sum temp_out_file2.txt|cut -f1 -d" ")
			if [ "$md5_file1" = "$md5_file2" ];
			then	
			    echo -ne ""
		    else 
			    echo "$i"
                	fi
			
			
		fi
        done
        echo " "
        IFS=" "
        echo -ne "$(ColorGreen 'Inapoi la meniu') [y/n]$(ColorGreen '? ')"
        read c
        case $c in
                y)clear;
                        meniu_functionalitati;;
                n)clear;
                        exit 0 ;;
                *)fisiere_modificate_error=$fisiere_modificate_error+1;clear; echo -e "$(ColorRed 'Wrong option (+'$fisiere_modificate_error').Choose a valid option!')";fisiere_modificate;;
        esac

}

#									      END FUNCTIONALITATI
###################################################################################################################################################################################


###################################################################################################################################################################################
###################################################################################################################################################################################
#									      MENIU FUNCTIONALITATI

declare -i hash_error=0
function back_to_menu_functionalitati()
{
	cat sum.txt
	echo " "
        IFS=" "
	echo -ne "$(ColorGreen 'Inapoi la meniu') [y/n]$(ColorGreen '? ')"
        read c
        case $c in
                y)clear;
                        meniu_functionalitati;;
                n)clear;
                        exit 0 ;;
                *)hash_error=$hash_error+1;clear; echo -e "$(ColorRed 'Wrong option (+'$hash_error').Choose a valid option!')";cat sum.txt; back_to_menu_functionalitati;;
        esac

}

#										END MENIU FUNCTIONALITATI
##################################################################################################################################################################################


##################################################################################################################################################################################
#################################################################################################################################################################################
#										MENIU FUNCTIONALITATI

declare -i menu_error2=0
function meniu_functionalitati()
{
	echo -ne "$(ColorYellow 'Meniu functionalitati')

$(ColorGreen '1)') Fisiere sterse
$(ColorGreen '2)') Fisiere nou adaugate
$(ColorGreen '3)') Fisiere modificate
$(ColorGreen '4)') Valorile hash
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        read b
        case $b in
		0)exit 0;;
                1)clear;
			echo -ne "$(ColorGreen 'Loading....(< 1 min )')"
		       	$curr_scripts_path/diff_files.sh $first_snap $second_snap $path_folder;
			clear;
			fisiere_sterse_error=0;
			fisiere_sterse	;;
		2) clear;
			echo -ne "$(ColorGreen 'Loading....(< 1 min )')"
			$curr_scripts_path/diff_files.sh $first_snap $second_snap $path_folder
		        clear;
			fisiere_adaugate_error=0;
			fisiere_adaugate	;;
		3) clear;
			echo -ne "$(ColorGreen 'Loading....(< 1 min )')"
			$curr_scripts_path/diff_file.sh $first_snap $second_snap $path_folder
			clear;
			fisiere_modificate=0;
			fisiere_modificate;;
		4) clear;
			echo -ne "$(ColorGreen 'Loading....(> 2 min )')"
			$curr_scripts_path/hash_sum.sh $first_snap $second_snap $path_folder
			clear;
			hash_error=0
			back_to_menu_functionalitati ;;
	
                *)menu_error2=$menu_error2+1;clear; echo -e "$(ColorRed 'Wrong option(+'$menu_error2'). Choose a valid option!')"; meniu-functionalitati ;;

        esac

}

#									END MENIU FUNCTIONALITATI
####################################################################################################################################################################################


####################################################################################################################################################################################
####################################################################################################################################################################################
#								      LISTARE SI SELECTIE A SNAPSHOT-URILOR

declare -i alegere_snap_error=1
function alegere_snap()
{
	if [ -f temp.txt ]
	then
	cat temp.txt
	echo ""
	else
	clear;
	echo -e "$(ColorRed 'Folderul '$path_folder' nu are fisiere de tip dd! ')";
	menu
	fi
	echo -e "$(ColorGreen 'Alegeti cele 2 snapshot-uri de comparat!')"

	echo -ne "$(ColorBlue 'Primul (scrieti doar identificatorul): ')"; 
	read id1;
	if cat temp.txt|egrep -q $id1;
	then
	echo -ne "$(ColorBlue 'Al doilea (scrieti doar identificatorul: ')";
	read id2;
	if cat temp.txt|egrep -q $id2;
	then

	
	if [ "$id1" = "$id2" ]
	then
		clear;
		echo -e "$(ColorRed 'Alege snapshot-uri diferite! ')";
		alegere_snap;
	else
		first_snap=$(cat temp.txt| egrep "$id1)" | cut -f2 -d" ");
		second_snap=$(cat temp.txt | egrep "$id2)" | cut -f2 -d" ");
		rm temp.txt
	fi
	clear;
	meniu_functionalitati
	else
	clear;
	echo -e "$(ColorRed 'Nu exista cel putin unul dintre identificatorii alesi(+'$alegere_snap_error')!')";
	alegere_snap_error=$alegere_snap_error+1
        alegere_snap

	fi
	else 
	clear;
	echo -e "$(ColorRed 'Nu exista cel putin unul dintre identificatorii alesi(+'$alegere_snap_error')!')";
       alegere_snap_error=$alegere_snap_error+1
       	alegere_snap
	fi

}

##
function listare_img()
{

cd $path_folder
	if [ -f temp.txt ]
	then
	       rm temp.txt	
	fi
declare -i nr_list_img=1
for i in $(ls $path_folder)
do
	if  file $i|grep -q "boot sector";
	then 
		echo "$nr_list_img) $i" >> temp.txt
		nr_list_img=$nr_list_img+1
	fi
done
clear;
alegere_snap_error=1
alegere_snap
}

#echo ""
#echo "Alegeti 2 snapshot-uri de comparat: "
#echo -ne "Primul snapshot (numarul acestuia): " ; read first_snapshot;
#temp=$(md5sum $first_snapshot | cut -f1 -d" ")
#echo -ne "Al doilea snapshot (numarul acestuia): " ; read second_snapshot;
#temp2=$(md5sum $second_snapshot | cut -f1 -d" ")

#if [ $temp=$temp2 ] 
#then
#	echo "eroare"
#fi


#										END LISTARE SI SELECTIE A SNAPSHOT-URILOR
########################################################################################################################################################################################################
	

########################################################################################################################################################################################################
########################################################################################################################################################################################################
#							           		CITIRE SI CONFIRMARE PATH

declare -i conf_path_error=0
function conf_path()
{
	echo -ne "$(ColorGreen 'Ai introdus path-ul') $path_folder$(ColorGreen ' . Va rog sa confirmati daca este corect')"
	echo -ne " [y/n]: "
        read msg
        case $msg in
               y) listare_img ;;
               n) clear; menu_error=0; menu ;;
	       *)conf_path_error=$conf_path_error+1;clear; echo -e "$(ColorRed 'Wrong option (+'$conf_path_error').Choose a valid option!')";conf_path;;

       esac

}

##
function read_path()
{
echo -ne "$(ColorGreen 'Introdu path-ul catre folderul dorit: ')" ;
                        read path_folder;
                        clear;
                        if [ -d $path_folder ]
                          then
                                funct2_error=0; conf_path;
                          else
                                echo -e "$(ColorRed 'Enter a path to an existing directory!')"; read_path;

                        fi

}

#										END CITIRE SI CONFIRMARE PATH									
#######################################################################################################################################################################################################


#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
#											MENIU INCEPUT

declare -i menu_error=0
menu(){
	
	echo -ne  "$(ColorYellow 'Meniu')

$(ColorGreen '1)') Add Path
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        read a
        case $a in
		1)read_path ;;
		0) exit 0 ;;
		*)menu_error=$menu_error+1;clear; echo -e "$(ColorRed 'Wrong option(+'$menu_error'). Choose a valid option!')"; menu ;;

        esac
}

#									      	         END MENIU INCEPUT
#######################################################################################################################################################################################################
	
#>Start of program:
clear
menu

##########################     END

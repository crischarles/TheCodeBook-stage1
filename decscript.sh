#!/bin/bash
#
############################################################
#created by Crischarles D. Arruda			   #
#							   #
#This script can be applied only for:			   #
# Single Substitution Monoalphabetic Cipher for Pt-Br text #
#							   #
############################################################

#Checking if it is a valid file

if [ -f "$1" ];
then
	echo "File exists"
	validation=$(file $1 | awk -F ': ' '{print $2}' | awk -F ' ' '{print $2}')
	echo $validation
	
	if [[ $validation == "text"* ]];
	then
		echo "valid file"
	else
		echo "invalid file"
	fi	
else
	echo "File doesn't exist"
fi

#Function to count letters from the file
function countletters(){
	
}

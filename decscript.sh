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

#Array with letter by frequency -PtBr
ptbrfr=(a e o s r i d m n t c u l p v g q b f h z j x w k y)

#Function to count letters from the file and sort by highest
function countletters(){
	position=0
	for l in {A..Z};
	do	
		filefr[$position]=$(grep -o "$l" "$1" | wc -l)
		abc[$position]="$l"
		((position++))
	done	
}

function sortletters(){
	#Sorting
	largest=0
	for n in {0..25};
	do 
		if [[ largest -lt ${filefr[$n]} ]];
		then
		       largest=${filefr[$n]}
		       nposition=$n
		fi
	done

	if [[ sposition -lt 26 ]];
	then	
		sabc[$sposition]=${abc[$nposition]}
		sfilefr[$sposition]=$largest
		
		((sposition++))
		
		filefr[$nposition]=0
		sortletters
	fi
}

#Function to decipher the file content
function decfunction(){
	
	decfilepath=/tmp/decfile.txt
	cat "$1" | tr '[:lower:]' '[:upper:]' > $decfilepath
	#decfile=$(cat "$1" | tr '[:lower:]' '[:upper:]')

	for i in {0..25};
	do
		tr "${sabc[$i]}" "${ptbrfr[$i]}" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
		#echo "${sabc[$i]}" "${ptbrfr[$i]}"
	done
	
	#echo $decfile > $decfilepath
}


countletters $1

sposition=0
sortletters

decfunction $1

#Troubleshooting
#echo ${filefr[*]}
#echo ${abc[*]}
#echo "position: $position"
#echo "letter: $l"

echo "sfilefr ${sfilefr[*]}"
echo "sabc ${sabc[*]}"
cat /tmp/decfile.txt


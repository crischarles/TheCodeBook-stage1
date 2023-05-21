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

	#Version 1.0
	for i in {0..25};
	do
		tr "${sabc[$i]}" "${ptbrfr[$i]}" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
		#echo "${sabc[$i]}" "${ptbrfr[$i]}"
	done
	
	#Version 1.1
	#Checking whether the two most frequent letters are in the correct position (A and E), using the word "que"
	#"que" is the most frequent word by far with just 3 letters in PtBr
	
	wordslist=$(cat $decfilepath | tr '[:upper:]' '[:lower:]' | grep -o '\b[a-z]\{3\}\b' | sort | uniq -c | sort -nr)
	worde=$(echo $wordslist | grep -Eo '\b\w+e\b' | head -n 1)
	worda=$(echo $wordslist | grep -Eo '\b\w+a\b' | head -n 1)
	
	#Searching for the letter 'q'
	cutworde=$(echo $worde | cut -c 1)
	cutworda=$(echo $worda | cut -c 1)
	echo "cutworda: " $cutworda
	echo "cutworde: " $cutworde

	countcutworda=$(cat $decfilepath | grep -Eo "\b\w+${cutworda}\b" | wc -l)
	countcutworde=$(cat $decfilepath | grep -Eo "\b\w+${cutworde}\b" | wc -l)
	
	if [ $countcutworda -gt $countcutworde ]
	then
		echo $cutworde " is the letter q"
		wordque=$worde
	else
		echo $cutworda " is the letter q"
		wordque=$worda
	fi

	#################
	#Letter replacement time based on the word "que"
	wordque1=$(echo $wordque | cut -c 1)
	wordque2=$(echo $wordque | cut -c 2)
	wordque3=$(echo $wordque | cut -c 3)
	
	echo "que1: $wordque1"
	echo "que2: $wordque2"
	echo "que3: $wordque3"
	
	tr "q" "+" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
	tr "${wordque1}" "q" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
	tr "+" "${wordque1}" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath

	tr "u" "+" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
        tr "${wordque2}" "u" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
        tr "+" "${wordque2}" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath

        tr "e" "+" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
        tr "${wordque3}" "e" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath
        tr "+" "${wordque3}" < $decfilepath > /tmp/decfiletmp.txt && mv /tmp/decfiletmp.txt $decfilepath

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




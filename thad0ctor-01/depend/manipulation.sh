#!/bin/sh
##min/max GTK##
function f_minmaxGTK () {
	zenity --info  --no-wrap --text "This script will trim a word list down to a minimum and maximum password length.\nKeep in mind the minimum and maximum length for WPA is between 8 and 64 characters"
	min1=$(zenity --scale --min-value=1 --max-value=100 --step=1 --value=8 --title "Min. Password Length" --text "Please enter your minimum password length.")
	max1=$(zenity --scale --min-value=1 --max-value=100 --step=1 --value=64 --title "Max. Password Length" --text "Please enter your maximum password length.")
	wordlistin=$(zenity --file-selection --title "Word list to trim" --text "What word list would you like to trim?")
	while [ ! -e $wordlistin ]
	do
		zenity --info --text "$wordlistin does not exist, let's try that again..."
		wordlistin=$(zenity --file-selection --title "Word list to trim" --text "What word list would you like to trim?")
	done	
	filename=$(zenity --entry --title "Output Word List" --text "What would you like the output word list to be named?\n(The file extension .lst will be appended to the file.")
	destination=$(zenity --file-selection --directory --title "Destination" --text "Where would you like the output word list to be placed?")
	while [ ! -d "$destination" ]
	do
		echo
		zenity --info --text "Directory cannot be found or does not exist"
		zenity --question --title "Create Folder" --text "Would you like to create a folder for the directory you selected?"
		if (( $? == 0 )); then
			destination=$(zenity --file-selection --directory --title "Destination" --text "Where would you like the output word list to be placed?")
			mkdir "$destination"
			while [ ! -d "$destination" ]
			do
				zenity --info --text "Folder: $destination still cannot be found, starting over..."
				f_minmax
			done
		else	
		destination=$(zenity --file-selection --directory --title "Destination" --text "Where would you like the output word list to be placed?")
		fi
	done
	zenity --question --title "Would you like to trim $wordlistin to between $min1 and $max1 characters now? (y/n)"
	if (( $? == 0 )); then
		zenity --info --timeout=4 --text "Trimming word list: $wordlistin"
		pw-inspector -i $wordlistin -o $destination/$filename.lst -m $min1 -M $max1
		if [ -e $destination/$filename.lst ]; then
			zenity --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
			zenity --info --timeout=4 --text "The word list $wordlistin has been successfully trimmed into: $filename.lst"
			zenity --info --timeout=4 --text "Returning to the main menu..."
		else
			zenity --error --text "$filename.lst does not exist in the directory: $destination\nLet's try this again..."
			f_minmax
		fi
	else
		f_menu
	fi
}
##min/max##
function f_minmax () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_minmaxGTK
	else
		echo "This script will trim a word list down to a minimum & maximum password length."
		echo "Keep in mind the minimum and maximum length for WPA is between 8 & 64 characters"
		echo
		echo
		echo
		echo
		sleep 1
		echo "Please enter your minimum password length."
		echo
		read min1
		echo
		sleep 1
		echo "Please enter your maximum password length."
		echo
		read max1
		echo
		sleep 1
		echo "What word list would you like to trim? (e.x. /root/Desktop/word.lst)"
		echo
		read wordlistin
		while [ ! -e $wordlistin ]
		do
			echo
			echo "$wordlistin does not exist, let's try that again..."
			echo
			sleep 1
			echo "What word list would you like to trim? (e.x. /root/Desktop/word.lst)"
			read wordlistin
		done
		echo
		sleep 1
		echo "What would you like the output word list to be named?"
		echo "(The file extension .lst will be appended to the file.)"
		echo
		read filename	
		echo
		sleep 1
		echo "Where would you like the output word list to be placed?"
		echo "(e.x. /root/Desktop/)"
		echo
		read destination
		echo
		while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_minmax
				done
			else	
			sleep 1
			echo "Where would you like the output word list to be placed?"
			echo "(e.x. /root/Desktop/)"
			read destination
			fi
		done
		sleep 1
		echo "Would you like to trim $wordlistin to between $min1 and $max1 characters now? (y/n)"
		echo
		read build
		if [ "$build" = "y" ]; then
			echo
			echo "Trimming word list: $wordlistin"
			pw-inspector -i $wordlistin -o $destination/$filename.lst -m $min1 -M $max1
			if [ -e $destination/$filename.lst ]; then
				echo
				echo "$filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "The word list $wordlistin has been successfully trimmed into: $filename.lst"
				echo
				sleep 2
				echo "Returning to the main menu..."
				sleep 2
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_minmax
			fi
		else
			f_menu
		fi
		
	fi
}
##trim to charset##
function f_charset () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_charsetGTK
	else
		echo "This script will trim a word list down to a certain user-defined charset."
		echo
		echo
		echo
		echo
		echo
		sleep 1
		echo "Please enter your minimum password length."
		echo
		read min1
		echo
		sleep 1
		echo "Please enter your maximum password length."
		echo
		read max1
		sleep 1
		echo "What word list would you like to trim? (e.x. /root/Desktop/word.lst)"
		echo
		read wordlistin
		while [ ! -e $wordlistin ]
		do
			echo
			echo "$wordlistin does not exist, let's try that again..."
			echo
			sleep 1
			echo "What word list would you like to trim? (e.x. /root/Desktop/word.lst)"
			read wordlistin
		done
		echo
		sleep 1
		echo "What would you like the output word list to be named?"
		echo "(The file extension .lst will be appended to the file.)"
		echo
		read filename
		echo
		sleep 1
		echo "Where would you like the output word list to be placed?"
		echo "(e.x. /root/Desktop/)"
		echo
		read destination
		echo
		while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_minmax
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo "What charset would you like to use for your wordlist?"
		echo
		echo "1)  abcedfghijklmnopqrstuvwxyz"
		echo "2)  ABCEDFGHIJKLMNOPQRSTUVWXYZ"
		echo "3)  0123456789"
		echo "4)  All Printable Symbols e.x. $,!,/,(,* etc."
		echo "5)  All Special Characters"
		echo $chars1 and $chars2
		sleep 10
		sleep 1
		echo "Would you like to trim $wordlistin to the charset(s) you selected now? (y/n)"
		echo
		read build
		if [ "$build" = "y" ]; then
			echo
			echo "Trimming word list: $wordlistin"
			$charsettrim
			if [ -e $destination/$filename.lst ]; then
				echo
				echo "$filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "The word list $wordlistin has been successfully trimmed into: $filename.lst"
				echo
				sleep 2
				echo "Returning to the main menu..."
				sleep 2
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_charset
			fi
		else
			f_menu
		fi
		
	fi
}
##tape's WLM##
function f_wlm () {
	f_echobreak
	bash 3rdparty/wlm
	echo $ECHOCOLOR""
}
##sort remove non-printable GTK##
function f_sortGTK () {
		f_echobreak
		zenity --info --timeout=6 --text "About to sort a word list into alphabetical order while sorting\nadditionally sorting out non-printable characters."
		zenity --info --timeout=4 --text "Select the word list you would like to sort."
		infile=$(zenity --file-selection --title "Word list to sort")
		outfile=$(zenity --entry --title "Output Wordlist" --text "What would you like the output word list to be named?\n(The extension .lst will be appended to your selection.)")
		zenity --info --timeout=4 --text "Where would you like $outfile.lst to be placed?"
		destination=$(zenity --file-selection --directory --title "Output word list directory")
		zenity --question --title "Create $outfile.lst" --text "Would you like to go ahead and sort $infile\nto $destination/$outfile.lst"
		if (( $? == 0 )); then
			sort -o "$destination/$outfile".lst "$infile"
			if [ -e "$destination/$outfile".lst ]; then
				zenity --info --timeout=5 --text "$outfile.lst exists in the directory: $destination"
			else
				zenity --info --timeout=5 --text "$outfile.lst does not exist in the directory: $destination\nLet's try this again..."
				f_sortGTK
			fi
		else
			zenity --info --timeout=5 --text "You chose not to sort $infile at this point in time.\nReturning to the main menu..."
		fi
}
##sort remove non-printable##
function f_sort () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_sortGTK
	else
		f_echobreak
		echo "About to sort a word list into alphabetical order while sorting"
		echo "     additionally sorting out non-printable characters."
		echo
		echo "Select the full path to the word list you would like to sort."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read infile
		echo
		echo "What would you like the output word list to be named?"
		echo "(The extension .lst will be appended to your selection.)"
		echo
		read outfile
		echo
		echo "Where would you like $outfile.lst to be placed?"
		echo "(e.x. /root/Desktop)"
		echo
		read destination
			while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_tapes
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo
		echo "Would you like to go ahead and sort $infile"
		echo "to $destination/$outfile.lst (y/n)"
		echo
		read sorter
		if [ "$sorter" = "y" ]; then
			sort -u -o "$destination/$outfile".lst "$infile"
			if [ -e "$destination/$outfile".lst ]; then
				echo
				echo "$outfile.lst exists in the directory: $destination"
				echo
				sleep 3
			else
				echo
				echo "$outfile.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_sort
			fi
		else
			echo "You chose not to sort $infile at this point in time."
			echo
			echo "Returning to the main menu..."
			echo
			sleep 3
		fi
	fi
}
##sort remove non-printable GTK##
function f_uniqGTK () {
		f_echobreak
		zenity --info --timeout=6 --text "About to remove the double up entries from a sorted word list."
		zenity --info --timeout=4 --text "Select the word list you would like to optimize."
		infile=$(zenity --file-selection --title "Word list to optimize")
		outfile=$(zenity --entry --title "Output Wordlist" --text "What would you like the output word list to be named?\n(The extension .lst will be appended to your selection.)")
		zenity --info --timeout=4 --text "Where would you like $outfile.lst to be placed?"
		destination=$(zenity --file-selection --directory --title "Output word list directory")
		zenity --question --title "Create $outfile.lst" --text "Would you like to go ahead and sort $infile\nto $destination/$outfile.lst"
		if (( $? == 0 )); then
			uniq "$infile" "$destination/$outfile".lst
			if [ -e "$destination/$outfile".lst ]; then
				zenity --info --timeout=5 --text "$outfile.lst exists in the directory: $destination"
			else
				zenity --info --timeout=5 --text "$outfile.lst does not exist in the directory: $destination\nLet's try this again..."
				f_sortGTK
			fi
		else
			zenity --info --timeout=5 --text "You chose not to optimize $infile at this point in time.\nReturning to the main menu..."
		fi
}
##sort remove non-printable##
function f_uniq () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_uniqGTK
	else
		f_echobreak
		echo "About to remove the double up entries from a sorted word list."
		echo
		echo "Select the full path to the word list you would like optimize."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read infile
		echo
		echo "What would you like the output word list to be named?"
		echo "(The extension .lst will be appended to your selection.)"
		echo
		read outfile
		echo
		echo "Where would you like $outfile.lst to be placed?"
		echo "(e.x. /root/Desktop)"
		echo
		read destination
			while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_tapes
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo
		echo "Would you like to go ahead and optimize $infile"
		echo "to $destination/$outfile.lst (y/n)"
		echo
		read removedup
		if [ "$removedup" = "y" ]; then
			uniq "$infile" "$destination/$outfile".lst
			if [ -e "$destination/$outfile".lst ]; then
				echo
				echo "$outfile.lst exists in the directory: $destination"
				echo
				sleep 3
			else
				echo
				echo "$outfile.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_sort
			fi
		else
			echo "You chose not to remove the double ups from $infile at this point in time."
			echo
			echo "Returning to the main menu..."
			echo
			sleep 3
		fi
	fi
}
##john mangle gtk##
function f_johngtk () {
	f_echobreak
	zenity --info --timeout=4 --text "About to mangle a word list with john the ripper's rules."
	zenity --info --timeout=4 --text "This script will create about ~50 manipulations for each password\nand may take a good amount of time to complete."
	zenity --info --timeout=4 --text "Please select the word list you would like to use."
	infile=$(zenity --file-selection --title "Word list to mangle")
	zenity --info --timeout=4 --text "Please enter the directory you would like to place to output word list in."
	destination=$(zenity --file-selection --directory --title "Mangled word list destination")
	filename=$(zenity --entry --title "Output file" --text "Please enter the name of output word list.\n(The file extension .lst will be appended to your selection")
	chars=$(zenity --entry --title "Max character length" --text "How many characters would you like to limit the output file to?\n(The maximum WPA length is 64 chars, the minimum is 8)")
	zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and mangle: $infile\nto: $destination/$filename.lst ? (y/n)"
	if (( $? == 0 )); then
		mkdir /usr/share/wordlists/john/'$JOHN'
		cp /usr/share/wordlists/john/*.conf /usr/share/wordlists/john/'$JOHN'
		john --config="/usr/share/wordlists/john/john.conf" --wordlist="$infile" --rules --stdout=$chars | sort -u > "$destination/$filename".lst
		if [ -e $destination/$filename.lst ]; then
			zenity --info --timeout=4 --text "$filename exists in the directory: $destination"
			zenity --info --timeout=4 --text "The word lists $infile been successfully mangled into: $filename.lst"
		else
			zenity --info --timeout=4 --text "$filename.lst does not exist in the directory: $destination\nLet's try this again..."
			f_john
		fi
	else
		zenity --info --timeout=4 --text "You chose not to create $filename.lst at the time.\nReturning to the main menu..."
		f_menu
	fi
}
##john mangle##
function f_john () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_johngtk
	else
		echo "About to mangle a word list with john the ripper's rules."
		echo
		sleep 1
		echo "This script will create about ~50 manipulations for each password,"
		echo "and may take a good amount of time and space to complete."
		echo
		sleep 1
		echo "Please enter the full path to the word list you would like to use."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read infile
		if [ -e "$infile" ]; then
			echo
			echo "$infile exists, proceeding."
			echo
			sleep 2
		else
			echo
			echo "$infile does not exist."
			echo
			sleep 2
			echo "Let's try this again..."
			sleep 2
			f_john
		fi
		echo
		echo "Please enter the directory you would like to place to output word list in."
		echo "(e.x. /root/Desktop)"
		echo
		read destination
		while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_john
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo
		echo "Please enter the name of output word list."
		echo "(The file extension .lst will be appended to your selection.)"
		echo
		read filename
		echo
		echo "How many characters would you like to limit the output file to?"
		echo "(The maximum WPA length is 64 chars, the minimum is 8)"
		echo
		read chars
		echo
		echo "Would you like to go ahead and mangle: $infile"
		echo "to: $destination/$filename.lst ? (y/n)"
		echo
		read create
		if [ "$create" = "y" ]; then
			mkdir /usr/share/wordlists/john/'$JOHN'
			cp /usr/share/wordlists/john/*.conf /usr/share/wordlists/john/'$JOHN'
			john --config="/usr/share/wordlists/john/john.conf" --wordlist="$infile" --rules --stdout=$chars | sort -u | uniq "$destination/$filename".lst
			if [ -e $destination/$filename.lst ]; then
				echo
				echo "$filename exists in the directory: $destination"
				echo
				sleep 1
				echo "The word lists $infile been successfully mangled into: $filename.lst"
				echo
				sleep 3
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 2
				f_john
			fi
		else
			echo
			echo "You chose not to create $filename.lst at the time."
			echo
			echo "Returning to the main menu..."
			echo
			sleep 3
			f_menu
		fi
	fi
}
##split##
function f_splitgtk () {
f_echobreak
infile=$(zenity --file-selection --title "Word list to split" --text "Please select the word list you would like to split.")
zenity --info --timeout=4 --text "Analyzing $infile..."
size1=$(stat --printf="%s" "$infile")
size2=$(( size1 / 1024 | bc ))
size=$(( size2 / 1024 | bc ))
linecount=$(wc -l "$infile" | awk -F " "  '{print$1}')
zenity --info --timeout=8 --text "$infile is $size mb and has $linecount lines of text."
chunks=$(zenity --entry --title "How many segments" --text "How many different chunks would you like to split the file into?\n(The maximum size Aircrack-NG can handle is 2gb)")
lines=$(( linecount / chunks | bc ))
liness=$(( lines + 1 ))
pieces=$(( size / chunks | bc ))
rootname=$(zenity --entry --title "Root name" --text "What would you like the split file's root name to be?\n(e.x. 'rootname_chunk_aa')")
destination=$(zenity --file-selection --directory --title "Destination" --text "Enter the directory you would like the split chunks put into.")
zenity --question --text "You chose to split $infile into\n$chunks pieces of $liness lines with a size of ~$pieces mb\ninto the directory: $destination\nWould you like to proceed with these settings?"
if (( $? == 0 )); then
	split -l $liness $infile $destination/"$rootname"_
	cd $destination
	for i in "$rootname"_* ; do
	echo mv \"$i\" \"$i.lst\" | sh
	done
	zenity --info --timeout=4 --text "Finished splitting $infile into $destination."
	zenity --info --timeout=4 --text "Returning to the main menu..."
	f_menu
else
	zenity --info --timeout=4 --text "You chose not to split $infile at this time.\nReturning to the main menu..."
	f_menu
fi
}
##split##
function f_split () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_splitgtk
else
echo "Please enter full name and path to the word list you would like to split."
echo "(e.x. /root/Desktop/wordlist.lst)"
echo
read infile
echo
echo "Analyzing $infile..."
echo
size1=$(stat --printf="%s" "$infile")
size2=$(( size1 / 1024 | bc ))
size=$(( size2 / 1024 | bc ))
linecount=$(wc -l "$infile" | awk -F " "  '{print$1}')
echo
echo "$infile is $size mb and has $linecount lines of text."
echo
echo "How many different chunks would you like to split the file into?"
echo "(The maximum size Aircrack-NG can handle is 2gb)"
echo
read chunks
lines=$(( linecount / chunks | bc ))
liness=$(( lines + 1 ))
pieces=$(( size / chunks | bc ))
echo
echo "What would you like the split file's root name to be?"
echo "(e.x. rootname_chunk_aa)"
echo
read rootname
echo
echo "Enter the directory you would like the split chunks put into."
echo
read destination
echo
while [ ! -d "$destination" ]
	do
		echo
		echo "Directory cannot be found or does not exist"
		echo
		sleep 1
		echo "Would you like to create a folder for the directory you selected? (y/n)"
		read newdir
		if [ $newdir = "y" ]; then
			mkdir "$destination"
			while [ ! -d "$destination" ]
			do
				echo "Folder: $destination still cannot be found, starting over..."
				sleep 2
				f_split
			done
		else	
			sleep 1
			echo "Where would you like the output word list to be placed?"
			echo "(e.x. /root/Desktop)"
			read destination
		fi
	done
echo
echo "You chose to split $infile into"
echo "$chunks pieces of $liness lines with a size of ~$pieces mb"
echo "into the directory: $destination"
echo
echo "Would you like to proceed with these settings? (y/n)"
echo
read proceed
if [ "$proceed" = "y" ]; then
	echo
	split -l $liness $infile $destination/"$rootname"_
	cd $destination
	for i in "$rootname"_* ; do
	echo mv \"$i\" \"$i.lst\" | sh
	done
	echo
	echo "Finished splitting $infile into $destination."
	sleep 3
	echo
	echo "Returning to the main menu..."
	sleep 3
	f_menu
else
	echo
	echo "You chose not to split $infile at this time."
	echo
	echo "Returning to the main menu..."
	sleep 3
	f_menu
fi
fi
}
##insertgtk##
function f_insertgtk () {
	f_echobreak
	zenity --question --text "Would you like to edit the file in place (y) or create a new word list (n)?"
		if (( $? == 0 )); then
			zenity --info --timeout=4 --text "Please select the word list you would like to insert into."
			infile=$(zenity --file-selection --text "Word list to insert into") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				zenity --info --timeout=4 --text "Please enter the text you would like to insert into."
				insert=$(zenity --entry --title "Text to insert")
				zenity --info --timeout=4 --text "Please enter the character position in each string you would like to insert into."
				pos=$(zenity --entry --title "Position to insert into")
				zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -i -e 's/^\(.\{'$pos'\}\)/\1'$insert'/' "$infile"
				zenity --info --timeout=4 --text "The word list $infile been successfully inserted into."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_insert
			fi
		else
			zenity --info --timeout=4 --text "Please select the word list you would like to insert into."
			infile=$(zenity --file-selection --text "Word list to append") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				outfile=$(zenity --entry --title "Output wordlist" --text "What would you like the output word list to be named?\n(The file extension .lst will be appended to your selection)") 
				destination=$(zenity --file-selection --directory --title "Where would you like to place $outfile.lst?")
				zenity --info --timeout=4 --text "Please enter the text you would like to append."
				insert=$(zenity --entry --title "Text to append")
				zenity --info --timeout=4 --text "Please enter the character position in each string you would like to insert into."
				pos=$(zenity --entry --title "Position to insert into")
				zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -e 's/^\(.\{'$pos'\}\)/\1'$insert'/' "$infile" > "$destination/$outfile".lst
				if [ -e $destination/$outfile.lst ]; then
					zenity --info --timeout=4 --text "$outfile.lst exists in the directory: $destination"
					zenity --info --timeout=4 --text "The word list $infile been successfully inserted into $destination/$outfile.lst"
				else
					zenity --info --timeout=4 --text "$outfile.lst does not exist in the directory: $destination"
					zenity --info --timeout=4 --text "Let's try this again..."
					f_insert
				fi				
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_insert
			fi
		fi
}
##insert##
function f_insert () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_insertgtk
	else
		echo "Would you like to edit the file in place (y) or create a new word list (n)?"
		echo
		read edit
		echo
		if [ "$edit" = "y" ]; then
			echo
			echo "Please enter the word list you would like to insert into."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "Please enter the text you would like to insert."
				echo
				read insert
				echo
				echo "At what character position would you like to insert: $insert?"
				echo
				read pos
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then										
				echo
				sed -i -e 's/^\(.\{'$pos'\}\)/\1'$insert'/' "$infile"
				echo
				echo "The word list $infile been successfully inserted into."
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_insert
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_insert
			fi
		elif [ "$edit" = "n" ]; then
			echo
			echo "Please select the word list you would like to insert into."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "What would you like the output word list to be named?"
				echo "(The file extension .lst will be appended to your selection)"
				echo
				read outfile
				echo
				echo "Where would you like to place $outfile.lst?"
				echo "(e.x. /root/Desktop)"
				echo
				read destination
				while [ ! -d "$destination" ]
				do
					echo
					echo "Directory cannot be found or does not exist"
					echo
					sleep 1
					echo "Would you like to create a folder for the directory you selected? (y/n)"
					read newdir
					if [ $newdir = "y" ]; then
						mkdir "$destination"
						while [ ! -d "$destination" ]
						do
							echo "Folder: $destination still cannot be found, starting over..."
							sleep 2
							f_insert
						done
					else	
						sleep 1
						echo "Where would you like the output word list to be placed?"
						echo "(e.x. /root/Desktop)"
						read destination
					fi
				done
				echo
				echo "Please enter the text you would like to insert."
				echo
				read insert
				echo
				echo "At what character position would you like to insert: $insert?"
				echo
				read pos
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then										
				echo
				sed -e 's/^\(.\{'$pos'\}\)/\1'$insert'/' "$infile" > "$destination/$outfile".lst
				echo
				if [ -e $destination/$outfile.lst ]; then
					echo
					echo "$outfile.lst exists in the directory: $destination"
					echo
					sleep 1
					echo "The word list $infile been successfully inserted into $destination/$outfile.lst"
					echo
					sleep 3
				else
					echo
					echo "$outfile.lst does not exist in the directory: $destination"
					echo
					sleep 2
					echo "Let's try this again..."
					sleep 3
					f_insert
				fi				
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_insert
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_insert
			fi
		else
			echo "You did not enter a correct answer, returning to the main menu..."
			echo
			sleep 5
			f_menu
		fi
	fi
}
##end insert##
##append##
function f_appendgtk () {
	f_echobreak
	zenity --question --text "Would you like to edit the file in place (y) or create a new word list (n)?"
		if (( $? == 0 )); then
			zenity --info --timeout=4 --text "Please select the word list you would like to append to."
			infile=$(zenity --file-selection --text "Word list to append") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				zenity --info --timeout=4 --text "Please enter the text you would like to append."
				zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -i -e 's~$~'"$append"'~' "$infile"
				zenity --info --timeout=4 --text "The word list $infile been successfully appended."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_append
			fi
		else
			zenity --info --timeout=4 --text "Please select the word list you would like to append to."
			infile=$(zenity --file-selection --text "Word list to append") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				outfile=$(zenity --entry --title "Output wordlist" --text "What would you like the output word list to be named?\n(The file extension .lst will be appended to your selection)") 
				destination=$(zenity --file-selection --directory --title "Where would you like to place $outfile.lst?")
				zenity --info --timeout=4 --text "Please enter the text you would like to append."
				append=$(zenity --entry --title "Text to append")
				zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -e 's~$~'"$append"'~' "$infile" > "$destination/$outfile".lst
				zenity --info --timeout=4 --text "The word list $infile been successfully prefixed."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
				if [ -e $destination/$outfile.lst ]; then
					zenity --info --timeout=4 --text "$outfile.lst exists in the directory: $destination"
					zenity --info --timeout=4 --text "The word list $infile been successfully appended into $destination/$outfile.lst"
				else
					zenity --info --timeout=4 --text "$outfile.lst does not exist in the directory: $destination"
					zenity --info --timeout=4 --text "Let's try this again..."
					f_append
				fi				
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_append
			fi
		fi
}
##append##
function f_append () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_appendgtk
	else
		echo "Would you like to edit the file in place (y) or create a new word list (n)?"
		echo
		read edit
		echo
		if [ "$edit" = "y" ]; then
			echo
			echo "Please enter the word list you would like to append to."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "Please enter the text you would like to append."
				echo
				read append
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then										
				echo
				sed -i -e 's~$~'"$append"'~' "$infile"
				echo
				echo "The word list $infile been successfully appended."
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_append
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_append
			fi
		elif [ "$edit" = "n" ]; then
			echo
			echo "Please select the word list you would like to append to."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "What would you like the output word list to be named?"
				echo "(The file extension .lst will be appended to your selection)"
				echo
				read outfile
				echo
				echo "Where would you like to place $outfile.lst?"
				echo "(e.x. /root/Desktop)"
				echo
				read destination
				while [ ! -d "$destination" ]
				do
					echo
					echo "Directory cannot be found or does not exist"
					echo
					sleep 1
					echo "Would you like to create a folder for the directory you selected? (y/n)"
					read newdir
					if [ $newdir = "y" ]; then
						mkdir "$destination"
						while [ ! -d "$destination" ]
						do
							echo "Folder: $destination still cannot be found, starting over..."
							sleep 2
							f_append
						done
					else	
						sleep 1
						echo "Where would you like the output word list to be placed?"
						echo "(e.x. /root/Desktop)"
						read destination
					fi
				done
				echo
				echo "Please enter the text you would like to append."
				echo
				read append
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then	
				echo
				sed -e 's~$~'"$append"'~' "$infile" > "$destination/$outfile".lst
				echo
				if [ -e $destination/$outfile.lst ]; then
					echo
					echo "$outfile.lst exists in the directory: $destination"
					echo
					sleep 1
					echo "The word list $infile been successfully appended into $destination/$outfile.lst"
					echo
					sleep 3
				else
					echo
					echo "$outfile.lst does not exist in the directory: $destination"
					echo
					sleep 2
					echo "Let's try this again..."
					sleep 3
					f_append
				fi				
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_append
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_append
			fi
		else
			echo "You did not enter a correct answer, returning to the main menu..."
			echo
			sleep 5
			f_menu
		fi
	fi
}
##prefixgtk##
function f_prefixgtk () {
	f_echobreak
	zenity --question --text "Would you like to edit the file in place (y) or create a new word list (n)?"
		if (( $? == 0 )); then
			zenity --info --timeout=4 --text "Please select the word list you would like to prefix."
			infile=$(zenity --file-selection --text "Word list to prefix") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				zenity --info --timeout=4 --text "Please enter the text you would like to prefix."
				prefix=$(zenity --entry --title "Text to prefix")
				zenity --question --title "Create $outfile.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -i -e 's~^~'"$prefix"'~' "$infile"
				zenity --info --timeout=4 --text "The word list $infile been successfully prefixed."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_prefix
			fi
		else
			zenity --info --timeout=4 --text "Please select the word list you would like to prefix."
			infile=$(zenity --file-selection --text "Word list to prefix") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				outfile=$(zenity --entry --title "Output wordlist" --text "What would you like the output word list to be named?\n(The file extension .lst will be appended to your selection)") 
				destination=$(zenity --file-selection --directory --title "Where would you like to place $outfile.lst?")
				zenity --info --timeout=4 --text "Please enter the text you would like to prefix."
				prefix=$(zenity --entry --title "Text to prefix")
				zenity --question --title "Create $outfile.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -e 's~^~'"$prefix"'~' "$infile" > "$destination/$outfile".lst
				if [ -e $destination/$outfile.lst ]; then
					zenity --info --timeout=4 --text "$outfile.lst exists in the directory: $destination"
					zenity --info --timeout=4 --text "The word list $infile been successfully prefixed into $destination/$outfile.lst"
				else
					zenity --info --timeout=4 --text "$outfile.lst does not exist in the directory: $destination"
					zenity --info --timeout=4 --text "Let's try this again..."
					f_prefix
				fi				
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_prefix
			fi
		fi
}
##prefix##
function f_prefix () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_prefixgtk
	else
		echo "Would you like to edit the file in place (y) or create a new word list (n)?"
		echo
		read edit
		echo
		if [ "$edit" = "y" ]; then
			echo
			echo "Please enter the word list you would like to prefix."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "Please enter the prefix you would like to use."
				echo
				read prefix
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then	
				echo
				sed -i -e 's~^~'"$prefix"'~' "$infile"
				echo
				echo "The word list $infile been successfully prefixed."
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_prefix
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_prefix
			fi
		elif [ "$edit" = "n" ]; then
			echo
			echo "Please select the word list you would like to prefix."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "What would you like the output word list to be named?"
				echo "(The file extension .lst will be appended to your selection)"
				echo
				read outfile
				echo
				echo "Where would you like to place $outfile.lst?"
				echo "(e.x. /root/Desktop/wordlist.lst)"
				echo
				read destination
				while [ ! -d "$destination" ]
				do
					echo
					echo "Directory cannot be found or does not exist"
					echo
					sleep 1
					echo "Would you like to create a folder for the directory you selected? (y/n)"
					read newdir
					if [ $newdir = "y" ]; then
						mkdir "$destination"
						while [ ! -d "$destination" ]
						do
							echo "Folder: $destination still cannot be found, starting over..."
							sleep 2
							f_prefix
						done
					else	
						sleep 1
						echo "Where would you like the output word list to be placed?"
						echo "(e.x. /root/Desktop/)"
						read destination
					fi
				done
				echo
				echo "Please enter the prefix you would like to use."
				echo
				read prefix
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then	
				echo
				sed -e 's~^~'"$prefix"'~' "$infile" > "$destination/$outfile".lst
				echo
				if [ -e $destination/$outfile.lst ]; then
					echo
					echo "$outfile.lst exists in the directory: $destination"
					echo
					sleep 1
					echo "The word list $infile been successfully prefixed into $destination/$outfile.lst"
					echo
					sleep 3
				else
					echo
					echo "$outfile.lst does not exist in the directory: $destination"
					echo
					sleep 2
					echo "Let's try this again..."
					sleep 3
					f_prefix
				fi				
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_prefix
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_prefix
			fi
		else
			echo "You did not enter a correct answer, returning to the main menu..."
			echo
			sleep 5
			f_menu
		fi
	fi
}
##1337ify##
function f_1337ify () {
	bash 1337ify.sh
	echo $ECHOCOLOR""
	f_menu
}
##lowercasegtk##
function f_invert () {
		zenity --info --timeout=4 --text "About to invert the case of the characters of a word list."
		infile=$(zenity --file-selection --title "Word list to convert" --text "Please select the word list you would like to use.")
		if [ -e "$infile" ]; then
			zenity --info --timeout=4 --text "$infile exists."
			filename=$(zenity --entry --title "Output word list" --text "Enter the name of the output word list you would like to create.\n(The file extension .lst will be appended to your selection.)")
			zenity --info --timeout=4 --text "Please select where you would like to place $filename.lst."
			destination=$(zenity --file-selection --directory --title "Output directory")
			zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $filename.lst?"
			if (( $? == 0 )); then
			zenity --info --timeout=4 --text "About to create $filename.lst in $destination."
			tr -s '[a-z][A-Z]' '[A-Z][a-z]' < "$infile" > "$destination/$filename".lst
			if [ -e "$destination/$filename".lst ]; then
				zenity --info --timeout=4 --text "The word list $filename.lst exists in the directory: $destination"
				zenity --info --timeout=4 --text "Returning to the main menu"
				f_menu
			else
				zenity --info --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
				zenity --info --timeout=4 --text "Let's try this again..."
				f_invert
			fi
			else
				zenity --info --timeout=4 --text "You chose not to create $filename.lst at this time."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			fi
		else
			zenity --info --timeout=4 --text "$infile does not exist."
			zenity --info --timeout=4 --text "Starting over..."
			f_invert
		fi
}
##lowercase##
function f_invert () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_invertgtk
	else
		echo "About to invert the case of the characters of a word list."
		echo
		sleep 2
		echo "Please enter the full name and path of the word list you would like to use."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read infile
		echo
		if [ -e "$infile" ]; then
			echo "$infile exists."
			echo
			echo "Enter the name of the output word list you would like to create."
			echo "(The file extension .lst will be appended to your selection.)"
			echo
			read filename
			echo
			echo "Please enter where you would like to place $filename.lst."
			echo "(e.x. /root/Desktop)"
			echo
			read destination
			echo
			while [ ! -d "$destination" ]
				do
				echo
				echo "Directory cannot be found or does not exist"
				echo
				sleep 1
				echo "Would you like to create a folder for the directory you selected? (y/n)"
				read newdir
				if [ $newdir = "y" ]; then
					mkdir "$destination"
					while [ ! -d "$destination" ]
					do
						echo "Folder: $destination still cannot be found, starting over..."
						sleep 2
						f_invertcase
					done
				else	
					sleep 1
					echo "Please enter where you would like to place $filename.lst."
					echo "(e.x. /root/Desktop)"
					read destination
				fi
			done
			echo "Would you like to go ahead and create $filename.lst? (y/n)"
			echo 
			read create
			if [ "$create" = "y" ]; then
			echo
			echo "About to create $filename.lst in $destination."
			echo
			tr -s '[a-z][A-Z]' '[A-Z][a-z]' < "$infile" > "$destination/$filename".lst
			if [ -e "$destination/$filename".lst ]; then
				echo
				echo "The word list $filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "Returning to the main menu"
				echo
				sleep 3
				f_menu
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_invertcase
			fi
			elif [ "$create" = "n" ]; then
				echo "You chose not to create $filename.lst at this time."
				echo
				sleep 2
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "You did not input a correct answer."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_invert
			fi
		else
			echo "$infile does not exist."
			echo 
			sleep 2
			echo "Starting over..."
			sleep 2
			f_invert
		fi
	fi
}
##lowercasegtk##
function f_lowercasegtk () {
		zenity --info --timeout=4 --text "About to convert the uppercase chars of a word list into lowercase chars."
		infile=$(zenity --file-selection --title "Word list to convert" --text "Please select the word list you would like to use.")
		if [ -e "$infile" ]; then
			zenity --info --timeout=4 --text "$infile exists."
			filename=$(zenity --entry --title "Output word list" --text "Enter the name of the output word list you would like to create.\n(The file extension .lst will be appended to your selection.)")
			zenity --info --timeout=4 --text "Please select where you would like to place $filename.lst."
			destination=$(zenity --file-selection --directory --title "Output directory")
			zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $filename.lst?"
			if (( $? == 0 )); then
			zenity --info --timeout=4 --text "About to create $filename.lst in $destination."
			tr '[:upper:]' '[:lower:]' < "$infile" > "$destination/$filename".lst
			if [ -e "$destination/$filename".lst ]; then
				zenity --info --timeout=4 --text "The lowercase word list $filename.lst exists in the directory: $destination"
				zenity --info --timeout=4 --text "Returning to the main menu"
				f_menu
			else
				zenity --info --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
				zenity --info --timeout=4 --text "Let's try this again..."
				f_uppercase
			fi
			else
				zenity --info --timeout=4 --text "You chose not to create $filename.lst at this time."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			fi
		else
			zenity --info --timeout=4 --text "$infile does not exist."
			zenity --info --timeout=4 --text "Starting over..."
			f_uppercase
		fi
}
##lowercase##
function f_lowercase () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_lowercasegtk
	else
		echo "About to convert the uppercase chars of a word list into lowercase chars."
		echo
		sleep 2
		echo "Please enter the full name and path of the word list you would like to use."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read infile
		echo
		if [ -e "$infile" ]; then
			echo "$infile exists."
			echo
			echo "Enter the name of the output word list you would like to create."
			echo "(The file extension .lst will be appended to your selection.)"
			echo
			read filename
			echo
			echo "Please enter where you would like to place $filename.lst."
			echo "(e.x. /root/Desktop)"
			echo
			read destination
			echo
			while [ ! -d "$destination" ]
				do
				echo
				echo "Directory cannot be found or does not exist"
				echo
				sleep 1
				echo "Would you like to create a folder for the directory you selected? (y/n)"
				read newdir
				if [ $newdir = "y" ]; then
					mkdir "$destination"
					while [ ! -d "$destination" ]
					do
						echo "Folder: $destination still cannot be found, starting over..."
						sleep 2
						f_uppercase
					done
				else	
					sleep 1
					echo "Please enter where you would like to place $filename.lst."
					echo "(e.x. /root/Desktop)"
					read destination
				fi
			done
			echo "Would you like to go ahead and create $filename.lst? (y/n)"
			echo 
			read create
			if [ "$create" = "y" ]; then
			echo
			echo "About to create $filename.lst in $destination."
			echo
			tr '[:upper:]' '[:lower:]' < "$infile" > "$destination/$filename".lst
			if [ -e "$destination/$filename".lst ]; then
				echo
				echo "The lowercase word list $filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "Returning to the main menu"
				echo
				sleep 3
				f_menu
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_uppercase
			fi
			elif [ "$create" = "n" ]; then
				echo "You chose not to create $filename.lst at this time."
				echo
				sleep 2
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "You did not input a correct answer."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_uppercase
			fi
		else
			echo "$infile does not exist."
			echo 
			sleep 2
			echo "Starting over..."
			sleep 2
			f_lowercase
		fi
	fi
}
##uppercasegtk##
function f_uppercasegtk () {
		zenity --info --timeout=4 --text "About to convert the lower case chars of a word list into upper case chars."
		infile=$(zenity --file-selection --title "Word list to convert" --text "Please select the word list you would like to use.")
		if [ -e "$infile" ]; then
			zenity --info --timeout=4 --text "$infile exists."
			filename=$(zenity --entry --title "Output word list" --text "Enter the name of the output word list you would like to create.\n(The file extension .lst will be appended to your selection.)")
			zenity --info --timeout=4 --text "Please select where you would like to place $filename.lst."
			destination=$(zenity --file-selection --directory --title "Output directory")
			zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $filename.lst?"
			if (( $? == 0 )); then
			zenity --info --timeout=4 --text "About to create $filename.lst in $destination."
			tr '[:lower:]' '[:upper:]' < "$infile" > "$destination/$filename".lst
			if [ -e "$destination/$filename".lst ]; then
				zenity --info --timeout=4 --text "The uppercase word list $filename.lst exists in the directory: $destination"
				zenity --info --timeout=4 --text "Returning to the main menu"
				f_menu
			else
				zenity --info --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
				zenity --info --timeout=4 --text "Let's try this again..."
				f_uppercase
			fi
			else
				zenity --info --timeout=4 --text "You chose not to create $filename.lst at this time."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			fi
		else
			zenity --info --timeout=4 --text "$infile does not exist."
			zenity --info --timeout=4 --text "Starting over..."
			f_uppercase
		fi
}
##uppercase##
function f_uppercase () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_uppercasegtk
	else
		echo "About to convert the lower case chars of a word list into upper case chars."
		echo
		sleep 2
		echo "Please enter the full name and path of the word list you would like to use."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read infile
		echo
		if [ -e "$infile" ]; then
			echo "$infile exists."
			echo
			echo "Enter the name of the output word list you would like to create."
			echo "(The file extension .lst will be appended to your selection.)"
			echo
			read filename
			echo
			echo "Please enter where you would like to place $filename.lst."
			echo "(e.x. /root/Desktop)"
			echo
			read destination
			echo
			while [ ! -d "$destination" ]
				do
				echo
				echo "Directory cannot be found or does not exist"
				echo
				sleep 1
				echo "Would you like to create a folder for the directory you selected? (y/n)"
				read newdir
				if [ $newdir = "y" ]; then
					mkdir "$destination"
					while [ ! -d "$destination" ]
					do
						echo "Folder: $destination still cannot be found, starting over..."
						sleep 2
						f_uppercase
					done
				else	
					sleep 1
					echo "Please enter where you would like to place $filename.lst."
					echo "(e.x. /root/Desktop)"
					read destination
				fi
			done
			echo "Would you like to go ahead and create $filename.lst? (y/n)"
			echo 
			read create
			if [ "$create" = "y" ]; then
			echo
			echo "About to create $filename.lst in $destination."
			echo
			tr '[:lower:]' '[:upper:]' < "$infile" > "$destination/$filename".lst
			if [ -e "$destination/$filename".lst ]; then
				echo
				echo "The uppercase word list $filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "Returning to the main menu"
				echo
				sleep 3
				f_menu
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_uppercase
			fi
			elif [ "$create" = "n" ]; then
				echo "You chose not to create $filename.lst at this time."
				echo
				sleep 2
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "You did not input a correct answer."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_uppercase
			fi
		else
			echo "$infile does not exist."
			echo 
			sleep 2
			echo "Starting over..."
			sleep 2
			f_uppercase
		fi
	fi
}
##determine output##
function f_determineout () {
	if [ "$outtype" = "abc" ]; then
		one="one"
		two="two"
		three="three"
		four="four"
		five="five"
		six="six"
		seven="seven"
		eight="eight"
		nine="nine"
		zero="zero"
	elif [ "$outtype" = "ABC" ]; then
		one="ONE"
		two="TWO"
		three="THREE"
		four="FOUR"
		five="FIVE"
		six="SIX"
		seven="SEVEN"
		eight="EIGHT"
		nine="NINE"
		zero="ZERO"
	elif [ "$outtype" = "Abc" ]; then
		one="One"
		two="Two"
		three="Three"
		four="Four"
		five="Five"
		six="Six"
		seven="Seven"
		eight="Eight"
		nine="Nine"
		zero="Zero"
	elif [ "$outtype" = "AbC" ]; then
		one="OnE"
		two="TwO"
		three="ThReE"
		four="FoUr"
		five="FiVe"
		six="SiX"
		seven="SeVeN"
		eight="EiGhT"
		nine="NiNe"
		zero="ZeRo"
	elif [ "$outtype" = "aBc" ]; then
		one="oNe"
		two="tWo"
		three="tHrEe"
		four="fOuR"
		five="fIvE"
		six="sIx"
		seven="sEvEn"
		eight="eIgHt"
		nine="nInE"
		zero="zErO"
	fi
}
##convert numbers##
function f_numberconvgtk () {
	zenity --info --timeout=4 --text "About to convert numbers into words."
	infile=$(zenity --file-selection --title "Word list to modify" --text "Please select the word list to modify.")
	if [ -e "$infile" ]; then
		zenity --info --timeout=4 --text "$infile exists."
		outtype=$(zenity --list --checklist --title "Output type" --text "Select the output format to use.\n(Select one format at a time)" --height=220 --column "Select" --column "Output Format" FALSE 'abc' FALSE 'ABC' FALSE 'Abc' FALSE 'AbC' FALSE 'aBc')
		f_determineout
		zenity --question --title "Create word list" --text "Would you like to edit the file in place (y) or create a new wordlist (n)?"
		if (( $? == 0 )); then
			zenity --question --title "Modify word list" --text "Would you like to go ahead and convert numbers into words\nin $infile (y/n)"
			if (( $? == 0 )); then
				zenity --info --timeout=4 --text "Modifying $infile..."
				sed -i -e 's/1/'"$one"'/g' "$infile"
				sed -i -e 's/2/'"$two"'/g' "$infile"
				sed -i -e 's/3/'"$three"'/g' "$infile"
				sed -i -e 's/4/'"$four"'/g' "$infile"
				sed -i -e 's/5/'"$five"'/g' "$infile"
				sed -i -e 's/6/'"$six"'/g' "$infile"
				sed -i -e 's/7/'"$seven"'/g' "$infile"
				sed -i -e 's/8/'"$eight"'/g' "$infile"
				sed -i -e 's/9/'"$nine"'/g' "$infile"
				sed -i -e 's/0/'"$zero"'/g' "$infile"
				if [ -e "$infile" ]; then
					zenity --info --timeout=4 --text "The modified word list $infile exists"
					zenity --info --timeout=4 --text "Returning to the main menu"
					f_menu
				else
					zenity --info --timeout=4 --text "$infile does not exist"
					zenity --info --timeout=4 --text "Let's try this again..."
					f_numberconv
				fi
			else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			fi
		else
			filename=$(zenity --entry --title "Output word list" --text "Input the filename of the outut word list you would like to create.\n(The file extension .lst will be appended to your selection.)")
			destination=$(zenity --file-selection --directory --title "Output word list destination" --text "Where would you like $filename.lst to be placed?")
			zenity --question --title "Modify word list" --text "Would you like to go ahead and convert numbers into words\ninto $destination/$filename.lst? (y/n)"
			if (( $? == 0 )); then
				zenity --info --timeout=4 --text "Modifying $infile..."
				sed -e 's/1/'"$one"'/g' "$infile" > temp1.temp
				sed -e 's/2/'"$two"'/g' temp1.temp > temp2.temp
				sed -e 's/3/'"$three"'/g' temp2.temp > temp1.temp
				sed -e 's/4/'"$four"'/g' temp1.temp > temp2.temp
				sed -e 's/5/'"$five"'/g' temp2.temp > temp1.temp
				sed -e 's/6/'"$six"'/g' temp1.temp > temp2.temp
				sed -e 's/7/'"$seven"'/g' temp2.temp > temp1.temp
				sed -e 's/8/'"$eight"'/g' temp1.temp > temp2.temp
				sed -e 's/9/'"$nine"'/g' temp2.temp > temp1.temp
				sed -e 's/0/'"$zero"'/g' temp1.temp > "$destination/$filename".lst
				rm -r *.temp
				if [ -e "$destination/$filename".lst ]; then
					zenity --info --timeout=4 --text "The modified word list $filename.lst exists in the directory: $destination"
					zenity --info --timeout=4 --text "Returning to the main menu"
					f_menu
				else
					zenity --info --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
					zenity --info --timeout=4 --text "Let's try this again..."
					f_numberconv
				fi
			else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			fi
		fi
	else
		zenity --info --timeout=4 --text "$infile does not exist."
		zenity --info --timeout=4 --text "Let's try this again..."
		zenity --info --timeout=4 --text "Starting over..."
		f_numberconv
	fi
}
##convert numbers##
function f_numberconv () {
	if [ "$GTK" = "y" ]; then
		f_numberconvgtk
	else
	echo "About to convert numbers to words in a word list."
	echo
	sleep 2
	echo "Please enter the full name and path of the word list to modify."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	read infile
	echo
	if [ -e "$infile" ]; then
		echo "$infile exists."
		echo
		echo "Please select the word format you would like to use"
		echo
		echo "1) abc"
		echo "2) ABC"
		echo "3) Abc"
		echo "4) AbC"
		echo "5) aBc"
		echo
		read format
		echo
		if [ "$format" = "1" ]; then
			outtype="abc"
		elif [ "$format" = "2" ]; then
			outtype="ABC"	
		elif [ "$format" = "3" ]; then
			outtype="Abc"
		elif [ "$format" = "4" ]; then
			outtype="AbC"
		elif [ "$format" = "5" ]; then
			outtype="aBc"
		else
			echo "You did not enter a correct selection!"
			echo
			sleep 2
			echo "Starting over..."
			echo
			f_numberconv
		fi
		f_determineout
		echo "Would you like to edit the file in place (y) or create a new wordlist (n)?(y/n)"
		echo
		read modify
		echo
		if [ "$modify" = "y" ]; then		
			echo "Would you like to go ahead and convert numbers to words?"
			echo "in $infile? (y/n)"
			echo
			read create
			if [ "$create" = "y" ]; then
				echo "Modifying $infile..."
				echo
				sed -i -e 's/1/'"$one"'/g' "$infile"
				sed -i -e 's/2/'"$two"'/g' "$infile"
				sed -i -e 's/3/'"$three"'/g' "$infile"
				sed -i -e 's/4/'"$four"'/g' "$infile"
				sed -i -e 's/5/'"$five"'/g' "$infile"
				sed -i -e 's/6/'"$six"'/g' "$infile"
				sed -i -e 's/7/'"$seven"'/g' "$infile"
				sed -i -e 's/8/'"$eight"'/g' "$infile"
				sed -i -e 's/9/'"$nine"'/g' "$infile"
				sed -i -e 's/0/'"$zero"'/g' "$infile"
				if [ -e "$destination/$filename".lst ]; then
					echo "The modified word list $filename.lst exists in the directory: $destination"
					echo
					sleep 2
					echo "Returning to the main menu"
					echo
					sleep 3
					f_menu
				else
					echo "$filename.lst does not exist in the directory: $destination"
					echo
					sleep 2
					echo "Let's try this again..."
					echo
					sleep 3
					f_numberconv
				fi
			elif  [ "$create" = "n" ]; then
				echo "You chose not to modify $infile at this time."
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "You did not enter a correct answer."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_numberconv
			fi
		else
			echo "Input the filename of the outut word list you would like to create."
			echo "(The file extension .lst will be appended to your selection.)"
			echo
			read filename
			echo
			echo "Where would you like $filename.lst to be placed?"
			echo "(e.x. /root/Desktop)"
			echo
			read destination
			while [ ! -d "$destination" ]
			do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_numberconv
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
			done
			echo
			echo "Would you like to go ahead convert the numbers into words"
			echo "in $infile into $destination/$filename.lst? (y/n)"
			echo
			read create
			if [ "$create" = "y" ]; then
				echo "Modifying $infile..."
				echo
				sed -e 's/1/'"$one"'/g' "$infile" > temp1.temp
				sed -e 's/2/'"$two"'/g' temp1.temp > temp2.temp
				sed -e 's/3/'"$three"'/g' temp2.temp > temp1.temp
				sed -e 's/4/'"$four"'/g' temp1.temp > temp2.temp
				sed -e 's/5/'"$five"'/g' temp2.temp > temp1.temp
				sed -e 's/6/'"$six"'/g' temp1.temp > temp2.temp
				sed -e 's/7/'"$seven"'/g' temp2.temp > temp1.temp
				sed -e 's/8/'"$eight"'/g' temp1.temp > temp2.temp
				sed -e 's/9/'"$nine"'/g' temp2.temp > temp1.temp
				sed -e 's/0/'"$zero"'/g' temp1.temp > "$destination/$filename".lst
				rm -r *.temp
				if [ -e "$destination/$filename".lst ]; then
					echo
					echo "The modified word list $filename.lst exists in the directory: $destination"
					echo
					sleep 2
					echo "Returning to the main menu"
					echo
					sleep 3
					f_menu
				else
					echo
					echo "$filename.lst does not exist in the directory: $destination"
					echo
					sleep 2
					echo "Let's try this again..."
					sleep 3
					f_numberconv
				fi
			elif  [ "$create" = "n" ]; then
				echo "You chose not to modify $infile at this time."
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "You did not enter a correct answer."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_numberconv
			fi
		fi
	else
		echo "$infile does not exist."
		echo
		sleep 2
		echo "Let's try this again..."
		echo
		echo "Starting over..."
		echo
		sleep 2
		f_numberconv
	fi
fi
}
##remove / replace##
function f_replacegtk () {
	zenity --info --timeout=4 --text "About to remove / replace a character(s) in a word list."
	infile=$(zenity --file-selection --title "Word list to modify" --text "Please enter the full name and path of the word list to modify.")
	if [ -e "$infile" ]; then
		zenity --info --timeout=4 --text "$infile exists."
		replace=$(zenity --entry --text "Characters to remove/replace" --text "Please enter the character/set of characters to remove/replace.")
		zenity --question --title "Create word list" --text "Would you like to edit the file in place (y) or create a new wordlist (n)?"
		if (( $? == 0 )); then
			remove=$(zenity --entry --title "Replacement text" --text "Please enter the text you would like to replace '$replace' with.\n(Leave this empty if you would prefer to remove $replace entirely.)")
			zenity --question --title "Modify word list" --text "Would you like to go ahead and modfiy all instances of '$replace'\nin $infile with '$remove'?"
			if (( $? == 0 )); then
				zenity --info --timeout=4 --text "Modifying $infile..."
				sed -i -e 's/'"$replace"'/'"$remove"'/g' "$infile"
			else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			fi
		else
			filename=$(zenity --entry --title "Output word list" --text "Input the filename of the outut word list you would like to create.\n(The file extension .lst will be appended to your selection.)")
			destination=$(zenity --file-selection --directory --title "Output word list destination" --text "Where would you like $filename.lst to be placed?")
			remove=$(zenity --entry --title "Text to replace with" --text "Please enter the text you would like to replace '$replace' with.\n(Leave this empty if you would prefer to remove $replace entirely.)")
			zenity --question --title "Modify word list" --text "Would you like to go ahead and modfiy all instances of '$replace'\nin $infile with '$remove' into $destination/$filename.lst? (y/n)"
			if (( $? == 0 )); then
				zenity --info --timeout=4 --text "Modifying $infile..."
				sed -e 's/'"$replace"'/'"$remove"'/g' "$infile" > "$destination/$filename".lst
				if [ -e "$destination/$filename".lst ]; then
					zenity --info --timeout=4 --text "The modified word list $filename.lst exists in the directory: $destination"
					zenity --info --timeout=4 --text "Returning to the main menu"
					f_menu
				else
					zenity --info --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
					zenity --info --timeout=4 --text "Let's try this again..."
					f_replace
				fi
			else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			fi
		fi
	else
		zenity --info --timeout=4 --text "$infile does not exist."
		zenity --info --timeout=4 --text "Let's try this again..."
		zenity --info --timeout=4 --text "Starting over..."
		f_replace
	fi
}
##remove / replace##
function f_replace () {
	if [ "$GTK" = "y" ]; then
		f_replacegtk
	else
	echo "About to remove / replace a character(s) in a word list."
	echo
	sleep 2
	echo "Please enter the full name and path of the word list to modify."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	read infile
	echo
	if [ -e "$infile" ]; then
		echo "$infile exists."
		echo
		echo "Please enter the character/set of characters to remove/replace."
		echo
		read replace
		echo
		echo "Would you like to edit the file in place (y) or create a new wordlist (n)?(y/n)"
		echo
		read modify
		echo
		if [ "$modify" = "y" ]; then
			echo "Please enter the text you would like to replace '$replace' with."
			echo "(Leave this empty if you would prefer to remove '$replace' entirely.)"
			echo
			read remove
			echo
			echo "Would you like to go ahead and modfiy all instances of '$replace'"
			echo "in $infile with '$remove'? (y/n)"
			echo
			read create
			if [ "$create" = "y" ]; then
				echo "Modifying $infile..."
				echo
				sed -i -e 's/'"$replace"'/'"$remove"'/g' "$infile"
			elif  [ "$create" = "n" ]; then
				echo "You chose not to modify $infile at this time."
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "You did not enter a correct answer."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_replace
			fi
		else
			echo "Input the filename of the outut word list you would like to create."
			echo "(The file extension .lst will be appended to your selection.)"
			echo
			read filename
			echo
			echo "Where would you like $filename.lst to be placed?"
			echo "(e.x. /root/Desktop)"
			echo
			read destination
			while [ ! -d "$destination" ]
			do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_replace
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
			done
			echo
			echo "Please enter the text you would like to replace '$replace' with."
			echo "(Leave this empty if you would prefer to remove '$replace' entirely.)"
			echo
			read remove
			echo
			echo "Would you like to go ahead and modfiy all instances of $replace"
			echo "in $infile with '$remove' into $destination/$filename.lst? (y/n)"
			echo
			read create
			if [ "$create" = "y" ]; then
				echo "Modifying $infile..."
				echo
				sed -e 's/'"$replace"'/'"$remove"'/g' "$infile" > "$destination/$filename".lst
				if [ -e "$destination/$filename".lst ]; then
					echo
					echo "The modified word list $filename.lst exists in the directory: $destination"
					echo
					sleep 1
					echo "Returning to the main menu"
					echo
					sleep 3
					f_menu
				else
					echo
					echo "$filename.lst does not exist in the directory: $destination"
					echo
					sleep 1
					echo "Let's try this again..."
					sleep 1
					f_replace
				fi
			elif  [ "$create" = "n" ]; then
				echo "You chose not to modify $infile at this time."
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "You did not enter a correct answer."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_replace
			fi
		fi
	else
		echo "$infile does not exist."
		echo
		sleep 2
		echo "Let's try this again..."
		echo
		echo "Starting over..."
		echo
		sleep 2
		f_replace
	fi
fi
}
##conver to ascii gtk##
function f_asciigtk () {
	zenity --info --timeout=5 --text "About to remove non-ASCII characters from a word list."
	zenity --info --timeout=5 --text "Please select the word list to purge."
	inputfile=$(zenity --file-selection --title "File to purge of non-ASCII")
	filename=$(zenity --entry --title "Output word list" --text "What would you like the output word list to be named?\n(The file extension .lst will be added to your selection.)")
	zenity --info --timeout=5 --text "Where would you like to place $filename.lst?"
	destination=$(zenity --file-selection --directory --title "Output word list destination")
	zenity --question --title "Convert to ASCII charaters" --text "Would you like to go ahead and convert $inputfile ($format)\ninto $destination/$filename.lst (ASCII)?"
	format=$(file "$inputfile" | grep "$inputfile" | awk -F " " '{print$2}')
	if (( $? == 0 )); then
		iconv -f "$format" -t US-ASCII//TRANSLIT "$inputfile" -o "$destination"/"$filename".lst
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=5 --text "$filename.lst exists in $destination"
			zenity --info --timeout=5 --text "Successfully converted $inputfile to just ASCII characters."
			zenity --info --timeout=5 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=5 --text "$filename.lst does not exist in $destination."
			zenity --info --timeout=5 --text "Starting over..."
			f_ascii
		fi
	else
		zenity --info --timeout=5 --text "You chose not to convert $inputfile at this time."
		zenity --info --timeout=5 --text "Returning to the main menu..."
		sleep 2
	fi
}
##convert to ascii##
function f_ascii () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_asciigtk
else
	echo "About to convert a word list to just ASCII characters."
	echo
	sleep 2
	echo "Please enter the full name and path of the word list to convert."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	read inputfile
	echo
	if [ -e "$inputfile" ]; then
		echo "$inputfile exists"
		echo
		sleep 2
	else
		echo "$inputfile does not exist."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_ascii
	fi
	sleep 1
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be added to your selection.)"
	echo
	read filename
	echo
	sleep 1
	echo "Where would you like to place $filename.lst?"
	echo "(e.x. /root/Desktop)"
	echo 
	read destination
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_ascii
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
	done
	echo
	format=$(file "$inputfile" | grep "$inputfile" | awk -F " " '{print$2}')
	echo "Would you like to go ahead and convert $inputfile ($format)"
	echo "into $destination/$filename.lst (ASCII)? (y/n)?"
	echo
	read convert
	if [ "$convert" = "y" ]; then
		iconv -f "$format" -t US-ASCII//TRANSLIT "$inputfile" -o "$destination"/"$filename".lst
		if [ -e "$destination"/"$filename".lst ]; then
			echo
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully converted $inputfile to ASCII"
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "$filename.lst does not exist in $destination."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_ascii
		fi
	elif [ "$convert" = "n" ]; then
		echo "You chose not to convert $inputfile at this time."
		echo
		sleep 2
		echo "Returning to the main menu..."
		echo
		sleep 2
	else
		echo "You did not input a correct answer."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_ascii
	fi
fi
}
##remove nonascii gtk##
function f_remasciigtk () {
	zenity --info --timeout=5 --text "About to remove non-ASCII characters from a word list."
	zenity --info --timeout=5 --text "Please select the word list to purge."
	inputfile=$(zenity --file-selection --title "File to purge of non-ASCII")
	filename=$(zenity --entry --title "Output word list" --text "What would you like the output word list to be named?\n(The file extension .lst will be added to your selection.)")
	zenity --info --timeout=5 --text "Where would you like to place $filename.lst?"
	destination=$(zenity --file-selection --directory --title "Output word list destination")
	zenity --question --title "Purge non-ASCII charaters" --text "Would you like to go ahead and purge non-ASCII characters\nfrom $inputfile into $destination/$filename.lst?"
	if (( $? == 0 )); then
		tr -cd '\11\12\40-\176' < $inputfile > "$destination"/"$filename".lst
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=5 --text "$filename.lst exists in $destination"
			zenity --info --timeout=5 --text "Successfully removed $inputfile of non-ASCII characters."
			zenity --info --timeout=5 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=5 --text "$filename.lst does not exist in $destination."
			zenity --info --timeout=5 --text "Starting over..."
			f_remascii
		fi
	else
		zenity --info --timeout=5 --text "You chose not to purge $inputfile at this time."
		zenity --info --timeout=5 --text "Returning to the main menu..."
		sleep 2
	fi
}
##remove nonascii##
function f_remascii () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_remasciigtk
else
	echo "About to remove non-ASCII characters from a word list."
	echo
	sleep 2
	echo "Please enter the full name and path of the word list to purge."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	read inputfile
	echo
	if [ -e "$inputfile" ]; then
		echo "$inputfile exists"
		echo
		sleep 2
	else
		echo "$inputfile does not exist."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_remascii
	fi
	sleep 1
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be added to your selection.)"
	echo
	read filename
	echo
	sleep 1
	echo "Where would you like to place $filename.lst?"
	echo "(e.x. /root/Desktop)"
	echo 
	read destination
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_remascii
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
	done
	echo
	echo "Would you like to go ahead and purge non-ASCII characters"
	echo "from $inputfile into $destination/$filename.lst? (y/n)?"
	echo
	read convert
	if [ "$convert" = "y" ]; then
		tr -cd '\11\12\40-\176' < $inputfile > "$destination"/"$filename".lst
		if [ -e "$destination"/"$filename".lst ]; then
			echo
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully removed $inputfile of non-ASCII characters."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "$filename.lst does not exist in $destination."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_remascii
		fi
	elif [ "$convert" = "n" ]; then
		echo "You chose not to purge $inputfile at this time."
		echo
		sleep 2
		echo "Returning to the main menu..."
		echo
		sleep 2
	else
		echo "You did not input a correct answer."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_remascii
	fi
fi
}
##reversegtk##
function f_reversegtk () {
	zenity --info --timeout=6 --text "About to reverse the characters of a word list."
	zenity --info --timeout=6 --text "Please select the word list to reverse."
	inputfile=$(zenity --file-selection --title "Input word list." --text "Please select the word list to reverse.")
	filename=$(zenity --entry --title "Output word list" --text "What would you like the output word list to be named?\n(The file extension .lst will be added to your selection.)")
	zenity --info --timeout=6 --text "Where would you like to place $filename.lst?"
	destination=$(zenity --file-selection --directory --title "Word list location")
	zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and reverse the characters of\n$inputfile into $destination/$filename.lst?"
	if (( $? == 0 )); then
		cat "$inputfile" | rev > "$destination"/"$filename".lst 
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=4 --text "$filename.lst exists in $destination"
			zenity --info --timeout=4 --text "Successfully reverseed $inputfile."
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=4 --text "$filename.lst does not exist in $destination."
			zenity --info --timeout=4 --text "Starting over..."
			f_reverse
		fi
	else
		zenity --info --timeout=4 --text "You chose not to reverse $inputfile at this time."
		zenity --info --timeout=4 --text "Returning to the main menu..."
	fi
}
##reverse##
function f_reverse () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_reversegtk
else
	echo "About to reverse the characters of a word list."
	echo
	sleep 2
	echo "Please enter the full name and path of the word list to reverse."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	read inputfile
	echo
	if [ -e "$inputfile" ]; then
		echo "$inputfile exists"
		echo
		sleep 2
	else
		echo "$inputfile does not exist."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_reverse
	fi
	sleep 1
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be added to your selection.)"
	echo
	read filename
	echo
	sleep 1
	echo "Where would you like to place $filename.lst?"
	echo "(e.x. /root/Desktop)"
	echo 
	read destination
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_reverse
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
	done
	echo
	echo "Would you like to go ahead and reverse the characters of"
	echo "$inputfile into $destination/$filename.lst? (y/n)?"
	echo
	read convert
	if [ "$convert" = "y" ]; then
		cat "$inputfile" | rev > "$destination"/"$filename".lst 
		if [ -e "$destination"/"$filename".lst ]; then
			echo
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully reversed $inputfile."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "$filename.lst does not exist in $destination."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_reverse
		fi
	elif [ "$convert" = "n" ]; then
		echo "You chose not to reverse $inputfile at this time."
		echo
		sleep 2
		echo "Returning to the main menu..."
		echo
		sleep 2
	else
		echo "You did not input a correct answer."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_reverse
	fi
fi
}
##double up lines##
function f_dupgtk () {
	zenity --info --timeout=6 --text "About to double up the lines of a word list."
	zenity --info --timeout=6 --text "Please select the word list you would like to mirror.\n(It must not have any non-ASCII characters)"
	inputfile=$(zenity --file-selection --title "Input word list." --text "Please select the word list to double up.")
	filename=$(zenity --entry --title "Output word list" --text "What would you like the output word list to be named?\n(The file extension .lst will be added to your selection.)")
	zenity --info --timeout=6 --text "Where would you like to place $filename.lst?"
	destination=$(zenity --file-selection --directory --title "Word list location")
	zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and double up the lines of\n$inputfile into $destination/$filename.lst?"
	if (( $? == 0 )); then
		cat "$inputfile" > "$destination"/temp.temp
		cp "$inputfile" "$destination"/temp1.temp
		paste "$destination"/temp1.temp "$destination"/temp.temp | sed 's/'"	"'//' | cat > "$destination"/"$filename".lst	
		rm "$destination"/temp.temp
		rm "$destination"/temp1.temp
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=4 --text "$filename.lst exists in $destination"
			zenity --info --timeout=4 --text "Successfully double up $inputfile."
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=4 --text "$filename.lst does not exist in $destination."
			zenity --info --timeout=4 --text "Starting over..."
			f_dup
		fi
	else
		zenity --info --timeout=4 --text "You chose not to double up $inputfile at this time."
		zenity --info --timeout=4 --text "Returning to the main menu..."
		f_menu
	fi
}
##mirror##
function f_dup () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_dupgtk
else
	echo "About to double up the lines of a word list."
	echo
	sleep 2
	echo "Please enter the full name and path of the word list to mirror."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	read inputfile
	echo
	if [ -e "$inputfile" ]; then
		echo "$inputfile exists"
		echo
		sleep 2
	else
		echo "$inputfile does not exist."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_dup
	fi
	sleep 1
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be added to your selection.)"
	echo
	read filename
	echo
	sleep 1
	echo "Where would you like to place $filename.lst?"
	echo "(e.x. /root/Desktop)"
	echo 
	read destination
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_dup
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
	done
	echo
	echo "Would you like to go ahead and double up the lines of"
	echo "$inputfile into $destination/$filename.lst? (y/n)?"
	echo
	read convert
	if [ "$convert" = "y" ]; then
		cat "$inputfile" > "$destination"/temp.temp
		cp "$inputfile" "$destination"/temp1.temp
		paste "$destination"/temp1.temp "$destination"/temp.temp | sed 's/'"	"'//' | cat > "$destination"/"$filename".lst	
		rm "$destination"/temp.temp
		rm "$destination"/temp1.temp
		if [ -e "$destination"/"$filename".lst ]; then
			echo
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully mirrored $inputfile."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "$filename.lst does not exist in $destination."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_dup
		fi
	elif [ "$convert" = "n" ]; then
		echo "You chose not to mirror $inputfile at this time."
		echo
		sleep 2
		echo "Returning to the main menu..."
		echo
		sleep 2
		f_menu
	else
		echo "You did not input a correct answer."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_dup
	fi
fi
}
##mirrorgtk##
function f_mirrorgtk () {
	zenity --info --timeout=6 --text "About to mirror the lines of a word list."
	zenity --info --timeout=6 --text "Please select the word list you would like to mirror.\n(It must not have any non-ASCII characters)"
	inputfile=$(zenity --file-selection --title "Input word list." --text "Please select the word list to mirror.")
	filename=$(zenity --entry --title "Output word list" --text "What would you like the output word list to be named?\n(The file extension .lst will be added to your selection.)")
	zenity --info --timeout=6 --text "Where would you like to place $filename.lst?"
	destination=$(zenity --file-selection --directory --title "Word list location")
	zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and mirror the lines of\n$inputfile into $destination/$filename.lst?"
	if (( $? == 0 )); then
		cat "$inputfile" | rev > "$destination"/temp.temp
		cp "$inputfile" "$destination"/temp1.temp
		paste "$destination"/temp1.temp "$destination"/temp.temp | sed 's/'"	"'//' | cat > "$destination"/"$filename".lst	
		rm "$destination"/temp.temp
		rm "$destination"/temp1.temp
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=4 --text "$filename.lst exists in $destination"
			zenity --info --timeout=4 --text "Successfully mirrored $inputfile."
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=4 --text "$filename.lst does not exist in $destination."
			zenity --info --timeout=4 --text "Starting over..."
			f_mirror
		fi
	else
		zenity --info --timeout=4 --text "You chose not to mirror $inputfile at this time."
		zenity --info --timeout=4 --text "Returning to the main menu..."
		f_menu
	fi
}
##mirror##
function f_mirror () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_mirrorgtk
else
	echo "About to mirror the lines of a word list."
	echo
	sleep 2
	echo "Please enter the full name and path of the word list to mirror."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	read inputfile
	echo
	if [ -e "$inputfile" ]; then
		echo "$inputfile exists"
		echo
		sleep 2
	else
		echo "$inputfile does not exist."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_mirror
	fi
	sleep 1
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be added to your selection.)"
	echo
	read filename
	echo
	sleep 1
	echo "Where would you like to place $filename.lst?"
	echo "(e.x. /root/Desktop)"
	echo 
	read destination
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_mirror
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
	done
	echo
	echo "Would you like to go ahead and mirror the lines of"
	echo "$inputfile into $destination/$filename.lst? (y/n)?"
	echo
	read convert
	if [ "$convert" = "y" ]; then
		cat "$inputfile" | rev > "$destination"/temp.temp
		cp "$inputfile" "$destination"/temp1.temp
		paste "$destination"/temp1.temp "$destination"/temp.temp | sed 's/'"	"'//' | cat > "$destination"/"$filename".lst	
		rm "$destination"/temp.temp
		rm "$destination"/temp1.temp
		if [ -e "$destination"/"$filename".lst ]; then
			echo
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully mirrored $inputfile."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "$filename.lst does not exist in $destination."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_mirror
		fi
	elif [ "$convert" = "n" ]; then
		echo "You chose not to mirror $inputfile at this time."
		echo
		sleep 2
		echo "Returning to the main menu..."
		echo
		sleep 2
		f_menu
	else
		echo "You did not input a correct answer."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_mirror
	fi
fi
}
##single word mangler gtk##
function f_manglewordgtk () {
	zenity --info --timeout=5 --text "About to manipulate a single word into an entire word list."
	mangleword=$(zenity --entry --title "Word to manipulate" --text "What word would you like to manipulate?\n(The word must be under 20 characters.)")
	filename=$(zenity --entry --title "Output word list" --text "What would you like to name $mangleword's word list?\n(The file extension .lst will be added to your entry)")
	zenity --info --timeout=5 --text "Where would you like to place $filename.lst"
	destination=$(zenity --file-selection --directory --title "$filename.lst location")
	zenity --question --text "Would you like to go ahead and make $filename.lst in $destination?"
	if (( $? == 0 )); then
		zenity --info --timeout=5 --text "About to create $filename.lst in $destination from $mangleword."
		python 3rdparty/SWMT.py -s "$mangleword" "$destination"/"$filename".lst
		echo $ECHOCOLOR""
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=5 --text "$filename.lst exists in $destination"
			zenity --info --timeout=5 --text "Successfully created a word list for $mangleword"
			zenity --info --timeout=5 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=5 --text "$filename.lst does not exist in $destination"
			zenity --info --timeout=5 --text "Starting over..."
			f_mangleword
		fi
	else
		zenity --info --timeout=5 --text "You chose not to create $filename.lst at this time."
		zenity --info --timeout=5 --text "Returning to the main menu..."
		f_menu
	fi
}
##single word mangler##
function f_mangleword () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_manglewordgtk
else
	echo "About to manipulate a single word into an entire word list."
	echo
	sleep 2
	echo "What word would you like to manipulate?"
	echo "(The word must be under 20 characters.)"
	echo
	read mangleword
	echo
	echo "What would you like to name $mangleword's word list?"
	echo "(The file extension .lst will be added to your entry)"
	echo
	read filename
	echo
	echo "Where would you like to place $filename.lst"
	echo "(e.x. /root/Desktop)"
	echo
	read destination
	echo
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_mangleword
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
	done
	echo
	echo "Would you like to go ahead and make $filename.lst in $destination? (y/n)"
	echo
	read create
	echo
	if [ "$create" = "y" ]; then
		echo "About to create $filename.lst in $destination from $mangleword."
		echo
		sleep 2
		python 3rdparty/SWMT.py -s "$mangleword" "$destination"/"$filename".lst
		echo $ECHOCOLOR""
		echo
		if [ -e "$destination"/"$filename".lst ]; then
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully created a word list for $mangleword"
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "$filename.lst does not exist in $destination"
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_mangleword
		fi
	elif [ "$create" = "n" ]; then
		echo "You chose not to create $filename.lst at this time."
		echo
		sleep 2
		echo "Returning to the main menu..."
		echo
		sleep 2
		f_menu
	else
		echo "You did not select a correct answer."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_mangleword
	fi
fi
}
## remove blank and comments ##
function f_removegtk () {
	zenity --info --timeout=5 --text "About to remove the blank and commented lines from a word list."
	zenity --question --title "Modify or create" --text "Would you like to edit the file in space (y) or create a new file (n)?"
	if (( $? == 0 )); then
		echo
		zenity --info --timeout=5 --text "Select the word list to modify."
		filename=$(zenity --file-selection --title "Word list to modify")
		zenity --question --title "Modify $filename" --text "Would you like to go ahead and modify $filename? (y/n)"
		if (( $? == 0 )); then
			zenity --info --timeout=5 --text "About to remove blank and commented lines from $filename."
			sed -i -e '/^\#/d' "$filename"
			sed -i -e '/^$/d' "$filename"
			zenity --info --timeout=5 --text "You successfully modified $filename"
			zenity --info --timeout=5 --text "Returning to the main menu..."
			f_menu
		elif [ "$modify" = "n" ]; then
			zenity --info --timeout=5 --text "You chose not to modify $filename at this time."
			zenity --info --timeout=5 --text "Returning to the main menu."
			f_menu
		else
			zenity --info --timeout=5 --text "You did not enter a correct answer."
			zenity --info --timeout=5 --text "Starting over..."
			f_remove
		fi
	else
		zenity --info --timeout=5 --text "Select the word list to modify."
		filename=$(zenity --file-selection --title "Word list to modify")
		outfile=$(zenity --entry --title "Output file name" --text "What would you like the output word list to be named?\n(The file extension .lst will be added to your entry.)")
		zenity --info --timeout=5 --text "Where would you like $outfile.lst to be placed?"
		destination=$(zenity --file-selection --directory --title "$outfile.lst destination")
		zenity --question --title "Modify $filename" --text "Would you like to go ahead and modify $filename? (y/n)"
		if (( $? == 0 )); then
			zenity --info --timeout=5 --text "About to remove blank and commented lines from $filename."
			cat "$filename" | sed '/^\#/d' | sed '/^$/d' | cat > "$destination"/"$outfile".lst
			if [ -e "$destination"/"$outfile".lst ]; then
				zenity --info --timeout=5 --text "You successfully modified $filename into "$destination"/"$outfile".lst"
				zenity --info --timeout=5 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=5 --text "$outfile.lst does not exist in $destination"
				zenity --info --timeout=5 --text "Starting over..."
				f_remove
			fi
		elif [ "$modify" = "n" ]; then
			zenity --info --timeout=5 --text "You chose not to modify $filename at this time."
			zenity --info --timeout=5 --text "Returning to the main menu."
			f_menu
		else
			zenity --info --timeout=5 --text "You did not enter a correct answer."
			zenity --info --timeout=5 --text "Starting over..."
			f_remove
		fi
	fi
}
## remove blank and comments ##
function f_remove () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_removegtk
else
	echo "About to remove the blank and commented lines from a word list."
	echo
	sleep 2
	echo "Would you like to edit the file in space (y) or create a new file (n)? (y/n)"
	echo
	sleep 2
	read create
	if [ "$create" = "y" ]; then
		echo
		echo "Enter the full name and path of the word list to modify."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read filename
		if [ -e "$filename" ]; then
			echo
			echo "$filename exists"
			echo
			sleep 2
			echo "Continuing..."
			echo
			sleep 2
		else
			echo
			echo "$filename does not exists"
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_remove
		fi
		echo "Would you like to go ahead and modify $filename? (y/n)"
		echo
		read modify
		echo
		if [ "$modify" = "y" ]; then
			echo "About to remove blank and commented lines from $filename."
			echo
			sleep 2
			sed -i -e '/^\#/d' "$filename"
			sed -i -e '/^$/d' "$filename"
			echo "You successfully modified $filename"
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		elif [ "$modify" = "n" ]; then
			echo "You chose not to modify $filename at this time."
			echo
			sleep 2
			echo "Returning to the main menu."
			echo
			sleep 2
			f_menu
		else
			echo "You did not enter a correct answer."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_remove
		fi
	elif [ "$create" = "n" ]; then
		echo
		echo "Enter the full name and path of the word list to modify."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read filename
		if [ -e "$filename" ]; then
			echo
			echo "$filename exists"
			echo
			sleep 2
			echo "Continuing..."
			echo
			sleep 2
		else
			echo
			echo "$filename does not exists"
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_remove
		fi
		echo "What would you like the output word list to be named?"
		echo "(The file extension .lst will be added to your entry.)"
		echo
		read outfile
		echo
		sleep 2
		echo "Where would you like $outfile.lst to be placed?"
		echo "(e.x. /root/Desktop)"
		echo
		read destination
		echo
		while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_remove
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
				echo
			fi
		done
		echo "Would you like to go ahead and modify $filename? (y/n)"
		echo
		read modify
		echo
		if [ "$modify" = "y" ]; then
			echo "About to remove blank and commented lines from $filename."
			echo
			sleep 2
			cat "$filename" | sed '/^\#/d' | sed '/^$/d' | cat > "$destination"/"$outfile".lst
			if [ -e "$destination"/"$outfile".lst ]; then
				echo "You successfully modified $filename into "$destination"/"$outfile".lst"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 2
				f_menu
			else
				echo "$outfile.lst does not exist in $destination"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 2
				f_remove
			fi
		elif [ "$modify" = "n" ]; then
			echo "You chose not to modify $filename at this time."
			echo
			sleep 2
			echo "Returning to the main menu."
			echo
			sleep 2
			f_menu
		else
			echo "You did not enter a correct answer."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_remove
		fi
	else
		echo "You did not enter a correct answer."
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
			f_remove
		echo
	fi
fi
}
##begin pattern removal##
function f_patterngtk () {
	f_echobreak
	zenity --question --text "Would you like to edit the file in place (y) or create a new word list (n)?"
		if (( $? == 0 )); then
			zenity --info --timeout=4 --text "Please select the word list you would like to remove lines from."
			infile=$(zenity --file-selection --text "Word list to remove lines from") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				zenity --info --timeout=4 --text "Please enter the text you would like to remove lines from."
				pattern=$(zenity --entry --title "Text to remove")
				zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -i -e '/'"$pattern"'/d' "$infile"
				zenity --info --timeout=4 --text "Words with $pattern have been removed from $infile."
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_pattern
			fi
		else
			zenity --info --timeout=4 --text "Please enter the pattern you would like to remove."
			infile=$(zenity --file-selection --text "Pattern to remove") 
			if [ -e "$infile" ]; then
				zenity --info --timeout=4 --text "$infile exists."
				outfile=$(zenity --entry --title "Output wordlist" --text "What would you like the output word list to be named?\n(The file extension .lst will be appended to your selection)") 
				destination=$(zenity --file-selection --directory --title "Where would you like to place $outfile.lst?")
				zenity --info --timeout=4 --text "Please enter the pattern you would like to remove."
				pattern=$(zenity --entry --title "Pattern to remove.")
				zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $outfile.lst?"
				if (( $? == 0 )); then
				sed -e '/'"$pattern"'/d' "$infile" > "$destination/$outfile".lst
				if [ -e $destination/$outfile.lst ]; then
					zenity --info --timeout=4 --text "$outfile.lst exists in the directory: $destination"
					zenity --info --timeout=4 --text "Words with $pattern have been removed from $infile into $destination/$outfile.lst"
				else
					zenity --info --timeout=4 --text "$outfile.lst does not exist in the directory: $destination"
					zenity --info --timeout=4 --text "Let's try this again..."
					f_pattern
				fi				
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
				else
				zenity --info --timeout=4 --text "You chose not to modify $infile at this time"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --timeout=4 --text "$infile does not exist."
				zenity --info --timeout=4 --text "Let's try this again..."
				f_pattern
			fi
		fi
}
##insert##
function f_pattern () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_patterngtk
	else
		echo "Would you like to edit the file in place (y) or create a new word list (n)?"
		echo
		read edit
		echo
		if [ "$edit" = "y" ]; then
			echo
			echo "Please select the word list you would like to remove lines from."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "Please enter the pattern you would like to remove."
				echo
				read pattern
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then	
				echo
				sed -i -e '/'"$pattern"'/d' "$infile"
				echo
				echo "Words with $pattern have been removed from $infile."
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_pattern
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_pattern
			fi
		elif [ "$edit" = "n" ]; then
			echo
			echo "Please select the word list you would like to remove lines from."
			echo "(e.x. /root/Desktop/wordlist.lst)"
			echo
			read infile
			if [ -e "$infile" ]; then
				echo
				echo "$infile exists."
				echo
				sleep 2
				echo
				echo "What would you like the output word list to be named?"
				echo "(The file extension .lst will be appended to your selection)"
				echo
				read outfile
				echo
				echo "Where would you like to place $outfile.lst?"
				echo "(e.x. /root/Desktop)"
				echo
				read destination
				while [ ! -d "$destination" ]
				do
					echo
					echo "Directory cannot be found or does not exist"
					echo
					sleep 1
					echo "Would you like to create a folder for the directory you selected? (y/n)"
					read newdir
					if [ $newdir = "y" ]; then
						mkdir "$destination"
						while [ ! -d "$destination" ]
						do
							echo "Folder: $destination still cannot be found, starting over..."
							sleep 2
							f_pattern
						done
					else	
						sleep 1
						echo "Where would you like the output word list to be placed?"
						echo "(e.x. /root/Desktop)"
						read destination
					fi
				done
				echo
				echo "Please enter the pattern you would like to remove."
				echo
				read pattern
				echo
				echo "Would you like to go ahead and modify $infile? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then	
				echo
				sed -e '/'"$pattern"'/d' "$infile" > "$destination/$outfile".lst
				echo
				if [ -e $destination/$outfile.lst ]; then
					echo
					echo "$outfile.lst exists in the directory: $destination"
					echo
					sleep 1
					echo "Words with $pattern have been removed from $infile into $destination/$outfile.lst"
					echo
					sleep 3
				else
					echo
					echo "$outfile.lst does not exist in the directory: $destination"
					echo
					sleep 2
					echo "Let's try this again..."
					sleep 3
					f_pattern
				fi				
				echo
				sleep 3
				echo
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				elif [ "$create" = "n" ]; then
				echo
				echo "You chose not to modify $infile at this time"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
				else
				echo "You did not enter a correct selection"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_pattern
				fi
			else
				echo
				echo "$infile does not exist."
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 3
				f_pattern
			fi
		else
			echo "You did not enter a correct answer, returning to the main menu..."
			echo
			sleep 5
			f_menu
		fi
	fi
}
##add random numbers gtk##
function f_randomnumgtk () {
	zenity --info --timeout=5 --text "About to add random numbers to the lines of the word list."
	zenity --info --text "Please select the file you would like to modify."
	filename=$(zenity --file-selection --title "Word list to modify")
	if [ -e "$filename" ]; then
		zenity --info --timeout=5 --text "$filename exists\nContinuing..."
	else
		zenity --info --timeout=5 --text echo "$filename does not exist"
		zenity --info --timeout=5 --text "Starting over..."
		f_randomnum
	fi
	outfile=$(zenity --entry --title "Output word list" --text "What would you like the output word list to be named?\n(The file extension .lst will be appended to you selection.)")
	zenity --info --text "Where would you like to generate $outfile.lst?"
	destination=$(zenity --file-selection --directory --title "$outfile.lst destination")
	zenity --question --title "Leading zeroes?" --text "Would you like to add leading zeroes? (y/n)\n(e.x. y = 000001 , n = 1 )"
	if (( $? == 0 )); then
		zero="y"
	else
		zero="n"
	fi
	zenity --question --title "Placement of sequence" --text "Would you like to add the number before (y) or after (n) the words in: $filename?"
	if (( $? == 0 )); then
		number=$(zenity --scale --value=1 --min-value=1 --max-value=10 --step=1 --title "Length of sequence" --text "How many random numbers would you like to prefix the strings in $filename with? (1-10)")
		zenity --question --title "Create $outfile.lst" --text "Would you like to modify $filename into $outfile.lst?"
		if (( $? == 0 )); then
			if [ "$zero" = "y" ]; then
		 	if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 99999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 999999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
			elif [ "$zero" = "n" ]; then
		 	if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 99999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 999999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
		fi
			if [ -e "$destination"/"$outfile".lst ]; then
				zenity --info --timeout=5 --text "$outfile.lst exists in $destination"
				zenity --info --timeout=5 --text "Successfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=5 --text "$outfile.lst does not exists in $destination"
				zenity --info --timeout=5 --text "Unsuccessfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Starting over..."
				f_randomnum
			fi
		else
			echo "You chose not to create $outfile.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		fi
	else
		number=$(zenity --scale --value=1 --min-value=1 --max-value=10 --step=1 --title "Length of sequence" --text "How many random numbers would you like to prefix the strings in $filename with? (1-10)")
		zenity --question --title "Create $outfile.lst" --text "Would you like to modify $filename into $outfile.lst?"
		if (( $? == 0 )); then
			if [ "$zero" = "y" ]; then
 			if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 99999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 999999999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
			elif [ "$zero" = "n" ]; then
 			if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 99999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 999999999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
		fi
			if [ -e "$destination"/"$outfile".lst ]; then
				zenity --info --timeout=5 --text "$outfile.lst exists in $destination"
				zenity --info --timeout=5 --text "Successfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=5 --text "$outfile.lst does not exists in $destination"
				zenity --info --timeout=5 --text "Unsuccessfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Starting over..."
				f_randomnum
			fi
		else
			zenity --info --timeout=5 --text "You chose not to create $outfile.lst at this time."
			zenity --info --timeout=5 --text "Returning to the main menu..."
			f_menu
		fi
	fi
}
##add random numbers##
function f_randomnum () {
if [ "$GTK" = "y" ]; then
	f_randomnumgtk
else
	echo "About to add random numbers to the lines of the word list."
	echo
	sleep 2
	echo "Please select the file you would like to modify."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	sleep 1
	read filename
	echo
	if [ -e "$filename" ]; then
		echo "$filename exists"
		echo
		sleep 1
		echo "Continuing..."
		echo
		sleep 2
	else
		echo "$filename does not exist"
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_randomnum
	fi
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be appended to you selection.)"
	echo
	read outfile
	echo
	echo "Where would you like to generate $outfile.lst?"
	echo "(e.x. /root/Desktop)"
	echo
	read destination
	echo
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_randomnum
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
	echo
	echo "Would you like to add leading zeroes? (y/n)"
	echo "(e.x. y = 000001 , n = 1 )"
	echo
	read zero
	echo
	if [ "$zero" = "y" ]; then
		echo
	elif [ "$zero" = "n" ]; then
		echo
	else
		echo "You did not enter a correct answer"
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_randomnum
	fi
	echo "Would you like to add the number before (y) or after (n) the words in: $filename? (y/n)"
	echo
	sleep 1
	read placement
	echo
	if [ "$placement" = "y" ]; then
		echo "How many random numbers would you like to prefix the strings in $filename with? (1-10)"
		echo
		read number
		echo
		echo "Would you like to modify $filename into $outfile.lst? (y/n)"
		echo
		read create
		echo
		if [ "$create" = "y" ]; then
			if [ "$zero" = "y" ]; then
		 	if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 99999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 999999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "%0$number.0f$i" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
			elif [ "$zero" = "n" ]; then
		 	if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 99999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 999999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "%01.0f$i" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
		fi
			if [ -e "$destination"/"$outfile".lst ]; then
				echo
				echo "$outfile.lst exists in $destination"
				echo
				sleep 2
				echo "Successfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 2
				f_menu
			else
				echo
				echo "$outfile.lst does not exists in $destination"
				echo
				sleep 2
				echo "Unsuccessfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 2
				f_randomnum
			fi
		elif [ "$create" = "n" ]; then
			echo "You chose not to create $outfile.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "You did not enter a correct answer"
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_randomnum
		fi
	elif [ "$placement" = "n" ]; then
		echo "How many random numbers would you like to append the strings in $filename with? (1-10)"
		echo
		read number
		echo
		echo "Would you like to modify $filename into $outfile.lst? (y/n)"
		echo
		read create
		echo
		if [ "$create" = "y" ]; then
			if [ "$zero" = "y" ]; then
 			if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 99999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 999999999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%0$number.0f" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
			elif [ "$zero" = "n" ]; then
 			if [ "$number" == 1 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 2 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 99; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 3 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 4 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 5 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 99999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 6 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 7 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 8 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 99999999; done > "$destination"/"$outfile".lst
 			elif [ "$number" == 9 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 999999999; done > "$destination"/"$outfile".lst
			elif [ "$number" == 10 ] ; then 
 			for i in $(cat $filename); do seq -f "$i%01.0f" 0 9999999999; done > "$destination"/"$outfile".lst
			fi
		fi
			if [ -e "$destination"/"$outfile".lst ]; then
				echo
				echo "$outfile.lst exists in $destination"
				echo
				sleep 2
				echo "Successfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 2
				f_menu
			else
				echo
				echo "$outfile.lst does not exists in $destination"
				echo
				sleep 2
				echo "Unsuccessfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 2
				f_randomnum
			fi
		elif [ "$create" = "n" ]; then
			echo "You chose not to create $outfile.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "You did not enter a correct answer"
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_randomnum
		fi
	else
		echo "You did not enter a correct answer"
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_randomnum
	fi
fi
}
##random charsgtk##
function f_randomchargtk () {	
	zenity --info --timeout=5 --text "About to add random characters to the lines of the word list."
	zenity --info --text "Please select the file you would like to modify."
	filename=$(zenity --file-selection --title "Word list to modify")
	if [ -e "$filename" ]; then
		zenity --info --timeout=5 --text "$filename exists\nContinuing..."
	else
		zenity --info --timeout=5 --text echo "$filename does not exist"
		zenity --info --timeout=5 --text "Starting over..."
		f_randomchar
	fi
	outfile=$(zenity --entry --title "Output word list" --text "What would you like the output word list to be named?\n(The file extension .lst will be appended to you selection.)")
	zenity --info --text "Where would you like to generate $outfile.lst?"
	destination=$(zenity --file-selection --directory --title "$outfile.lst destination")
	zenity --question --title "Placement of sequence" --text "Would you like to add the characters before (y) or after (n) the words in: $filename?"
	if (( $? == 0 )); then
		placement="y"
	else
		placement="n"
	fi
	charset=$(zenity --entry --title "Charset to use" --text "Please enter the character set you would like to use.\n(e.x. abcxyzABCXYZ%$ etc...)")
	temp=0
	if [ "$placement" = "y" ]; then
		number=$(zenity --scale --value=1 --min-value=1 --max-value=10 --step=1 --title "Length of sequence" --text "How many random numbers would you like to prefix the strings in $filename with? (1-10)")
		zenity --question --title "Create $outfile.lst" --text "Would you like to modify $filename into $outfile.lst?"
		if (( $? == 0 )); then
			zenity --info --timeout=5 --text "Creating your temp word lists"
			zenity --info --timeout=5 --text "This may take quite a while..."
			if [ "$number" = "1" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "2" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "3" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "4" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "5" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "6" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "7" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "8" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "9" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "10" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@@@@$text -o "$destination"/$temp.temp
				done
			else
				zenity --info --timeout=5 --text "You did not enter the correct number of characters to prefix $filename with."
				zenity --info --timeout=5 --text "Please start over with a number between 1 and 10."
				f_randomchar
			fi
			cat "$destination"/*.temp > "$destination"/"$outfile".lst
			rm "$destination"/*.temp
			if [ -e "$destination"/"$outfile".lst ]; then
				zenity --info --timeout=5 --text "$outfile.lst exists in $destination"
				zenity --info --timeout=5 --text "Successfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=5 --text "$outfile.lst does not exists in $destination"
				zenity --info --timeout=5 --text "Unsuccessfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Starting over..."
				f_randomchar
			fi
		else
			zenity --info --timeout=5 --text "You chose not to create $outfile.lst at this time."
			zenity --info --timeout=5 --text "Returning to the main menu..."
			f_menu
		fi
	elif [ "$placement" = "n" ]; then
		number=$(zenity --scale --value=1 --min-value=1 --max-value=10 --step=1 --title "Length of sequence" --text "How many random numbers would you like to prefix the strings in $filename with? (1-10)")
		zenity --question --title "Create $outfile.lst" --text "Would you like to modify $filename into $outfile.lst?"
		if (( $? == 0 )); then
			zenity --info --timeout=5 --text "Creating your temp word lists"
			zenity --info --timeout=5 --text "This may take quite a while..."
			if [ "$number" = "1" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "2" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "3" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "4" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "5" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "6" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "7" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "8" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "9" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "10" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@@@@ -o "$destination"/$temp.temp
				done
			else
				zenity --info --timeout=5 --text "You did not enter the correct number of characters to prefix $filename with."
				zenity --info --timeout=5 --text "Please start over with a number between 1 and 10."
				f_randomchar
			fi
			cat "$destination"/*.temp > "$destination"/"$outfile".lst
			rm "$destination"/*.temp
			if [ -e "$destination"/"$outfile".lst ]; then
				zenity --info --timeout=5 --text "$outfile.lst exists in $destination"
				zenity --info --timeout=5 --text "Successfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=5 --text "$outfile.lst does not exists in $destination"
				zenity --info --timeout=5 --text "Unsuccessfully created $outfile.lst in $destination"
				zenity --info --timeout=5 --text "Starting over..."
				f_randomchar
			fi
		else
			zenity --info --timeout=5 --text "You chose not to create $outfile.lst at this time."
			zenity --info --timeout=5 --text "Returning to the main menu..."
			f_menu
		fi
	else
		zenity --info --timeout=5 --text "You did not enter a correct answer"
		zenity --info --timeout=5 --text "Starting over..."
		f_randomchar
	fi
}
##random chars##
function f_randomchar () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_randomchargtk
else
	echo "About to add random characters to the lines of the word list."
	echo
	sleep 2
	echo "Please select the file you would like to modify."
	echo "(e.x. /root/Desktop/wordlist.lst)"
	echo
	sleep 1
	read filename
	echo
	if [ -e "$filename" ]; then
		echo "$filename exists"
		echo
		sleep 1
		echo "Continuing..."
		echo
		sleep 2
	else
		echo "$filename does not exist"
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_randomchar
	fi
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be appended to you selection.)"
	echo
	read outfile
	echo
	echo "Where would you like to generate $outfile.lst?"
	echo "(e.x. /root/Desktop)"
	echo
	read destination
	echo
	while [ ! -d "$destination" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 1
			echo "Would you like to create a folder for the directory you selected? (y/n)"
			read newdir
			if [ $newdir = "y" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					echo "Folder: $destination still cannot be found, starting over..."
					sleep 2
					f_randomchar
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
	echo
	echo "Would you like to add the characters before (y) or after (n) the words in: $filename? (y/n)"
	echo
	sleep 1
	read placement
	echo
	echo "Please enter the character set you would like to use."
	echo "(e.x. abcxyzABCXYZ%$ etc...)"
	echo
	read charset
	echo
	sleep 1
	temp=0
	if [ "$placement" = "y" ]; then
		echo "How many random characters would you like to prefix the strings in $filename with? (1-10)"
		echo
		read number
		echo
		echo "Would you like to modify $filename into $outfile.lst? (y/n)"
		echo
		read create
		echo
		if [ "$create" = "y" ]; then
			echo "Creating your temp word lists"
			sleep 2
			echo "This may take quite a while..."
			echo
			sleep 2
			if [ "$number" = "1" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "2" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "3" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "4" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "5" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "6" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "7" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "8" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "9" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@@@$text -o "$destination"/$temp.temp
				done
			elif [ "$number" = "10" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t @@@@@@@@@@$text -o "$destination"/$temp.temp
				done
			else
				echo "You did not enter the correct number of characters to prefix $filename with."
				echo "Please start over with a number between 1 and 10."
				echo
				sleep 5
				f_randomchar
			fi
			cat "$destination"/*.temp > "$destination"/"$outfile".lst
			rm "$destination"/*.temp
			if [ -e "$destination"/"$outfile".lst ]; then
				echo
				echo "$outfile.lst exists in $destination"
				echo
				sleep 2
				echo "Successfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 2
				f_menu
			else
				echo
				echo "$outfile.lst does not exists in $destination"
				echo
				sleep 2
				echo "Unsuccessfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 2
				f_randomchar
			fi
		elif [ "$create" = "n" ]; then
			echo "You chose not to create $outfile.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "You did not enter a correct answer"
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_randomchar
		fi
	elif [ "$placement" = "n" ]; then
		echo "How many random characters would you like to append the strings in $filename with? (1-10)"
		echo
		read number
		echo
		echo "Would you like to modify $filename into $outfile.lst? (y/n)"
		echo
		read create
		echo
		if [ "$create" = "y" ]; then
			echo "Creating your temp word lists"
			sleep 2
			echo "This may take quite a while..."
			echo
			sleep 2
			if [ "$number" = "1" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "2" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "3" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "4" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "5" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "6" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "7" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "8" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "9" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@@@ -o "$destination"/$temp.temp
				done
			elif [ "$number" = "10" ]; then
				cat "$filename" | while read line
				do
				count=$(echo $line | wc -c)
				text=$line
				let crunchcount=$((($count + $number) -1 ))
				let temp=$(($temp + 1))
				/usr/bin/crunch $crunchcount $crunchcount $charset -t $text@@@@@@@@@@ -o "$destination"/$temp.temp
				done
			else
				echo "You did not enter the correct number of characters to prefix $filename with."
				echo "Please start over with a number between 1 and 10."
				echo
				sleep 5
				f_randomchar
			fi
			cat "$destination"/*.temp > "$destination"/"$outfile".lst
			rm "$destination"/*.temp
			if [ -e "$destination"/"$outfile".lst ]; then
				echo
				echo "$outfile.lst exists in $destination"
				echo
				sleep 2
				echo "Successfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 2
				f_menu
			else
				echo
				echo "$outfile.lst does not exists in $destination"
				echo
				sleep 2
				echo "Unsuccessfully created $outfile.lst in $destination"
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 2
				f_randomchar
			fi
		elif [ "$create" = "n" ]; then
			echo "You chose not to create $outfile.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo "You did not enter a correct answer"
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_randomchar
		fi
	else
		echo "You did not enter a correct answer"
		echo
		sleep 2
		echo "Starting over..."
		echo
		sleep 2
		f_randomchar
	fi
fi
}

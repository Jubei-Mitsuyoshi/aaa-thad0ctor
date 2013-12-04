#!/bin/sh
##cruncher gtk##
function f_crunchergtk () {
zenity --info --timeout=4 --text "Running the automated Crunch script, you will be prompted with several popup questions."
zenity --question --title "Pattern or Standard" --text "Would you like specify a pattern?"
if (( $? == 0 )); then
	if [ "$passthrough" = "0" ]; then
	destination=$(zenity --file-selection --directory --title "File Destination" --text "Where would you like to place the end product?")
	filename=$(zenity --entry --title "File Names" --text "What to name the new wordlist file?\n(The file will be saved with the .lst extension)")
	else
		echo
	fi
	max=$(zenity --scale --value=8 --min-value=1 --max-value=64 --step=1 --title "Character Length" --text "Select the character length for the pattern word list.\n(The minimum WPA length is 8 characters)")
	pattern=$(zenity --title "Pattern" --entry --text "Select the pattern you would like for your wordlist.\n@ = Lowercase Letters\n, = Uppercase Letters\n % = Numbers\n^ = Symbols\n(The pattern must be $max characters in length.)")
	zenity --question --title "Make Wordlist" --text "Would you like to create/passthrough the wordlist: $filename.lst"
	if (( $? == 0 )); then
		zenity --info --timeout=4 --text "About to generate your wordlist."
		if [ "$passthrough" = "0" ]; then
        	/usr/bin/crunch $max $max -t $pattern -o $filename.lst
		elif [ "$passthrough" = "1" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch $max $max -t $pattern | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
		elif [ "$passthrough" = "2" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch $max $max -t $pattern | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
		fi
		if [ "$passthrough" = "0" ]; then
		zenity --info --timeout=4 --text "Moving $filename.lst to the directory you selected ($destination)."
		mv $filename.lst "$destination"
		zenity --info --timeout=4 --text "$filename.lst has been moved $destination"
		zenity --info --timeout=4 --text "Returning to the main menu."
		else
			echo
		fi
	else
	f_crunch
	fi
else
	if [ "$passthrough" = "0" ]; then
	destination=$(zenity --file-selection --directory --title "File Destination" --text "Where would you like to place the end product?")
	filename=$(zenity --entry --title "File Names" --text "What to name the new wordlist file?\n(The file will be saved with the .lst extension)")
	else
		echo
	fi
	min=$(zenity --scale --value=8 --min-value=1 --max-value=64 --step=1 --title "Character Length" --text "Select the character length for the pattern word list.\n(The maximum WPA length is 8 characters)")
	max=$(zenity --scale --value=8 --min-value=1 --max-value=64 --step=1 --title "Character Length" --text "Select the character length for the pattern word list.\n(The maximum WPA length is 64 characters)")
	chars=$(zenity --title  "Charset" --entry --text "Select the characters you would like to use for the word list. (no spaces, space is forward slash)")
	zenity --question --title "Make Wordlist" --text "Would you like to create/passthrough the wordlist: $filename.lst"
	if (( $? == 0 )); then
		zenity --info --timeout=4 --text "About to generate your wordlist."
		if [ "$passthrough" = "0" ]; then
        	/usr/bin/crunch $min $max $chars -o $filename.lst
		elif [ "$passthrough" = "1" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch $min $max $chars | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
		elif [ "$passthrough" = "2" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch $min $max $chars | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
		fi
		if [ "$passthrough" = "0" ]; then
		zenity --info --timeout=4 --text "Moving $filename.lst to the directory you selected ($destination)."
		mv $filename.lst "$destination"
		zenity --info --timeout=4 --text "$filename.lst has been moved $destination"
		zenity --info --timeout=4 --text "Returning to the main menu."
		else
			echo
		fi
	else
	f_crunch
	fi
fi
}
###cruncher###
function f_cruncher () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_crunchergtk
else
	echo "Opening Cruncher, the interactive Crunch prompt system."
	echo
	sleep 1
	echo "The CLI version of the feature is a work in progress."
	echo "Returning to the main menu."
	sleep 5
	f_menu
fi
}
##all socials GTK##
function f_socialGTK () {
	if [ "$passthrough" = "0" ]; then
	zenity --no-wrap --info --text "This script will create a social security number worldlist for every possible SSN.\nEach worldlist will be around ~10gb, make sure you have HDD space!\n(If passthrough is enabled this script will not generate a word list.)"
	filename=$(zenity --entry --title "File Name?" --text "What to name the new word list file?\n\n(The file will be saved with the .lst extension)")
	destination=$(zenity --file-selection --directory --title "File Destination" --text "Where would you like to place $filename.lst")
	list=$(ls *.lst)
	zenity --no-wrap --question --title "Delete or Move Scripts" --text "Would you like to remove all current .lst lists in the script directory?\n(Any word .lst lists in the current directory will be deleted due to this script.)\nTo delete the .lst lists press Yes, otherwise they will be moved to   /backup/.\n(lists to be removed: $list)"
	if (( $? == 0 )); then
		list=$(ls *.lst)
		zenity --no-wrap --info --timeout=4 --text "Deleting existings .lst word lists in the script directory.\n(lists to be removed: $list)"
		rm *.lst
		zenity --no-wrap --info --timeout=4 --text "The script directory has been cleared of existing .lst word lists."	
	else
		zenity --no-wrap --info --timeout=4 --text "Making directory: /backup/ in the script folder."
		mkdir backup
		zenity --no-wrap --info --timeout=4 --text "Moving existing lists to /backup/."
		mv *.lst backup
	fi
	else
		echo
	fi
	social=$(zenity  --list  --checklist  --title "Area Code Format" --text "Select a Social Security Number format to use.\n(Select one format at a time)" --height=220 --column "Select" --column "SSN Format" FALSE '012345678' FALSE '012-34-5678')
        zenity --no-wrap --question --title "Make word list" --text "Would you like to create/passthrough the word list: $filename.lst"
	if (( $? == 0 )); then
		if [ "$social" = "012345678" ]; then
			if [ "$passthrough" = "0" ]; then
               		/usr/bin/crunch 9 9 1234567890 -t @@@@@@@@@ -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 9 9 1234567890 -t @@@@@@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 9 9 1234567890 -t @@@@@@@@@| pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
        	elif [ "$social" = "012-34-5678" ]; then
			if [ "$passthrough" = "0" ]; then
                	/usr/bin/crunch 11 11 1234567890 -t @@@-@@-@@@@ -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 11 11 1234567890 -t @@@-@@-@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 11 11 1234567890 -t @@@-@@-@@@@ | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
		else
			zenity --error --text "You did not select a correct answer.\nStarting Over..."
			f_socialGTK
        	fi
	else
		f_menu
	fi
	if [ "$passthrough" = "0" ]; then
	zenity --no-wrap --info --timeout=4 --text "Finished processing $filename.lst"
	if [ "$destination" != "" ]; then
		zenity --no-wrap --info --timeout=4 --text "Moving $filename.lst list to $destination"
		mv $filename.lst "$destination"
		if [ -e $destination/$filename.lst ]; then
			zenity --no-wrap --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
			zenity --no-wrap --info --timeout=4 --text "$filename.lst has been successfully moved to: $destination"
		else
			zenity --no-wrap --info --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
			zenity --no-wrap --info --timeout=4 --text "Let's try this again..."
			f_socialGTK
		fi
	fi
	zenity --no-wrap --info --timeout=4 --text "Returning to the main menu"
	else
		echo
	fi
}
##all socials##
function f_social () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_socialGTK
	else
		if [ "$passthrough" = "0" ]; then
		echo "This script will create a social security number worldlist for every possible SSN."
        	echo
		sleep 1
        	echo "Each worldlist will be around ~10gb, make sure you have HDD space!";echo "(If passthrough is enabled this script will not generate a word list.)"
        	echo
		sleep 1
		echo
		list=$(ls *.lst)
		echo "Would you like to remove all current .lst lists in the script directory?"
		echo "(lists to be removed: $list)"
		echo
		sleep 2
		echo "(Any .lst word lists in the current directory will contaminate your final list.)"
		echo
		sleep 1 
		echo "To delete the .lst lists enter d | To move them to a temporary directory enter m"
		echo
		sleep 1
		echo "Or you can press enter to skip this step."
		echo
		sleep 1
		echo "(m/d)"
		sleep 2
		read backup
		if [ "$backup" = "d" ]; then
			list=$(ls *.lst)
			echo "Deleting existings .lst lists in the script directory."
			echo "(lists to be removed: $list)"
			rm -r *.lst
			echo
			sleep 1
			echo "The script directory has been cleared of existing .lst lists."
			echo
			sleep 1		
		elif [ "$backup" = "m" ]; then
			echo
			echo "Making directory: /backup/ in the script folder."
			mkdir backup
			sleep 1
			echo "Moving existing lists to /backup/."
			sleep 1
			mv *.lst backup
			sleep 1
		else
		echo
		echo "You did not enter an answer, skipping..."
		echo
		sleep 2
		fi
		else
			echo
		fi
		f_echobreak
        	echo "\t1. 012345678"
        	echo "\t2. 012-34-5678"
        	echo -en "\n\tSelect an social security number format to use: "
        	read social
		echo
		echo
		if [ "$passthrough" = "0" ]; then
		echo "What would you like the output word list to be named?"
		echo "(The file extension .lst will be appended to the filename)"
		echo
		sleep 1
		read filename
		echo
		sleep 1
		echo "Enter the directory where you would like $filename.lst to be placed. (ex. /root/Desktop/)"
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
					f_social
				done
			else	
			sleep 1
			echo "Enter the directory where you would like the word list to be placed. (ex. /root/Desktop/)"
			read destination
			fi
		done
		else
			echo
		fi
		echo "Hit enter to create/passthough the word list"
        	read return
        	if [ "$return" == "" ]; then
        	echo "Please wait while the list is being generated/passthrough...";echo
		sleep 1
        	if [ "$social" = "1" ]; then
			if [ "$passthrough" = "0" ]; then
               		/usr/bin/crunch 9 9 1234567890 -t @@@@@@@@@ -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			echo "About to passthrough attack.";echo
			sleep 2
			/usr/bin/crunch 9 9 1234567890 -t @@@@@@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			echo "About to passthrough attack.";echo
			sleep 2
			/usr/bin/crunch 9 9 1234567890 -t @@@@@@@@@| pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
        	elif [ "$social" = "2" ]; then
			if [ "$passthrough" = "0" ]; then
                	/usr/bin/crunch 11 11 1234567890 -t @@@-@@-@@@@ -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			echo "About to passthrough attack.";echo
			sleep 2
			/usr/bin/crunch 11 11 1234567890 -t @@@-@@-@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			echo "About to passthrough attack.";echo
			sleep 2
			/usr/bin/crunch 11 11 1234567890 -t @@@-@@-@@@@ | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
        	fi
		fi
		if [ "$passthrough" = "0" ]; then
		echo "Finished processing $filename.lst"
		echo
		sleep 1
		if [ "$destination" != "" ]; then
			echo "Moving $filename.lst list to $destination"
			mv $filename.lst "$destination"
			sleep 1
			if [ -e $destination/$filename.lst ]; then
				echo
				echo "$filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "$filename.lst has been successfully moved to: $destination"
				echo
				sleep 1
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_social
			fi
		fi
		echo "Returning to the main menu"
		sleep 2
		else
			echo
		fi
	fi
}
##specific Area Codes GTK##
function f_phoneGTK () {
	if [ "$passthrough" = "0" ]; then
	zenity --no-wrap --info --text "This script will create a phone number worldlist for specific area codes.\nEach worldlist will be around ~110mb, make sure you have HDD space!\n(If passthrough is enabled this script will not generate a word list.)"
	filename=$(zenity --entry --title "File Name?" --text "What to name the new word list file?\n\n(The file will be saved with the .lst extension)")
	phone=$(zenity --list --checklist --title "Area Code Format" --text "Select an area code format to use.\n(Select one format at a time)" --height=220 --column "Select" --column "Area Code Format" FALSE '2125551234' FALSE '(212)5551234' FALSE '212-555-1234' FALSE '(212)555-1234')
	areacode=$(zenity --entry --title "Area Code?" --text "What are code would you like to use?")
	else
		echo
	fi
	zenity --no-wrap --question --title "Create word list" --text "Would you like to create/passthrough the word list?"
	if (( $? == 0 )); then
        	zenity --no-wrap --info --timeout=4 --text "Please wait while the temp lists are being generated in the folder this script is located"
        	if [ "$phone" = "2125551234" ]; then
			if [ "$passthrough" = "0" ]; then
               		/usr/bin/crunch 10 10 1234567890 -t $areacode@@@@@@@ -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 10 10 1234567890 -t $areacode@@@@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 10 10 1234567890 -t $areacode@@@@@@@ | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
        	elif [ "$phone" = "(212)5551234" ]; then
			if [ "$passthrough" = "0" ]; then
               		/usr/bin/crunch 12 12 1234567890 -t "($areacode)@@@@@@@" -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 12 12 1234567890 -t "($areacode)@@@@@@@" | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 12 12 1234567890 -t "($areacode)@@@@@@@" | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
        	elif [ "$phone" = "212-555-1234" ]; then
			if [ "$passthrough" = "0" ]; then
                	/usr/bin/crunch 12 12 1234567890 -t $areacode-@@@-@@@@ -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 12 12 1234567890 -t $areacode-@@@-@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 12 12 1234567890 -t $areacode-@@@-@@@@ | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
        	elif [ "$phone" = "(212)555-1234" ]; then
			if [ "$passthrough" = "0" ]; then
                	/usr/bin/crunch 13 13 1234567890 -t "($areacode)@@@-@@@@" -o $filename.lst
			elif [ "$passthrough" = "1" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 13 13 1234567890 -t "($areacode)@@@-@@@@" | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
			elif [ "$passthrough" = "2" ]; then
			zenity --info --timeout=4 --text "About to passthrough attack."
			/usr/bin/crunch 13 13 1234567890 -t "($areacode)@@@-@@@@" | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
			fi
		else
			zenity --error --text "You did not select a correct answer.\nStarting Over..."
			f_phoneGTK
		fi
	else 
		f_menu
	fi
	zenity --no-wrap --question --title "Make another word list?" --text "Would you like to make another word list in order to combine multiple lists?"
	if (( $? == 0 )); then
		f_phoneGTK
	else
		if [ "$passthrough" = "0" ]; then
		destination=$(zenity --file-selection --directory --title "File Destination" --text "Where would you like to place $filename.lst")
		zenity --no-wrap --question --title "Combine word lists?" --text "Would you like to combine the word lists you made?"
		if (( $? == 0 )); then
			filename=$(zenity --entry --title "File Name?" --text "What to name the new word list file?\n\n(The file will be saved with the .lst extension)")
			cat *.lst > $filename.lst
			echo "The temp lists have been combined, moving $filename.lst list to $destination"
			mv $filename.lst "$destination"
			if [ -e $destination/$filename.lst ]; then
				zenity --no-wrap --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
				zenity --no-wrap --info --timeout=4 --text "The $filename.lst list has been successfully moved to: $destination"
				zenity --no-wrap --question --title "Clean up temp word lists?" --text "Would you like to clean up the temp word lists?"
				if (( $? == 0 )); then
					rm *.lst
					zenity --no-wrap --info --timeout=4 --text "The temp lists have been cleaned up."
				else
					zenity --no-wrap --info --timeout=4 --text "Skipping cleanup."
					zenity --no-wrap --info --timeout=4 --text "Moving the temp lists to $destination"
					mv *.lst "$destination"
					zenity --no-wrap --info --timeout=4 --text "The temp lists have been moved to $destination"
				fi
			else
				zenity --no-wrap --error --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
				zenity --no-wrap --info --timeout=4 --text "Let's try this again..."
				f_phoneGTK
			fi
		else
			zenity --no-wrap --info --timeout=4 --text "The list(s) have been not been combined, moving them to $destination"
			if [ "$destination" != "" ]; then
				mv *.lst "$destination"
				zenity --no-wrap --info --timeout=4 --text "The temp lists have been moved to $destination"
			else
				echo
			fi
		fi
		else
			echo
		fi
	fi
}
##specific area codes##
function f_phone () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_phoneGTK
	else
	echo "This script will create a phone number worldlist for specific area codes."
        echo
	echo
	sleep 1
        echo "Each worldlist will be around ~110mb, make sure you have HDD space!";echo "(If passthrough is enabled this script will not generate a word list.)"
        echo
	echo
	sleep 3
	sleep 2
	if [ "$passthrough" = "0" ]; then
	echo "What would you like the output word list to be named?"
	echo "(The file extension .lst will be appended to the filename)"
	echo	
	read filename
	echo
	sleep 1
	echo "Enter the directory where you would like $filename.lst to be placed."
	echo "(ex. /root/Desktop)"
	echo 
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
				f_phone
			done
		else	
		sleep 1
		echo "Enter the directory where you would like the word list to be placed. (ex. /root/Desktop/)"
		read destination
		fi
	done
	else
		echo
	fi
        f_echobreak	
        echo "1. 2125551234"
        echo "2. (212)5551234"
        echo "3. 212-555-1234"
        echo "4. (212)555-1234"
        echo -en "\n\tSelect an areacode format to use: "
        read phone
        echo
	sleep 1
	echo "Enter the area code you would like to use."
	echo
	sleep 1
	read areacode
	echo
        echo "Hit enter to create/passthough the word list"
        read return
        if [ "$return" == "" ]; then
        echo "Please wait while the temp list is being generated in the folder this script is located."
	sleep 1
        if [ "$phone" = "1" ]; then
               	if [ "$passthrough" = "0" ]; then
               	/usr/bin/crunch 10 10 1234567890 -t $areacode@@@@@@@ -o $filename.lst
		elif [ "$passthrough" = "1" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 10 10 1234567890 -t $areacode@@@@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
		elif [ "$passthrough" = "2" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 10 10 1234567890 -t $areacode@@@@@@@ | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
		fi
        elif [ "$phone" = "2" ]; then
                if [ "$passthrough" = "0" ]; then
               	/usr/bin/crunch 12 12 1234567890 -t "($areacode)@@@@@@@" -o $filename.lst
		elif [ "$passthrough" = "1" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 12 12 1234567890 -t "($areacode)@@@@@@@" | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
		elif [ "$passthrough" = "2" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 12 12 1234567890 -t "($areacode)@@@@@@@" | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
		fi
        elif [ "$phone" = "3" ]; then
		if [ "$passthrough" = "0" ]; then
                /usr/bin/crunch 12 12 1234567890 -t $areacode-@@@-@@@@ -o $filename.lst
		elif [ "$passthrough" = "1" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 12 12 1234567890 -t $areacode-@@@-@@@@ | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
		elif [ "$passthrough" = "2" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 12 12 1234567890 -t $areacode-@@@-@@@@ | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
		fi
        elif [ "$phone" = "4" ]; then
		if [ "$passthrough" = "0" ]; then
                /usr/bin/crunch 13 13 1234567890 -t "($areacode)@@@-@@@@" -o $filename.lst
		elif [ "$passthrough" = "1" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 13 13 1234567890 -t "($areacode)@@@-@@@@" | aircrack-ng -w - -e "$passthroughap" "$passthroughcap"
		elif [ "$passthrough" = "2" ]; then
		echo "About to passthrough attack.";echo
		sleep 2
		/usr/bin/crunch 13 13 1234567890 -t "($areacode)@@@-@@@@" | pyrit -r "$passthroughcap" -e "$passthroughap" -i - attack_passthrough
		fi
        fi
	fi
	echo
	sleep 1
	if [ "$destination" != "" ]; then
	echo "Moving $filename.lst list to $destination"
	mv $filename.lst "$destination"
	sleep 1
	if [ -e "$destination"/$filename.lst ]; then
		echo
		echo "$filename.lst exists in the directory: $destination"
		echo
		sleep 1
		echo "$filename.lst has been successfully moved to: $destination"
		echo
		sleep 1
	else
		echo
		echo "$filename.lst does not exist in the directory: $destination"
		echo
		sleep 1
		echo "Let's try this again..."
		sleep 1
		f_phone
	fi
	fi
	echo
	sleep 1
	echo "Returning to the main menu"
	sleep 1
	fi
}
##all Area Codes GTK##
function f_phone1GTK () {
	zenity --no-wrap --info --text "This script will create a phone number worldlist for all US area codes.\nEach worldlist will be around ~50gb, make sure you have HDD space!\n(If passthrough is enabled this script will not generate a word list.)"
	destination=$(zenity --file-selection --directory --title "File Destination" --text "Where would you like to place $filename.lst")
	list=$(ls *.lst)
	zenity --no-wrap --question --title "Delete or Move Scripts" --text "Would you like to remove all current .lst lists in the script directory?\n(Any .lst word lists in the current directory will be deleted due to this script.)\nTo delete the lists press Yes, otherwise they will be moved to   /backup/.\n(lists to be removed: $list)"
	if (( $? == 0 )); then
		list=$(ls *.lst)
		zenity --no-wrap --info --timeout=4 --text "Deleting existings .lst lists in the script directory.\n(lists to be removed: $list)"
		rm *.lst
		zenity --no-wrap --info --timeout=4 --text "The script directory has been cleared of existing lists."	
	else
		zenity --no-wrap --info --timeout=4 --text "Making directory: /backup/ in the script folder."
		mkdir backup
		zenity --no-wrap --info --timeout=4 --text "Moving existing lists to /backup/."
		mv *.lst backup
	fi
	phone=$(zenity --list --checklist --title "Area Code Format" --text "Select an area code format to use.\n(Select one format at a time)" --height=220 --column "Select" --column "Area Code Format" FALSE '2125551234' FALSE '(212)5551234' FALSE '212-555-1234' FALSE '(212)555-1234')
	if (( $? == 0 )); then
        	zenity --no-wrap --info --timeout=4 --text "Please wait while the temp lists are being generated in the folder this script is located"
        	if [ "$phone" = "2125551234" ]; then
               		bash phone_simple.sh
        	elif [ "$phone" = "(212)5551234" ]; then
               		bash phone_peren.sh
        	elif [ "$phone" = "212-555-1234" ]; then
               		bash phone_dash.sh
        	elif [ "$phone" = "(212)555-1234" ]; then
               		bash phone_both.sh
		else
			zenity --error --text "You did not select a correct answer.\nStarting Over..."
			f_phone1GTK
        	fi
		echo $ECHOCOLOR""
	else 
		f_menu
	fi
	zenity --no-wrap --question --title "Combine word lists?" --text "Would you like to combine the temp word lists?"
	if (( $? == 0 )); then
		filename=$(zenity --entry --title "File Name?" --text "What to name the new word list file?\n\n(The file will be saved with the .lst extension)")
		cat *.lst > $filename.lst
		zenity --no-wrap --info --timeout=4 --text "The temp lists have been combined, moving $filename.lst list to $destination"
		if [ "$destination" != "" ]; then
			mv $filename.lst "$destination"
			if [ -e $destination/$filename.lst ]; then
				zenity --no-wrap --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
				zenity --no-wrap --info --timeout=4 --text "The $filename.lst list has been successfully moved to: $destination"
				zenity --no-wrap --question --title "Clean up temp word lists?" --text "Would you like to clean up the temp word lists?"
				if (( $? == 0 )); then
					rm *.lst
					zenity --no-wrap --info --timeout=4 --text "The temp lists have been cleaned up."
				else
					zenity --no-wrap --info --timeout=4 --text "Skipping cleanup."
				fi
			else
				zenity --no-wrap --error --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
				zenity --no-wrap --info --timeout=4 --text "Let's try this again..."
				f_phone1
			fi
		fi
	else
		zenity --no-wrap --info --timeout=4 --text "The temp lists have been not been combined, moving them to $destination"
		if [ "$destination" != "" ]; then
			mv *.lst "$destination"
		else
			echo
		fi
	fi
	zenity --no-wrap --info --timeout=4 --text "Returning to the main menu"
}
##all Area Codes##
function f_phone1 () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_phone1GTK
	else
		echo "This script will create a phone number worldlist for all US area codes."
        	echo
		sleep 1
        	echo "Each worldlist will be around ~50gb, make sure you have HDD space!";echo "(If passthrough is enabled this script will not generate a word list.)"
        	echo
		sleep 1
		echo
		list=$(ls *.lst)
		echo "Would you like to remove all current .lst lists in the script directory?"
		echo "(lists to be removed: $list)"
		echo
		sleep 2
		echo "(Any .lst word lists in the current directory will contaminate your final list.)"
		echo
		sleep 1
		echo "To delete the .lst lists enter d | To move them to a temporary directory enter m"
		echo
		sleep 1
		echo "Or you can press enter to skip this step."
		echo
		sleep 1
		echo "(m/d)"
		sleep 2
		read backup
		if [ "$backup" = "d" ]; then
			list=$(ls *.lst)
			echo "Deleting the existing .lst word lists in the script directory."
			echo "(lists to be removed: $list)"
			rm -r *.lst
			echo
			sleep 2
			echo "The script directory has been cleared of existing .lst lists."
			echo
			sleep 1		
		elif [ "$backup" = "m" ]; then
			echo
			echo "Making directory: /backup/ in the script folder."
			mkdir backup
			sleep 1
			echo "Moving existing lists to /backup/."
			sleep 1
			mv *.lst backup
			sleep 1
		else
			echo
			echo "You did not enter an answer, skipping..."
			echo
			sleep 2
		fi
		echo "Enter the directory where you would like the word list(s) to be placed. (ex. /root/Desktop/)"
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
				f_phone1
				done
			else	
				sleep 1
				echo -en "\nEnter the full path to the directory that contains the files to merge: (ex. /root/Desktop/):"
				read destination
			fi
		done
        	f_echobreak
        	echo "1. 2125551234"
        	echo "2. (212)5551234"
        	echo "3. 212-555-1234"
        	echo "4. (212)555-1234"
        	echo -en "\n\tSelect an areacode format to use: "
        	read phone
        	echo
        	echo -en "\nHit return to create the list: "
        	read return
        	if [ "$return" == "" ]; then
        	echo "Please wait while the temp lists are being generated in the folder this script is located."
		sleep 1
        	if [ "$phone" = "1" ]; then
               		bash phone_simple.sh
        	elif [ "$phone" = "2" ]; then
               		bash phone_peren.sh
        	elif [ "$phone" = "3" ]; then
               		bash phone_dash.sh
        	elif [ "$phone" = "4" ]; then
               		bash phone_both.sh
        	fi
		echo $ECHOCOLOR""
	fi
	echo
	sleep 1
	echo -en "\nWould you like to combine the word lists (y/n)"
        read combine
	if [ "$combine" = "y" ]; then
		echo
		sleep 1
		echo "What would you like the combined word list to be named?"
		echo "(The file extension .lst will be appended to the filename)"
		echo	
		read filename		
		cat *.lst > $filename.lst
		echo
		echo "The temp lists have been combined, moving $filename.lst list to $destination"
		if [ "$destination" != "" ]; then
			mv $filename.lst "$destination"
			sleep 1
			if [ -e $destination/$filename.lst ]; then
				echo
				echo "$filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "The $filename.lst list has been successfully moved to: $destination"
				echo
				sleep 3
				echo "Would you like to clean up the temp lists? (y/n)"
				echo
				read cleanup
				if [ "$cleanup" = "y" ]; then
					rm *.lst
					echo
					echo "The temp lists have been cleaned up."
					sleep 1
				elif [ "$cleanup" = "n" ]; then
					echo
					echo "Skipping cleanup."
					sleep 1
				else
					echo
					echo "You did not input the correct answer, skipping..."
					echo
					sleep 1
				fi
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
				f_phone1
			fi
		fi
		echo
	elif [ "$combine" = "n" ]; then
		echo
		echo "The temp lists have been not been combined, moving them to $destination"
		if [ "$destination" != "" ]; then
			mv *.lst "$destination"
			sleep 1
		else
			echo
		fi
	else
	echo
	echo "You did not enter the correct answer (y/n)!"
	echo
	sleep 1
	echo "Starting over..."
	sleep 2
	f_phone1
	fi
	echo
	sleep 1
	echo "Returning to the main menu"
	sleep 2
	fi
}
##tapes datelist GTK##
function f_tapesGTK () {
		dateformat=$(zenity --list --checklist --height=275 --title "Date Format" --text "Enter date format you would like to use?\n(Select only one option)" --column "Select" --column "Date Format" FALSE ddmmyy FALSE ddmmyyyy FALSE mmddyy FALSE mmddyyyy FALSE yymmdd FALSE yyyymmdd)
		format="$dateformat"
		seperator=$(zenity --list --checklist --height=275 --title "Seperator" --text "What text character would you like to use as a seperator?\n(Select only one option)" --column "Select" --column "Seperator Character" FALSE "' ' (A Space)         e.x. yyyy mm dd" FALSE "'-' (A Hyphen)        e.x. yyyy-mm-dd" FALSE "'.' (A Period)        e.x. yyyy.mm.dd" FALSE "'/' (A Back Slash)    e.x. yyyy/mm/dd" FALSE "'\' (A Forward Slash) e.x. yyyy\mm\dd" FALSE "''  (No Space)        e.x. yyyymmdd")
		if [ "$seperator" = "' ' (A Space)         e.x. yyyy mm dd" ]; then
			sep="-"
			sep1="space"
		elif [ "$seperator" = "'-' (A Hyphen)        e.x. yyyy-mm-dd" ]; then
			sep="-"
		elif [ "$seperator" = "'.' (A Period)        e.x. yyyy.mm.dd" ]; then
			sep="."
		elif [ "$seperator" = "'/' (A Back Slash)    e.x. yyyy/mm/dd" ]; then
			sep="/"
		elif [ "$seperator" = "'\' (A Forward Slash) e.x. yyyy\mm\dd" ]; then
			sep='\'
		elif [ "$seperator" = "''  (No Space)        e.x. yyyymmdd" ]; then
			sep=""
		else
			zenity --error --text "You did not select a correct answer.\nStarting Over..."
			f_tapesGTK
		fi
		prefix=$(zenity --entry --title "Prefix text to the datelist." --text "What text would you like to prefix the datelist with/n(Leave blank if you don't want to prefix text to the datelist)")
		append=$(zenity --entry --title "Append text to the datelist." --text "What text would you like to append the datelist with/n(Leave blank if you don't want to append text to the datelist)")
		start=$(zenity --calendar --date-format=%Y-%m-%d --title "Select a start date." --text "What would you like to use as the starting date?")
		end=$(zenity --calendar --date-format=%Y-%m-%d --title "Select an end date." --text "What would you like to use as the ending date?")
		filename=$(zenity --entry --title "Output Filename" --text "What would you like your output file to be named?\nThe file extension .lst will be appended to the filename")
		destination=$(zenity --file-selection --directory --title "File Destination" --text "Where would you like $filename.lst to be placed?")
		zenity --question --no-wrap --title "Create Wordlist." --text "About to create a word list with the dates from: $start\nto $end, format: $dateformat, seperated by the character:'$sep'\n\nWould you like to create the wordlist: $filename.lst?"
		if (( $? == 0 )); then
			f_tape
			zenity --info --timeout=4 --text "The word list: $filename.lst has been created."
			zenity --info --timeout=4 --text "About to move $filename.lst to $destination."
			mv $filename.lst $destination
			if [ -e $destination/$filename.lst ]; then
				zenity --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
				zenity --info --timeout=4 --text "The word list $filename.lst has been successfully moved to: $destination"
				zenity --question --no-wrap --title "Wordify List?" --text "Would you like to Wordify $filename.lst?"
				if (( $? == 0 )); then
					zenity --info --timeout=4 --text "About to Wordify $filename.lst into "$filename"_wordified.lst"
					f_wordifycheck
				else
					zenity --info --timeout=4 --text "Returning to the main menu..."
				fi
			else
				zenity --info --text "$filename.lst does not exist in the directory: $destination\nLet's try that again..."
				f_tapesGTK
			fi
		else
			zenity --info --timeout=4 --text "You selected not to create $filename.lst"
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		fi
}
##tape creator##
function f_tape () {
	if [ "$sep1" = "space" ];then
		bash 3rdparty/datelist -b $start -e $end -f $format -o "$filename"1.lst -s "$sep" -a "$append" -p "$prefix"
		sed 's/-/ /g' "$filename"1.lst > $filename.lst
		rm "$filename"1.lst
		echo $ECHOCOLOR""
	else
		bash 3rdparty/datelist -b $start -e $end -f $format -o $filename.lst -s "$sep" -a "$append" -p "$prefix"
		echo $ECHOCOLOR""
	fi
}
##tapes datelist##
function f_tapes () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_tapesGTK
	else
		echo "About to create a word list for a range of dates with Tape's Datelist"
		sleep 2
		f_echobreak
		echo "1) ddmmyy"
		echo "2) ddmmyyyy"
		echo "3) mmddyy"
		echo "4) mmddyyyy"
		echo "5) yymmdd"
		echo "6) yyyymmdd" 
		echo
		echo "Enter date format you would like to use?"
		echo
		read dateformat
		if [ "$dateformat" = "1" ]; then
			format="ddmmyy"
		elif [ "$dateformat" = "2" ]; then
			format="ddmmyyyy"
		elif [ "$dateformat" = "3" ]; then
			format="mmddyy"
		elif [ "$dateformat" = "4" ]; then
			format="mmddyyyy"
		elif [ "$dateformat" = "5" ]; then
			format="yymmdd"
		elif [ "$dateformat" = "6" ]; then
			format="yyyymmdd"
		else
			echo "You did not enter the correct answer."
			echo 
			echo "Starting Over..."
			sleep 3
			f_tapes
		fi
		f_echobreak
		echo "1) ' ' (A Space)         e.x. yyyy mm dd"
		echo "2) '-' (A Hyphen)        e.x. yyyy-mm-dd"
		echo "3) '.' (A Period)        e.x. yyyy.mm.dd"
		echo "4) '/' (A Back Slash)    e.x. yyyy/mm/dd"
		echo "5) '\' (A Forward Slash) e.x. yyyy\mm\dd"
		echo "6) ''  (No Space)        e.x. yyyymmdd"
		echo
		echo "What would you like to use as a seperator?"
		echo
		read seperator
		if [ "$seperator" = "1" ]; then
			sep=' '
		elif [ "$seperator" = "2" ]; then
			sep="-"
		elif [ "$seperator" = "3" ]; then
			sep="."
		elif [ "$seperator" = "4" ]; then
			sep="/"
		elif [ "$seperator" = "5" ]; then
			sep='\'
		elif [ "$seperator" = "6" ]; then
			sep=""
		else
			echo "You did not enter the correct answer."
			echo 
			echo "Starting Over..."
			sleep 3
			f_tapes
		fi
		f_echobreak
		echo "What would you like to use as the starting date?"
		echo "    (The date must be in yyyy-mm-dd format)"
		echo
		read start
		echo
		echo
		echo "What would you like to use as the ending date?"
		echo "  (The date must be in yyyy-mm-dd format)"
		echo
		read end
		echo
		echo "What text would you like to prefix the date with?"
		echo "  (Leave blank if you would not like to prefix)"
		echo
		read prefix
		echo
		echo "What text would you like to append the date with?"
		echo "  (Leave blank if you would not like to append)"
		echo
		read append
		echo
		echo "  What would you like your output file to be named?"
		echo "The file extension .lst will be appended to the filename"
		echo
		read filename	
		echo
		echo "Where would you like $filename.lst to be placed?"
		echo "e.x. /root/Desktop/"
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
		sleep 1
		echo "About to create a word list with the dates from:" $start
		echo "     to $end, seperated by the character:'$sep'"
		echo "Would you like to create the wordlist: $filename.lst? (y/n)"
		echo
		read createfile
		if [ "$createfile" = "y" ]; then
			f_tape
			echo
			echo "The word list: $filename.lst has been created."
			echo
			echo "About to move $filename.lst to $destination."
			mv $filename.lst $destination
			if [ -e $destination/$filename.lst ]; then
				echo
				echo "$filename.lst exists in the directory: $destination"
				echo
				sleep 1
				echo "The word list $filename.lst has been successfully moved to: $destination"
				echo
				sleep 2
				echo "Would you like to wordify the datelist you just created? (y/n)"
				echo
				read wordify
				if [ "$wordify" = "y" ]; then
					f_wordifycheck
				else
					echo
					echo "Returning to the main menu..."
					sleep 2
				fi
			else
				echo
				echo "$filename.lst does not exist in the directory: $destination"
				echo
				sleep 2
				echo "Let's try this again..."
				sleep 2
				f_tapes
			fi
		else
			echo "You selected not to create $filename.lst"
			echo
			echo "Returning to the main menu..."
			sleep 3
			f_menu
		fi
	fi
}
##cupp config reorest##
function f_cupprestore () {
	f_echobreak
	echo "About to replace the CUPP config file with the default configuration."
	echo
	sleep 2
	echo "Restoring the default config from this script's backup folder (/backup/)."
	sleep 1
	rm /usr/bin/cupp.cfg
	cp backup/cupp.cfg /usr/bin
	if [ -e /usr/bin/cupp.cfg ]; then
		echo
		echo "cupp.cfg exists in the directory: /usr/bin"
		echo
		sleep 2
	else
		echo
		echo "cupp.cfg does not exist in the directory: /usr/bin"
		echo
		sleep 1
		echo "Let's try this again..."
		sleep 1
		f_cupprestore
	fi
	f_echobreak
	echo "Your CUPP should now be set to its default values."
	sleep 6
}
##cupp config replacer##
function f_cuppreplacer () {
	f_echobreak
	echo "About to replace the CUPP config file with a more in depth and thorough configuration."
	echo
	echo "This file will create more manipulations, resulting in a larger word list."
	sleep 2
	echo
	echo "Backing up the current config file to this script's backup folder (/backup/)."
	sleep 1
	mkdir backup
	mv /usr/bin/cupp.cfg backup
	if [ -e backup/cupp.cfg ]; then
		echo
		echo "cupp.cfg exists in the directory: /backup/"
		echo
		sleep 2
	else
		echo
		echo "cupp.cfg does not exist in the directory: /backup/"
		echo
		sleep 1
		echo "Let's try this again..."
		sleep 1
		f_cuppreplacer
	fi
	sleep 2
	echo "Copying the updated config file to the CUPP folder."
	echo
	sleep 2
	cp 3rdparty/cupp.cfg /usr/bin
	if [ -e /usr/bin/cupp.cfg ]; then
		echo
		echo "The new cupp.cfg exists in the directory: /usr/bin"
		echo
		sleep 3
	else
		echo
		echo "The new cupp.cfg does not exist in the directory: /usr/bin"
		echo
		sleep 1
		echo "Let's try this again..."
		sleep 2
		f_cuppreplacer
	fi
	f_echobreak
	echo "Your CUPP should now create more thorough word lists!"
	sleep 6
}
##cupp##
function f_cupp () {
		f_echobreak
		echo "Loading /usr/bincupp.py, the Common User Password Profiler."
		echo
		sleep 1
		bash -c "cd /usr/bin && ./cupp.py -i;sudo -s"
}
function f_policyGTK () {
	echo
	echo "The policy password maker does not have a GTK version just yet."
	echo
	sleep 3
	echo "Switching to CLI version"
	echo
	sleep 3
	GTK="n"
	f_policy
}
function f_policy () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_policyGTK
	else
		rm policy.csv
		f_echobreak
		echo "About to create a word list based on a specific password policy."
		echo
		sleep 1
		echo
		echo
		echo "Please enter the set password length."
		echo
		read length
		echo
		echo "Please enter the minimum number of lower case characters."
		echo
		read minlower
		echo
		echo "Please enter the maximum number of lower case characters."
		echo
		read maxlower
		echo
		echo "Please enter the minimum number of upper case characters."
		echo
		read minupper
		echo
		echo "Please enter the maximum number of upper case characters."
		echo
		read maxupper
		echo
		echo "Please enter the minimum number of number characters."
		echo
		read minnumber
		echo
		echo "Please enter the maximum number of number characters."
		echo
		read maxnumber
		echo
		echo "Please enter the minimum number of special characters."
		echo
		read minspecial
		echo
		echo "Please enter the maximum number of special case characters."
		echo
		read maxspecial
		echo
		echo "What would you like the output word list to be named?"
		echo "(The file extension .lst will be appended to your selection)"
		echo
		read outputfile
		echo
		echo "Where would you like the final word list: $outputfile to be placed?"
		echo "(e.x. /root/Desktop/)"
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
					f_policy
				done
			else	
			sleep 1
			echo -en "\nEnter the full path to the directory that contains the files to merge: (ex. /home/loser/):"
			read destination
			fi
		done
		echo
		echo "Would you like to create the policy: policy.csv? (y/n)"
		echo
		read create
		if [ "$create" = "y" ]; then
			echo
			echo "About to create the mask file for policy.csv in this directory."
			echo
			python /usr/bin/policygen -o "policy.csv" --length=$length --mindigits=$minnumber --minlower=$minlower --minupper=$minupper --minspecial=$minspecial --maxdigits=$maxnumber --maxlower=$maxlower --maxupper=$maxupper --maxspecial=$maxspecial
			echo
			echo
			echo "Finished creating policy.csv"
			sleep 2
			if [ -e policy.csv ]; then
				echo
				echo "policy.csv exists in the script directory."
				echo
				sleep 1
				echo
				echo "About to create a word list from policy.csv"
				sleep 2
				f_policygen
			else
				echo
				echo "policy.csv does not exist in the script directory."
				echo
				sleep 1
				echo "Let's try this again..."
				sleep 1
			fi			
		else
			echo "You chose not to create policy.csv at this point."
			sleep 1
			echo "Returning to the main menu..."
			sleep 3
			f_menu
		fi

	fi
}
function f_policygen () {
	f_echobreak
	crunchfile=1
	crunchmax=$(wc -l "policy.csv" | awk -F " "  '{print$1}')
	echo "Replacing the policygen patterns with something we can use for Crunch."
	sed s/?l/@/g "policy.csv" > temp.txt
	sed s/?u/,/g temp.txt > temp1.txt
	rm temp.txt
	sed s/?d/%/g temp1.txt > temp2.txt
	rm temp1.txt
	sed s/?s/^/g temp2.txt > temp1.txt
	rm temp2.txt
	echo "Crunchmax: $crunchmax"
	sleep 6
	until [ "$crunchfile" -gt "$crunchmax" ]; do
	let crunchfile1=crunchfile+1
	sed -e ''$crunchfile's/$/ -o '$crunchfile'.dic/' temp$crunchfile.txt > temp$crunchfile1.txt
	let crunchfile=crunchfile+1
	echo "Debug: $crunchfile"
	done
	sed -e 's#^#/usr/bin/crunch '$length' '$length' -t #' temp$crunchfile.txt > "tempscript.sh"
	rm *.txt
	echo "About to generate the temp lists with Crunch."
	echo
	sleep 1
	bash tempscript.sh
	echo
	echo "Combining the temp lists into $outputfile.lst"
	cat *.dic > "$outputfile".lst
	echo
	sleep 2
	echo "Moving $outputfile.lst to $destination"
	mv "$outputfile.lst" "$destination"
	echo
	sleep 2
	echo "Cleaning up the temp files."
	echo
	sleep 1
	rm *.dic
	rm tempscript.sh
	rm policy.csv
	if [ -e "$destination"/"$outputfile".lst ]; then
		lines=$(wc -l "$destination"/"$outputfile".lst | awk -F " "  '{print$1}')
		echo "$outputfile.lst exists in the directory: $destination"
		echo
		sleep 2
		echo
		echo "$outputfile.lst was successfully created with $lines lines of passwords."
		sleep 4
	else
		echo
		echo "$outputfile.lst does not exist in the directory: $destination"
		echo
		sleep 2
		echo "Let's try this again..."
		sleep 2
	fi
	echo
	echo "Returning to the main menu..."
	sleep 3
}
##precalculate genpmk for cowpatty GTK##
function f_genpmkGTK () {
		echo
		zenity --info --timeout=6 --text "About to pre-compute hashes for a word list and ESSID.\nThis should drastically cut down the time to crack WPA."
		ssid=$(zenity --entry --title "Network SSID" --text "Enter the name (SSID) of the network you would like to attack.")
		dicfile=$(zenity --file-selection --title "Word list to use" --text "Select the word list you would like to pre-compute hashed for.")
		outfile=$(zenity --entry --title "Output List" --text "Enter the name of the output hash file you would like to create.\n(The file extension .lst will be appended to your selection.)")
		destination=$(zenity --file-selection --directory --title "Output directory." --text "Enter the directory you would like to place the output: $outfile.lst")
		zenity --question --title "Create $outfile.lst" --text "Would you like to go ahead and pre-compute the hash file: $outfile.lst?"
		if (( $? == 0 )); then
			zenity --info --timeout=4 --text "About to pre-compute $outfile.lst\nwith Genpmk in: $destination."
			genpmk -f "$dicfile" -s "$ssid" -d "$destination/$outfile.lst" -v
			zenity --info --timeout=4 --text "Finished creating $outfile.lst in: $destination."
			if [ -e "$destination/$outfile.lst" ]; then
				zenity --info --timeout=4 --text "$outfile.lst exists in the directory: $destination"
			else
				zenity --info --timeout=4 --text "$outfile.lst does not exist in the directory: $destination\nLet's try this again..."
				f_genpmkGTK
			fi
			
		fi
}
##precalculate genpmk for cowpatty##
function f_genpmk () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_genpmkGTK
	else
		echo
		echo "About to pre-compute hashes for a word list and ESSID."
		echo "This should drastically cut down the time to crack WPA."
		echo
		sleep 1
		echo "Enter the name (SSID) of the network you would like to attack."
		echo
		read ssid
		echo
		echo "Enter the full names and directory of the word list you would like to pre-compute."
		echo "(e.x. /root/Desktop/wordlist.lst)"
		echo
		read dicfile
		echo 
		echo "Enter the name of the output hash file you would like to create."
		echo "(The file extension .lst will be appended to your selection."
		echo
		read outfile
		echo
		echo "Enter the directory you would like to place the output: $outfile."
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
					f_genpmk
				done
			else	
				sleep 1
				echo "Where would you like the output hash file to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo
		echo "Would you like to go ahead and pre-compute the hash file: $outfile.lst? (y/n)"
		echo
		read compute
		if [ "$compute" = "y" ]; then
			echo
			echo "About to pre-compute $outfile.lst with Genpmk in the directory: $destination."
			echo
			genpmk -f "$dicfile" -s "$ssid" -d "$destination/$outfile.lst" -v
			echo
			echo "Finished creating $outfile.lst in: $destination"
			echo
			sleep 1
			if [ -e "$destination/$outfile.lst" ]; then
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
				f_genpmk
			fi
			
		fi
	fi
}
##cewl##
function f_cewl () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_cewlgtk
	else
		echo "About to create a word list from a website with CEWL."
		echo
		echo
		echo "Please enter the website you would like to generate."
		echo "(e.x. www.google.com )"
		echo
		read website
		echo
		echo "What would you like the output word list to be named?"
		echo "(The file extension .lst will be appended to your selection.)"
		echo
		read filename
		echo
		echo "Enter the destination where you would like your word list(s) to be placed."
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
					f_cewl
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo
		echo "What would you like your minimum word length to be?"
		echo
		read length
		echo
		echo "Would you like to include e-mail addresses in the results? (y/n)"
		echo
		read email
		if [ "$email" = "y" ]; then
			echo
		else
			echo
			echo "Would you like to gather words from websites $website links too? (y/n)"
			echo
			read spider
			if [ "$spider" = "y" ]; then
				echo
				echo "How many links deep would you like the spiderer to search for words?"
				echo "(It is advised you stay under 3 links deep.)"
				echo
				read deep
				echo
				echo "Would you like to create $filename.lst from $website now? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then
					echo
					echo "About to create $filename.lst from $website."
					echo 
					sleep 2
					cd /usr/share/cewl/;ruby cewl.rb -w $destination/"$filename.lst" -o -d $deep -m $length -v "$website"
					if [ -e $destination/$filename.lst ]; then
						echo
						echo "$filename.lst exists in the directory: $destination"
						echo
						sleep 1
						echo "$filename.lst has been successfully create from $website in $destination."
						echo
						sleep 2
						echo
						echo "Returning to the main menu..."
						echo
						sleep 2
						f_menu
					else
						echo
						echo "$filename.lst does not exist in the directory: $destination"
						echo
						sleep 1
						echo "Let's try this again..."
						sleep 1
						f_cewl
					fi
				else
					echo
					echo "You chose not to create the word list: $filename.lst at this time."
					echo
					echo "Returning to the main menu."
					echo
					sleep 4
					f_menu
				fi
			else
				echo
				echo "Would you like to create $filename.lst from $website now? (y/n)"
				echo
				read create
				if [ "$create" = "y" ]; then
					echo
					echo "About to create $filename.lst from $website."
					echo 
					sleep 2
					cd /usr/share/cewl/;ruby cewl.rb -w $destination/"$filename.lst" -m $length -v "$website"
					if [ -e $destination/$filename.lst ]; then
						echo
						echo "$filename.lst exists in the directory: $destination"
						echo
						sleep 1
						echo "$filename.lst has been successfully create from $website in $destination."
						echo
						sleep 2
						echo
						echo "Returning to the main menu..."
						echo
						sleep 2
						f_menu
					else
						echo
						echo "$filename.lst does not exist in the directory: $destination"
						echo
						sleep 1
						echo "Let's try this again..."
						sleep 1
						f_cewl
					fi
				else
					echo
					echo "You chose not to create the word list: $destination/$filename.lst at this time."
					echo
					echo "Returning to the main menu."
					echo
					sleep 4
					f_menu
				fi
			fi
		fi
		echo
		echo "Would you like to gather words from websites $website links too? (y/n)"
		echo
		read spider
		if [ "$spider" = "y" ]; then
			echo
			echo "How many links deep would you like the spiderer to search for words?"
			echo "(It is advised you stay under 3 links deep.)"
			echo
			read deep
			echo
			echo "Would you like to create $filename.lst from $website now? (y/n)"
			echo
			read create
			if [ "$create" = "y" ]; then
				echo
				echo "About to create $filename.lst from $website."
				echo 
				sleep 2
				cd /usr/share/cewl/;ruby cewl.rb -w $destination/"$filename.lst" -o -d $deep -e "$filename"_emails.lst -m $length -v "$website"
				echo
				if [ -e $destination/$filename.lst ]; then
					echo
					echo "$filename.lst exists in the directory: $destination"
					echo
					sleep 1
					echo "$filename.lst has been successfully create from $website in $destination."
					echo
					sleep 2
					echo
					echo "Returning to the main menu..."
					echo
					sleep 2
					f_menu
				else
					echo
					echo "$filename.lst does not exist in the directory: $destination"
					echo
					sleep 1
					echo "Let's try this again..."
					sleep 1
					f_cewl
				fi
			else
				echo
				echo "You chose not to create the word list: $filename.lst at this time."
				echo
				echo "Returning to the main menu."
				echo
				sleep 4
				f_menu
			fi
		else
			echo
		fi

	fi
}
##batch convert pdf/ebook##
function f_batchconvertgtk () {
zenity --info --timeout=6 --text "About to convert multiple PDF / Ebook files into a word list\n(This may not work on all Ebook extensions)"
filename=$(zenity --entry --title "Output filename" --text "What would you like the output file to be named?\n(The file extension .lst will be appended to your selection.)")
zenity --info --timeout=4 --text "Where would you like $filename.lst to be placed?"
destination=$(zenity --file-selection --directory --title "$filename.lst destination")
selection=$(zenity --file-selection --multiple --title "Select the files to convert (Hold CTRL to select multiple files)")
rm tempdocs.temp
formatted=$(echo "$selection" | tr "|" "\n")
echo "$formatted" >> tempdocs.temp
format=$(zenity  --list  --checklist  --title "Document Format" --text "Select a document format to convert.\n(Select one format at a time)" --height=220 --column "Select" --column "Format to convert" FALSE 'PDF' FALSE 'EBOOK')
zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $filename.lst in $destination"
temp="1"
if (( $? == 0 )); then
	if [ "$format" = "PDF" ]; then
		mkdir temp
		cat tempdocs.temp | while read line
		do
			document=$(echo "$line")
			echo
			echo
			echo "Creating $filename.lst from $document..."
			echo
			echo
			pdftotext -nopgbrk -raw "$document" temp"$temp".temp
			mv "temp"$temp".temp" temp
			tr " " "\n"<temp/temp"$temp".temp|sed -n '/^$/!p' > temp/output"$temp".tmp
			let temp=$(($temp + 1))
		done
		cat temp/*.tmp | sort -u | uniq > "$destination"/"$filename".lst
		zenity --info --timeout=4 --text "Removing the temp files..."
		rm *.temp
		rm -r temp
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=4 --text "$filename.lst exists in $destination"
			zenity --info --timeout=4 --text "Successfully created $filename.lst"
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=4 --text "$filename.lst does not exist in $destination"
			zenity --info --timeout=4 --text "Starting over..."
			f_batchconvert
		fi
	elif [ "$format" = "EBOOK" ]; then
		mkdir temp
		cat tempdocs.temp | while read line
		do
			document=$(echo "$line")
			echo
			echo
			echo "Creating $filename.lst from $document..."
			echo
			echo
			ebook-convert "$document" temp"$temp".txt
			mv "temp"$temp".txt" temp
			tr " " "\n"<temp/temp"$temp".txt|sed -n '/^$/!p' > temp/output"$temp".tmp
			let temp=$(($temp + 1))
		done
		cat temp/*.tmp | sort -u | uniq > "$destination"/"$filename".lst
		zenity --info --timeout=4 --text "Removing the temp files..."
		rm *.temp
		rm -r temp
		if [ -e "$destination"/"$filename".lst ]; then
			zenity --info --timeout=4 --text "$filename.lst exists in $destination"
			zenity --info --timeout=4 --text "Successfully created $filename.lst"
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=4 --text "$filename.lst does not exist in $destination"
			zenity --info --timeout=4 --text "Starting over..."
			f_batchconvert
		fi
	else
		zenity --error --timeout=8 --text "You did not select a correct format, starting over..."
		f_batchconvertgtk
	fi
else
	zenity --info --timeout=4 --text "You chose not to create $filename.lst at this time."
	zenity --info --timeout=4 --text "Returning to the main menu..."
	rm *.temp
	f_menu
fi
}
##ebook to text gtk##
function f_ebookgtk () {
	zenity --info --timeout=4 --text "About to create a word list from an Ebook file."
	zenity --info --timeout=4 --text "Select the Ebook file to convert.\n(not all formats work)"
	ebook=$(zenity --file-selection --title "Ebook to Convert")
	if [ -e "$ebook" ]; then
		zenity --info --timeout=4 --text "$ebook exists, continuing..."
		filename=$(zenity --entry --title "Output filename" --text "What would you like the output file to be named?\n(The file extension .lst will be appended to your selection.)")
		zenity --info --timeout=4 --text "Where would you like $filename.lst to be placed?"
		destination=$(zenity --file-selection --directory --title "$filename.lst destination")
		zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $filename.lst in $destination"
		if (( $? == 0 )); then
			zenity --info --timeout=4 --text "Creating $filename.lst from $ebook..."
			ebook-convert "$ebook" temp.txt
			echo $ECHOCOLOR""
			tr " " "\n"<temp.txt|sed -n '/^$/!p' > output.temp
			cat output.temp | sort -u | uniq > "$destination"/"$filename".lst
			zenity --info --timeout=4 --text "Removing the temp files..."
			rm temp.txt
			rm *.temp
			if [ -e "$destination"/"$filename".lst ]; then
				zenity --info --timeout=4 --text "$filename.lst exists in $destination"
				zenity --info --timeout=4 --text "Successfully created $filename.lst"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=4 --text "$filename.lst does not exist in $destination"
				zenity --info --timeout=4 --text "Starting over..."
				f_ebook
			fi
		else
			zenity --info --timeout=4 --text "You chose not to create $filename.lst at this time."
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		fi
	else
		zenity --info --timeout=4 --text "$ebook does not exist, starting over..."
		f_ebook
	fi
}
##ebook to text##
function f_ebook () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_ebookgtk
else
	echo "About to create a word list from a ebook file."
	echo
	sleep 2
	echo "Enter the full path and name to the ebook file to convert."
	echo "        (e.x. /root/Desktop/WordlistToUse.mobi)"
	echo "      (no all ebook formats work with this feature)"
	echo
	read ebook
	echo
	if [ -e "$ebook" ]; then
		echo "$ebook exists, continuing..."
		echo
		sleep 2
		echo "What would you like the output file to be named?"
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
					f_ebook
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo
		echo "Would you like to go ahead and create $filename.lst in $destination"
		echo "from the ebook file: $ebook? (y/n)"
		echo
		read create
		if [ "$create" = "y" ]; then
			echo
			echo "Creating $filename.lst from $ebook..."
			echo
			sleep 2
			ebook-convert "$ebook" temp.txt
			echo $ECHOCOLOR""
			tr " " "\n"<temp.txt|sed -n '/^$/!p' > output.temp
			cat output.temp | sort -u | uniq > "$destination"/"$filename".lst
			echo "Removing the temp files..."
			echo
			sleep 2
			rm temp.txt
			rm *.temp
			if [ -e "$destination"/"$filename".lst ]; then
				echo "$filename.lst exists in $destination"
				echo
				sleep 2
				echo "Successfully created $filename.lst"
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
				f_ebook
			fi
		elif [ "$create" = "n" ]; then
			echo
			echo "You chose not to create $filename.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo
			echo "You did not enter a correct answer."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_ebook
		fi
	else
		echo "$ebook does not exist, starting over..."
		echo
		sleep 3
		f_ebook
	fi
fi
}
##pdf to text gtk##
function f_pdfgtk () {
	zenity --info --timeout=4 --text "About to create a word list from a PDF file."
	zenity --info --timeout=4 --text "Select the PDF file to convert."
	pdf=$(zenity --file-selection --title "PDF to Convert")
	if [ -e "$pdf" ]; then
		zenity --info --timeout=4 --text "$pdf exists, continuing..."
		filename=$(zenity --entry --title "Output filename" --text "What would you like the output file to be named?\n(The file extension .lst will be appended to your selection.)")
		zenity --info --timeout=4 --text "Where would you like $filename.lst to be placed?"
		destination=$(zenity --file-selection --directory --title "$filename.lst destination")
		zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $filename.lst in $destination"
		if (( $? == 0 )); then
			zenity --info --timeout=4 --text "Creating $filename.lst from $pdf..."
			pdftotext -nopgbrk -raw "$pdf" temp.temp
			tr " " "\n"<temp.temp|sed -n '/^$/!p' > output.temp
			cat output.temp | sort -u | uniq > "$destination"/"$filename".lst
			zenity --info --timeout=4 --text "Removing the temp files..."
			rm *.temp
			if [ -e "$destination"/"$filename".lst ]; then
				zenity --info --timeout=4 --text "$filename.lst exists in $destination"
				zenity --info --timeout=4 --text "Successfully created $filename.lst"
				zenity --info --timeout=4 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=4 --text "$filename.lst does not exist in $destination"
				zenity --info --timeout=4 --text "Starting over..."
				f_pdf
			fi
		else
			zenity --info --timeout=4 --text "You chose not to create $filename.lst at this time."
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		fi
	else
		zenity --info --timeout=4 --text "$pdf does not exist, starting over..."
		f_pdf
	fi
}
##pdf to text##
function f_pdf () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_pdfgtk
else
	echo "About to create a word list from a PDF file."
	echo
	sleep 2
	echo "Enter the full path and name to the PDF file to convert."
	echo "(e.x. /root/Desktop/WordlistToUse.pdf)"
	echo
	read pdf
	echo
	if [ -e "$pdf" ]; then
		echo "$pdf exists, continuing..."
		echo
		sleep 2
		echo "What would you like the output file to be named?"
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
					f_pdf
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
		echo
		echo "Would you like to go ahead and create $filename.lst in $destination"
		echo "from the PDF file: $pdf? (y/n)"
		echo
		read create
		if [ "$create" = "y" ]; then
			echo
			echo "Creating $filename.lst from $pdf..."
			echo
			sleep 2
			pdftotext -nopgbrk -raw "$pdf" temp.temp
			tr " " "\n"<temp.temp|sed -n '/^$/!p' > output.temp
			cat output.temp | sort -u | uniq > "$destination"/"$filename".lst
			echo "Removing the temp files..."
			echo
			sleep 2
			rm *.temp
			if [ -e "$destination"/"$filename".lst ]; then
				echo "$filename.lst exists in $destination"
				echo
				sleep 2
				echo "Successfully created $filename.lst"
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
				f_pdf
			fi
		elif [ "$create" = "n" ]; then
			echo
			echo "You chose not to create $filename.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo
			echo "You did not enter a correct answer."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_pdf
		fi
	else
		echo "$pdf does not exist, starting over..."
		echo
		sleep 3
		f_pdf
	fi
fi
}
function f_batchconvert () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_batchconvertgtk
else
echo "About to convert multiple PDF / Ebook files into a word list"
echo "       (This may not work on all Ebook extensions)"
echo
sleep 3
echo "      What would you like the output file to be named?"
echo "(The file extension .lst will be appended to your selection.)"
echo
read filename
echo
echo "Where would you like $filename.lst to be placed?"
echo "              (e.x. /root/Desktop)"
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
					f_batchconvert
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
echo " Enter the directory of PDF/EBOOK files to convert"
echo "(Make sure the folder is strictly PDF or EBooks only!"
echo "              (e.x. /root/Desktop)"
echo
sleep 3
read selection
echo
	while [ ! -d "$selection" ]
		do
			echo
			echo "Directory cannot be found or does not exist"
			echo
			sleep 3
			echo "Starting over..."
			f_batchconvert
			
		done
rm tempdocs.temp
for f in "$selection"/*
do
echo "$f" >> tempdocs.temp
done
echo "Select a document format to convert"
echo
sleep 2
echo "1) Ebook"
echo "2) PDF"
echo "3) Return to the main menu"
echo
read filetype
temp="1"
if [ "$filetype" = "1" ];then
	format="EBOOK"
elif [ "$filetype" = "2" ];then
	format="PDF"
elif [ "$filetype" = "3" ];then
	echo "You chose to return to the main menu"
	echo
	sleep 2
	echo "Returning to the main menu..."
	echo
	sleep 3
	f_menu
else
	echo "You did not input a correct selection"
	echo
	sleep 2
	echo "Starting over..."
	echo
	sleep 3
	f_batchconvert
fi
echo
echo "Would you like to go ahead and create $filename.lst"
echo "in $destination? (y/n)"
echo
read create
echo
if [ "$create" = "y" ]; then
	if [ "$format" = "PDF" ]; then
		mkdir temp
		cat tempdocs.temp | while read line
		do
			document=$(echo "$line")
			echo
			echo
			echo "Creating $filename.lst from $document..."
			echo
			echo
			pdftotext -nopgbrk -raw "$document" temp"$temp".temp
			mv "temp"$temp".temp" temp
			tr " " "\n"<temp/temp"$temp".temp|sed -n '/^$/!p' > temp/output"$temp".tmp
			let temp=$(($temp + 1))
		done
		cat temp/*.tmp | sort -u | uniq > "$destination"/"$filename".lst
		echo $ECHOCOLOR""
		echo
		echo "Removing the temp files..."
		echo
		rm *.temp
		rm -r temp
		if [ -e "$destination"/"$filename".lst ]; then
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully created $filename.lst"
			echo
			sleep 3
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
			sleep 3
			f_batchconvert
		fi
	elif [ "$format" = "EBOOK" ]; then
		mkdir temp
		cat tempdocs.temp | while read line
		do
			document=$(echo "$line")
			echo
			echo
			echo "Creating $filename.lst from $document..."
			echo
			echo
			ebook-convert "$document" temp"$temp".txt
			mv "temp"$temp".txt" temp
			tr " " "\n"<temp/temp"$temp".txt|sed -n '/^$/!p' > temp/output"$temp".tmp
			let temp=$(($temp + 1))
		done
		cat temp/*.tmp | sort -u | uniq > "$destination"/"$filename".lst
		echo $ECHOCOLOR""
		echo
		echo "Removing the temp files..."
		echo
		rm *.temp
		rm -r temp
		if [ -e "$destination"/"$filename".lst ]; then
			echo "$filename.lst exists in $destination"
			echo
			sleep 2
			echo "Successfully created $filename.lst"
			echo
			sleep 3
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
			sleep 3
			f_batchconvert
		fi
	fi
else
	echo "You chose not to create $filename.lst at this time."
	echo
	sleep 2
	echo "Returning to the main menu..."
	echo
	sleep 3
	rm *.temp
	f_menu
fi
fi
}
##file / directory lister gtk##
function f_filedirgtk () {
	zenity --info --timeout=5 --text "About to create a word list from directory and file names."
	filename=$(zenity --entry --title "Output file name" --text "What would you like to name the output word list?\n(The file extension .lst will be added to your entry.)")
	zenity --info --timeout=5 --text "Where would you like to place $filename.lst?"
	destination=$(zenity --file-selection --directory --title "$filename.lst location")
	zenity --question --text "Would you like to use all your files and directories (y) or\nwould you like to specify a specific directory to use (n)?"
	if (( $? == 0 )); then
		yesorno="y"
	else
		yesorno="n"
		zenity --info --timeout=5 --text "Select the directory you would like to create a word list from."
		directory=$(zenity --file-selection --directory --title "Location to create a word list from")
	fi
	zenity --question --title "Create $filename.lst" --text "Would you like to go ahead and create $filename.lst in $destination? (y/n)"
	if (( $? == 0 )); then
		if [ "$yesorno" = "y" ]; then
			zenity --info --timeout=5 --text "Creating $filename.lst in $destination..."
			find /* | cat > "$destination"/"$filename".lst
			if [ -e "$destination"/"$filename".lst ]; then
				zenity --info --timeout=5 --text "$filename.lst exists in $destination."
				zenity --info --timeout=5 --text "Successfully created $filename.lst with all your directory and files names."
				zenity --info --timeout=5 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=5 --text "$filename.lst does not exist in $destination."
				zenity --info --timeout=5 --text "Starting over..."
				f_filedir
			fi
		elif [ "$yesorno" = "n" ]; then
			zenity --info --timeout=5 --text "Creating $filename.lst in $destination..."
			find "$directory"/* | cat > "$destination"/"$filename".lst
			if [ -e "$destination"/"$filename".lst ]; then
				zenity --info --timeout=5 --text "$filename.lst exists in $destination."
				zenity --info --timeout=5 --text "Successfully created $filename.lst with all your directory and files names\nfrom: $destination."
				zenity --info --timeout=5 --text "Returning to the main menu..."
				f_menu
			else
				zenity --info --timeout=5 --text "$filename.lst does not exist in $destination."
				zenity --info --timeout=5 --text "Starting over..."
				f_filedir
			fi
		fi
		else
			echo "You chose not to create $filename.lst at this time."
			echo
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 3
			f_menu
		fi
}
##file / directory lister##
function f_filedir () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_filedirgtk
else
	echo "About to create a word list from directory and file names."
	echo
	sleep 2
	echo "What would you like to name the output word list?"
	echo "(The file extension .lst will be added to your entry.)"
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
					f_filedir
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
	echo
	echo "Would you like to use all your files and directories (y) or"
	echo "would you like to specify a specific directory to use (n)? (y/n)"
	echo
	read yesorno
	echo
	if [ "$yesorno" = "n" ]; then
		echo "Enter the directory you would like to create a word list from."
		echo "(e.x. /root/Desktop)"
		echo
		read directory
		echo
		if [ -e "$directory" ]; then
			echo "$directory exists."
			echo
			sleep 2
		else
			echo "$destination does not exist."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 3
			f_filedir
		fi
	else
		echo
	fi
	echo
	echo "Would you like to go ahead and create $filename.lst in $destination? (y/n)"
	echo
	read create
	echo
	if [ "$create" = "y" ]; then
		if [ "$yesorno" = "y" ]; then
			echo "Creating $filename.lst in $destination..."
			echo
			sleep 1
			find /* | cat > "$destination"/"$filename".lst
			if [ -e "$destination"/"$filename".lst ]; then
				echo "$filename.lst exists in $destination."
				echo
				sleep 2
				echo "Successfully created $filename.lst with all your directory and files names."
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "$filename.lst does not exist in $destination."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_filedir
			fi
		elif [ "$yesorno" = "n" ]; then
			echo
			sleep 1
			echo "Creating $filename.lst in $destination..."
			echo
			sleep 1
			find "$directory"/* | cat > "$destination"/"$filename".lst
			if [ -e "$destination"/"$filename".lst ]; then
				echo "$filename.lst exists in $destination."
				echo
				sleep 2
				echo "Successfully created $filename.lst with all your directory and files names"
				echo "from: $destination."
				echo
				sleep 2
				echo "Returning to the main menu..."
				echo
				sleep 3
				f_menu
			else
				echo "$filename.lst does not exist in $destination."
				echo
				sleep 2
				echo "Starting over..."
				echo
				sleep 3
				f_filedir
			fi
		else 
			echo "You did not enter a correct answer."
			echo
			sleep 2
			echo "Starting over..."
			echo
			sleep 3
			f_filedir
		fi
		elif [ "$create" = "n" ]; then
			echo "You chose not to create $filename.lst at this time."
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
		fi
	fi
}
function f_randomgtk () {
	minlength=$(zenity --scale --value=8 --min-value=1 --max-value=64 --step=1 --title "Min Length" --text "What is the minimum password string length you would like to use?")
	maxlength=$(zenity --scale --value=8 --min-value=1 --max-value=64 --step=1 --title "Max Length" --text "What is the maximum password string length you would like to use?")
	charset=$(zenity --entry --title "Charset" --text "Enter the character set you would like to use.")
	consec=$(zenity --scale --value=3 --min-value=1 --max-value=64 --step=1 --title "Consecutive" --text "Select the length of consecutive characters you would like to exclude.")
	maxchar=$(zenity --scale --value=3 --min-value=1 --max-value=64 --step=1 --title "Instances" --text "What is the maximum number of one character you would like to use?")
	output=$(zenity --entry --title "Output file name" --text "What would you like the output file to be named?\n(the file extension .lst will be appended to your selection)")
	destination=$(zenity --file-selection --directory --title "$output.lst destination" --text "Where would you like $output.lst to be placed?")
	zenity --question --title "Create $output.lst" --text "Would you like to go ahead and create $output.lst in $destination? (y/n)"
	if (( $? == 0 )); then
		let consec=$(($consec - 1))
		/usr/bin/crunch $minlength $maxlength $charset | while read line
		do
		filter=$(echo $line | sed "/\([^A-Za-z0-9_]\|[A-Za-z0-9]\)\1\{$consec,\}/d" | sed "/^$/d")
		if [ "$filter" != "" ]; then
			stopp="no"
			number=1
			filter3=$(echo $filter | fold -w1 | sort | uniq -c)
			count=$(echo $line | wc -c)
			let count=$(($count - 1))
			until [[ "$number" -gt "$count" || "$stopp" == "yes" ]]
				do
				filter4=$(echo $filter3 | awk '{print $NF ":" $'$number'}' | sed -n 's/[^:]*://p')
				let number=$(($number + 2))
				if [ "$filter4" -gt "$maxchar" ]; then
					stopp="yes"
				else
					stopp="no"
				fi
			done
				if [ "$stopp" == "no" ] && [ "$number" -gt "$count" ] ; then
					echo $filter | cat >> "$destination"/"$output".lst
				else
					echo
				fi
			else
				echo
			fi
		done
		if [ -e "$destination"/"$output".lst ]; then
			zenity --info --timeout=4 --text "$output.lst exists in $destination"
			sed -i -e '1d' "$destination"/"$output".lst
			sed -i -e '1d' "$destination"/"$output".lst
			sed -i -e '1d' "$destination"/"$output".lst
			sed -i -e '1d' "$destination"/"$output".lst
			zenity --info --timeout=4 --text "Successfully created $output.lst"
			zenity --info --timeout=4 --text "Returning to the main menu..."
			f_menu
		else
			zenity --info --timeout=4 --text "$output.lst does not exist in $destination"
			zenity --info --timeout=4 --text "Unsuccessfully created $output.lst"
			zenity --info --timeout=4 --text "Starting over..."
			f_random
		fi
	elif [ "$create" = "n" ]; then
		echo
	else
		echo
	fi
}
function f_random () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_randomgtk
else
	echo
	echo "What is the minimum password string length you would like to use?"
	echo
	read minlength
	echo
	echo "What is the maximum password string length you would like to use?"
	echo
	read maxlength
	echo
	echo "Enter the character set you would like to use."
	echo
	read charset
	echo
	echo "Enter the length of consecutive characters you would like to exclude."
	echo "(e.x. 3)"
	echo
	read consec
	echo
	echo "What is the maximum number of one character you would like to use?"
	echo "(e.x. 3)"
	echo
	read maxchar
	echo
	echo "What would you like the output file to be named?"
	echo "(the file extension .lst will be appended to your selection)"
	echo
	read output
	echo
	echo "Where would you like $output.lst to be placed?"
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
					f_random
				done
			else	
				sleep 1
				echo "Where would you like the output word list to be placed?"
				echo "(e.x. /root/Desktop/)"
				read destination
			fi
		done
	echo
	echo "Would you like to go ahead and create $output.lst in $destination? (y/n)"
	echo
	read create
	echo
	if [ "$create" = "y" ]; then
		echo
		let consec=$(($consec - 1))
		/usr/bin/crunch $minlength $maxlength $charset | while read line
		do
		filter=$(echo $line | sed "/\([^A-Za-z0-9_]\|[A-Za-z0-9]\)\1\{$consec,\}/d" | sed "/^$/d")
		if [ "$filter" != "" ]; then
			stopp="no"
			number=1
			filter3=$(echo $filter | fold -w1 | sort | uniq -c)
			count=$(echo $line | wc -c)
			let count=$(($count - 1))
			until [[ "$number" -gt "$count" || "$stopp" == "yes" ]]
				do
				filter4=$(echo $filter3 | awk '{print $NF ":" $'$number'}' | sed -n 's/[^:]*://p')
				let number=$(($number + 2))
				if [ "$filter4" -gt "$maxchar" ]; then
					stopp="yes"
				else
					stopp="no"
				fi
			done
				if [ "$stopp" == "no" ] && [ "$number" -gt "$count" ] ; then
					echo $filter | cat >> "$destination"/"$output".lst
				else
					echo
				fi
			else
				echo
			fi
		done
		if [ -e "$destination"/"$output".lst ]; then
			echo
			echo "$output.lst exists in $destination"
			sed -i -e '1d' "$destination"/"$output".lst
			sed -i -e '1d' "$destination"/"$output".lst
			sed -i -e '1d' "$destination"/"$output".lst
			sed -i -e '1d' "$destination"/"$output".lst
			echo
			sleep 2
			echo "Successfully created $output.lst"
			echo 
			sleep 2
			echo "Returning to the main menu..."
			echo
			sleep 2
			f_menu
		else
			echo
			echo "$output.lst does not exist in $destination"
			echo
			sleep 2
			echo "Unsuccessfully created $output.lst"
			echo 
			sleep 2
			echo "Starting over..."
			echo
			sleep 2
			f_random
		fi
	elif [ "$create" = "n" ]; then
		echo
	else
		echo
	fi
fi
}

#!/bin/sh
###gatherGTK###
function f_gatherGTK () {
		zenity --no-wrap --error --text='This script was written for BT5 only, if you lose some files\nor program dependencies you have been warned!' --timeout=4 --title='Warning!'
		zenity --no-wrap --info --text "This script will look for word lists over a certain size and consolidate them into one folder.\n(By default this script will search for .lst and .dic files, for more options use the GTK version)\n\nDefault .lst and .dic files that are dependencies for other programs should already be\nfiltered but, it would be a safe bet to scrutinize the file print outs before moving any files.\n\n		!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n		!!! Filtering files less than ~2mb (~2000k) will also prevent this !!!\n		!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n	      You will also be given the option to combine the lists if you so desire."
		zenity --no-wrap --info --text "Select the folder you would like to consolidate the lists to."
		destination=$(zenity --file-selection --directory --confirm-overwrite --text="What folder would you like to consolidate the lists to?\n(ex. /root/Desktop)" --title="Destination");
		zenity --no-wrap --question --title "Confirm Input" --text "You chose: $destination\nIs that correct?"
		if [ "$?" = "0" ]; then
			echo
		else
			f_gatherGTK
		fi
		while [ ! -d "$destination" ]
		do
			zenity --no-wrap --error --text "Directory cannot be found or does not exist"
			zenity --no-wrap --question --title='Create Directory?' --text='Would you like to create a folder for the directory you selected?'
			if [ "$?" = "0" ]; then
				mkdir "$destination"
				while [ ! -d "$destination" ]
				do
					zenity --no-wrap --error --text "Folder: $destination still cannot be found, starting over..."
					f_gather
				done
			else	
				sleep 1
			 	destination=$(zenity --file-selection --directory --confirm-overwrite --text="What folder would you like to consolidate the lists to?\n(ex. /root/Desktop)" --title="Destination");
			fi
		done
		listsize=$(zenity --entry --title='Minimum Size' --text='Enter the minimum file size to search for.\n(Insert the size is kilobytes, i.e. 1MB = 1024)')
		zenity --no-wrap --info --text "Listing the results of your search criteria:\n(The list excludes lists in the path: $destination)"
		find / \( -type d -path /boot/grub -prune -o -path $destination -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
		zenity --no-wrap --info --text "Finished finding the files you requested."
		zenity --no-wrap --question --title='Filter A Directory?' --text='Would you like to filter a directory from your results?'
		if [ "$?" = "0" ]; then
			zenity --no-wrap --info --text "What directory would you like to filter out? (ex. /root/Desktop)" 
			filterdir1=$(zenity --file-selection --directory --confirm-overwrite --text="What folder would you like to consolidate the lists to?\n(ex. /root/Desktop)" --title="Destination");
			zenity --no-wrap --info  --timeout=2 --text "$filterdir1 will be pruned from the search results"
			zenity --no-wrap --info --text "Listing the results of your search criteria:"
			find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
			zenity --no-wrap --info --text "Finished finding the files you requested."
			zenity --no-wrap --question --title='Filter A Directory?' --text='Would you like to filter another directory from your results?'
			if [ "$?" = "0" ]; then
				zenity --no-wrap --info --text "What directory would you like to filter out? (ex. /root/Desktop)" 
				filterdir2=$(zenity --file-selection --directory --confirm-overwrite --text="What folder would you like to consolidate the lists to?\n(ex. /root/Desktop)" --title="Destination");
				zenity --no-wrap --info --timeout=2 --text "$filterdir2 will be pruned from the search results"
				zenity --no-wrap --info --text "Listing the results of your search criteria:"
				find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
				zenity --no-wrap --info --text "Finished finding the files you requested."
				zenity --no-wrap --question --title='Filter A Directory?' --text='Would you like to filter another directory from your results?'
				if [ "$?" = "0" ]; then
					zenity --no-wrap --info --text "What directory would you like to filter out? (ex. /root/Desktop)" 
					filterdir3=$(zenity --file-selection --directory --confirm-overwrite --text="What folder would you like to consolidate the lists to?\n(ex. /root/Desktop)" --title="Destination");
					zenity --no-wrap --info --timeout=2 --text "$filterdir3 will be pruned from the search results"
					zenity --no-wrap --info --text "Listing the results of your search criteria:"
					find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
					zenity --no-wrap --info --text "Finished finding the files you requested."
					zenity --no-wrap --question --title='Filter A Directory?' --text='Would you like to filter another directory from your results?'
					if [ "$?" = "0" ]; then
						zenity --no-wrap --info --text "What directory would you like to filter out? (ex. /root/Desktop)" 
						filterdir4=$(zenity --file-selection --directory --confirm-overwrite --text="What folder would you like to consolidate the lists to?\n(ex. /root/Desktop)" --title="Destination");
						zenity --no-wrap --info --timeout=2 --text "$filterdir4 will be pruned from the search results"
						zenity --no-wrap --info --text "Listing the results of your search criteria:"
						find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
						zenity --no-wrap --info --text "Finished finding the files you requested."
						zenity --no-wrap --question --title='Filter A Directory?' --text='Would you like to filter another directory from your results?'
						if [ "$?" = "0" ]; then
							zenity --no-wrap --info --text "What directory would you like to filter out? (ex. /root/Desktop)" 
							filterdir5=$(zenity --file-selection --directory --confirm-overwrite --text="What folder would you like to consolidate the lists to?\n(ex. /root/Desktop)" --title="Destination");
							zenity --no-wrap --info --text "$filterdir5 will be pruned from the search results"
							zenity --no-wrap --info --text "Listing the results of your search criteria:"
							find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path $filterdir4 -prune -o -path $filterdir4 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
							zenity --no-wrap --info --timeout=2 --text "Finished finding the files you requested, you have reached the filter limit (5)"
							zenity --no-wrap --info --text "About to move the selected word lists to: $destination"
							find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path $filterdir4 -prune -o -path $filterdir5 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
							zenity --no-wrap --info --text "The selected lists have been moved to: $destination\n\nReturning you to the main menu."
						else
							zenity --no-wrap --info --timeout=2 --text "About to move the selected word lists to: $destination"
							echo
							sleep 1
							find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path $filterdir4 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
							zenity --no-wrap --info --text "The selected lists have been moved to: $destination\n\nReturning you to the main menu."
						fi
					else
						zenity --no-wrap --info --timeout=4 --text "About to move the selected word lists to: $destination"
						echo
						sleep 1
						find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
						zenity --no-wrap --info --text "The selected lists have been moved to: $destination\n\nReturning you to the main menu."
					fi
				else
					zenity --no-wrap --info --timeout=4 --text "About to move the selected word lists to: $destination"
					echo
					sleep 1
					find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
					zenity --no-wrap --info --text "The selected lists have been moved to: $destination\n\nReturning you to the main menu."
				fi
			else
				zenity --no-wrap --info --timeout=4 --text "About to move the selected word lists to: $destination"
				echo
				sleep 1
				find / \( -type d -path $filterdir1 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
				zenity --no-wrap --info --text "The selected lists have been moved to: $destination\n\nReturning you to the main menu."
			fi
		else
			zenity --no-wrap --info --timeout=4 --text "About to move the selected word lists to: $destination"
			echo
			sleep 1
			find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
			zenity --no-wrap --info --text "The selected lists have been moved to: $destination\n\nReturning you to the main menu."
		fi		
}
###gatherer###
function f_gather () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_gatherGTK
	else
		f_echobreak
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!!         This script was written for BT5 only, if you lose some files     !!!"
		echo "!!!                or program dependencies you have been warned              !!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		sleep 3
		f_echobreak
		echo "This function will look for word lists over a certain size and consolidate them into one folder."
		echo
		echo "(By default this script will search for .lst and .dic files, for more options use the GTK version)"
		echo
		echo "Default .lst and .dic files that are dependencies for other programs"
		echo "should already be filtered out but, it would be a safe bet to"
		echo "scrutinize the file print outs before removing any files."
		echo
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "!!! Filtering files less than ~2mb (~2000k) will also prevent this !!!"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo
		sleep 2
		echo "You will then be given the option to combine the lists if you so desire."
		echo
		sleep 1
		echo "What folder would you like to consolidate the lists to? (ex. /root/Desktop):"
		echo
		sleep 1
		read destination
		echo
		echo "you chose: $destination"
		sleep 3
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
					f_gather
				done
			else	
				sleep 1
				echo "What folder would you like to consolidate the lists to? (ex. /root/Desktop):"
				read destination
			fi
		done
		echo
		sleep 1
		echo "What is the minimum file size you would like to search for?"
		echo "(Insert the size is kilobytes, i.e. 1MB = 1024)"
		echo
		read listsize
		echo
		echo
		echo
		echo
		echo
		echo "Listing the results of your search criteria:"
		echo "(The list excludes lists in the path: $destination)"
		echo
		sleep 1
		find / \( -type d -path /boot/grub -prune -o -path $destination -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
		echo
		echo "Finished finding the files you requested, would you like to filter out another directory? (y/n)"
		echo
		sleep 1
		read filterdir
		if [ "$filterdir" = "y" ]; then
			echo
			echo "What directory would you like to filter out? (ex. /root/Desktop)" 
			echo
			sleep 1
			read filterdir1
			echo "$filterdir1 will be pruned from the search results"
			echo
			sleep 1
			echo "Listing the results of your search criteria:"
			echo
			sleep 1
			find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
			echo
			echo "Finished finding the files you requested, would you like to filter out another directory? (y/n)"
			echo
			sleep 1
			read filterdir
			if [ "$filterdir" = "y" ]; then
				echo
				echo "What directory would you like to filter out? (ex. /root/Desktop)" 
				echo
				sleep 1
				read filterdir2
				echo "$filterdir2 will be pruned from the search results"
				echo
				sleep 1
				echo "Listing the results of your search criteria:"
				echo
				sleep 1
				find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
				echo
				echo "Finished finding the files you requested, would you like to filter out another directory? (y/n)"
				echo
				sleep 1
				read filterdir
				if [ "$filterdir" = "y" ]; then
					echo
					echo "What directory would you like to filter out? (ex. /root/Desktop)" 
					echo
					sleep 1
					read filterdir3
					echo "$filterdir3 will be pruned from the search results"
					echo
					sleep 1
					echo "Listing the results of your search criteria:"
					echo
					sleep 1
					find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
					echo
					echo "Finished finding the files you requested, would you like to filter out another directory? (y/n)"
					echo
					sleep 1
					read filterdir
					if [ "$filterdir" = "y" ]; then
						echo
						echo "What directory would you like to filter out? (ex. /root/Desktop)" 
						echo
						sleep 1
						read filterdir4
						echo "$filterdir4 will be pruned from the search results"
						echo
						sleep 1
						echo "Listing the results of your search criteria:"
						echo
						sleep 1
						find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
						echo
						echo "Finished finding the files you requested, would you like to filter out another directory? (y/n)"
						echo
						sleep 1
						read filterdir
						if [ "$filterdir" = "y" ]; then
							echo
							echo "What directory would you like to filter out? (ex. /root/Desktop)" 
							echo
							sleep 1
							read filterdir5
							echo "$filterdir5 will be pruned from the search results"
							echo
							sleep 1
							echo "Listing the results of your search criteria:"
							echo
							sleep 1
							find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path $filterdir4 -prune -o -path $filterdir4 -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec ls -lh {} \; \) | awk '{print $NF ":" $5}'
							echo
							echo "Finished finding the files you requested, you have reached the filter limit (5)"
							echo
							sleep 3
							echo "About to move the selected word lists to: $destination"
							find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path $filterdir4 -prune -o -path $filterdir5 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
						else
							echo "About to move the selected word lists to: $destination"
							echo
							sleep 1
							find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path $filterdir4 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
						fi
					else
						echo "About to move the selected word lists to: $destination"
						echo
						sleep 1
						find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path $filterdir3 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
					fi
				else
					echo "About to move the selected word lists to: $destination"
					echo
					sleep 1
					find / \( -type d -path $filterdir1 -prune -o -path $filterdir2 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
				fi
			else
				echo "About to move the selected word lists to: $destination"
				echo
				sleep 1
				find / \( -type d -path $filterdir1 -prune -o -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
			fi
		else
			echo "About to move the selected word lists to: $destination"
			echo
			sleep 1
			find / \( -type d -path /boot/grub -prune -o -path /usr/share/nmap/nselib/data -prune -o -path /usr/share/bluemaho/tools -prune -o -path /usr/share/metasploit-framework/data/wordlists -prune -o -path /usr/share/wordlists/wfuzz -prune -o -path /etc -prune -o -path /usr/share/bluemaho/tools/exploits -prune -o -path /usr/share/perl/*.*.*/unicore -prune -o -path /opt/framework/msf3/data/john/wordlists -prune -o -path /usr/share/wordlists/ -prune -o -path /usr/share/metasploit-framework/data/john/wordlists -prune -o -path /usr/share/wordlists/metasploit-pro -prune -o -path /usr/local/share/nmap/nselib/data -prune -o -path /usr/share/doc/dictionaries-common -prune -o -path /usr/share/X11/xkb/rules -prune -o -path /usr/share/wordlists/fern-wifi -prune -o -path /usr/share/wordlists/dirb/others -prune -o -path $destination -prune -o -name 'charset.lst' -prune -o -name '*.dic' -o -name '*.lst' -size +$listsize -exec mv {} $destination \; \)
		fi

	fi		
}
##Combine GTK##
function f_combineGTK () {
path=$(zenity --file-selection --multiple --directory --title "Directory(s) to combine" --text "What directory would you like to combine into $filename.lst")
filename=$(zenity --entry --title "New Word List Name" --text "What to name the new word list file?\n\n(The file will be saved with the .lst extension)")
destination=$(zenity --file-selection --directory --title "New Word List Destination" --text "Where would you like to place $filename.lst")
zenity --no-wrap --question --title "Create word list" --text "Would you like to create the word list: $filename.lst"
if (( $? == 0 )); then
        zenity --no-wrap --info --timeout=4 --text "Combining the word lists from $path into $filename.lst"
        cat $path/*.* > $filename.lst
else 
	f_menu
fi
if [ "$destination" != "" ]; then
	zenity --no-wrap --info --timeout=4 --text "Moving $filename.lst to $destination"
	mv $filename.lst "$destination"
else
	if [ -e $destination/$filename.lst ]; then
		zenity --no-wrap --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "The word lists from $path been successfully combined into: $filename"
	else
		zenity --no-wrap --error --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "Let's try this again..."
		f_combineGTK
	fi
fi
if [ -e $destination/$filename.lst ]; then
		zenity --no-wrap --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "The word lists from $path been successfully combined into: $filename.lst"
	else
		zenity --no-wrap --error --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "Let's try this again..."
		f_combineGTK
	fi
zenity --no-wrap --info --timeout=4 --text "Returning to main menu ......"
}
##Combine all text files in a directory##
function f_combine () {
f_echobreak
if [ "$GTK" = "y" ]; then
	f_combineGTK
else
echo
echo -en "\nEnter the full path to the directory that contains the text files to merge: (ex. /root/Desktop/): "
read path
echo
while [ ! -d $path ]
do
	echo
	echo "Directory cannot be found or does not exist"
	echo
	sleep 1
	echo -en "\nEnter the full path to the directory that contains the files to merge: (ex. /root/Desktop/):"
	read path
done
echo
echo -en "\nEnter the name of the output file: "
read filename
echo
sleep 1
echo "Where would you like $filename.lst to be placed once combined? (ex. /root/Desktop/)"
echo 
echo
sleep 1
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
			f_combine
		done
	else	
	sleep 1
	echo -en "\nEnter the full path to the directory that contains the files to merge: (ex. /root/Desktop/):"
	read destination
	fi
done
echo
sleep 1
echo -en "\nHit return to create the file: $filename"
read return
if [ "$return" == "" ]; then
echo
cat $path/*.* > $filename.lst
fi
echo
sleep 1
if [ "$destination" != "" ]; then
	echo "Moving $filename.lst to $destination"
	mv $filename.lst "$destination"
else
	echo
	echo
	if [ -e $destination/$filename.lst ]; then
		echo
		echo "$filename.lst exists in the directory: $destination"
		echo
		sleep 1
		echo "The word lists from $path been successfully combined into: $filename"
		echo
		sleep 3
		else
		echo
		echo "$filename.lst does not exist in the directory: $destination"
		echo
		sleep 1
		echo "Let's try this again..."
		sleep 1
		f_combine
	fi
fi
echo "Returning to main menu ......"
sleep 2
echo
fi
}
##combinerGTK##
function f_combinerGTK () {
paths=$(zenity --file-selection --multiple --separator=" " --title "Files to combine" --text "Where would you like to place $filename.lst")
filename=$(zenity --entry --title "New Word List Name" --text "What to name the new word list file?\n\n(The file will be saved with the .lst extension)")
destination=$(zenity --file-selection --directory --title "New Word List Destination" --text "Where would you like to place $filename.lst")
zenity --no-wrap --question --title "Create word list" --text "Would you like to create the word list: $filename.lst"
if (( $? == 0 )); then
        zenity --no-wrap --info --timeout=4 --text "Combining the word lists: $paths into $filename.lst"
        cat $paths > $filename.lst
else 
	f_menu
fi
if [ "$destination" != "" ]; then
	zenity --no-wrap --info --timeout=4 --text "Moving $filename.lst to $destination"
	mv $filename.lst "$destination"
else
	if [ -e $destination/$filename.lst ]; then
		zenity --no-wrap --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "The word lists: $paths been successfully combined into: $filename"
	else
		zenity --no-wrap --error --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "Let's try this again..."
		f_combineGTK
	fi
fi
if [ -e $destination/$filename.lst ]; then
		zenity --no-wrap --info --timeout=4 --text "$filename.lst exists in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "The word lists: $paths been successfully combined into: $filename.lst"
	else
		zenity --no-wrap --error --timeout=4 --text "$filename.lst does not exist in the directory: $destination"
		zenity --no-wrap --info --timeout=4 --text "Let's try this again..."
		f_combineGTK
	fi
zenity --no-wrap --info --timeout=4 --text "Returning to main menu ......"
}
##combiner##
function f_combiner () {
	f_echobreak
	if [ "$GTK" = "y" ]; then
		f_combinerGTK
	else
		echo "The CLI version of this function is in the works."
		sleep 5
	fi
}

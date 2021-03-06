##region functions##
##region 1##
function f_1 () {
echo "What would you like the output file to be named?"
echo "(The file will be saved with the .lst extension)"
echo
sleep 1
read filename
echo
sleep 1
echo -en "\nHit return to create the list: "
read return
if [ "$return" == "" ]; then
echo -e "\nPlease wait while the temp lista are being generated in the folder this script is located"
sleep 1
mkdir sociallist
if [ "$social" = "1" ]; then
	/usr/bin/crunch 9 9 1234567890 -t 001@@@@@@ -o 1.lst
	/usr/bin/crunch 9 9 1234567890 -t 002@@@@@@ -o 2.lst
	/usr/bin/crunch 9 9 1234567890 -t 003@@@@@@ -o 3.lst
elif [ "$social" = "2" ]; then
	/usr/bin/crunch 11 11 1234567890 -t 001-@@-@@@@ -o 1.lst
	/usr/bin/crunch 11 11 1234567890 -t 002-@@-@@@@ -o 2.lst
	/usr/bin/crunch 11 11 1234567890 -t 003-@@-@@@@ -o 3.lst
fi
fi
echo "Combining the temp lists into" $filename.lst
sleep 2
cat *.lst > $filename.lst
echo -e "\nFinished processing $filename"
sleep 2
echo
echo "Moving" $filename.lst "to folder: /regionlist/"
mkdir regionlist
mv $filename.lst regionlist
sleep 2
echo
echo $filename.lst "has been moved to folder: /regionlist/, cleaning up temp lists."
rm *.lst
sleep 2
echo
echo "The temp lists have been cleaned, returning to the region selection menu."
echo
sleep 2
}
##social by region##
function f_region () {
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo -e "\n\t1. 012345678"
echo -e "\n\t2. 012-34-5678"
echo -en "\n\tSelect an social security number format to use: "
read social
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo "Would you like to remove all current lists in the script directory?"
echo
sleep 1
echo "(Any word lists in the current directory will be deleted due to this script.)"
echo
sleep 1
echo "To delete the lists enter d | To backup them to a temporary directory enter m."
echo
sleep 1
echo "Or you can press enter to skip this step."
echo
sleep 1
echo "(m/d)"
sleep 2
read backup
if [ "$backup" = "d" ]; then
	echo "Deleting existings lists in the script directory."
	rm *.lst
	echo
	sleep 1
	echo "The script directory has been cleared of existing lists."
	echo
	sleep 1		
elif [ "$backup" = "m" ]; then
	echo
	echo "Making directory: Backup"
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
while :

do

cat << !

----------------|Select a region to generate SSNs for|-------------------
|                                                                       |
|                                                                       |
| 1. NH      					                        |
|                                                                       |
| 2. ME      					                        |
|                                                                       |
| 3. VT      					                        |
|                                                                       |
| 4. MA      					                        |
|                                                                       |
| 5. RI      					                        |
|                                                                       |
| 6. CT      					                        |
|                                                                       |
| 7. NY      					                        |
|                                                                       |
| 8. NJ      					                        |
|                                                                       |
| 9. PA      					                        |
|                                                                       |
| 10. MD      					                        |
|                                                                       |
| 11. DE      					                        |
|                                                                       |
| 12. VA      					                        |
|                                                                       |
| 13. WV      					                        |
|                                                                       |
| 14. NC      					                        |
|                                                                       |
| 15. SC      					                        |
|                                                                       |
| 16. GA      					                        |
|                                                                       |
| 17. FL      					                        |
|                                                                       |
| 18. OH      					                        |
|                                                                       |
| 19. IN      					                        |
|                                                                       |
| 20. IL      					                        |
|                                                                       |
| 21. MI      					                        |
|                                                                       |
| 22. WI      					                        |
|                                                                       |
| 23. KY      					                        |
|                                                                       |
| 24. TN      					                        |
|                                                                       |
| 25. AL      					                        |
|                                                                       |
| 26. MS      					                        |
|                                                                       |
| 27. AR      					                        |
|                                                                       |
| 28. HI      					                        |
|                                                                       |
| 29. LA      					                        |
|                                                                       |
| 30. OK      					                        |
|                                                                       |
| 31. TX      					                        |
|                                                                       |
| 32. MN      					                        |
|                                                                       |
| 33. IA      					                        |
|                                                                       |
| 34. MO      					                        |
|                                                                       |
| 35. ND      					                        |
|                                                                       |
| 36. SD      					                        |
|                                                                       |
| 37. NE      					                        |
|                                                                       |
| 38. KS      					                        |
|                                                                       |
| 39. MT      					                        |
|                                                                       |
| 40. ID      					                        |
|                                                                       |
| 41. WY      					                        |
|                                                                       |
| 42. CO      					                        |
|                                                                       |
| 43. NM      					                        |
|                                                                       |
| 44. AZ      					                        |
|                                                                       |
| 45. UT      					                        |
|                                                                       |
| 46. NV      					                        |
|                                                                       |
| 47. WA      					                        |
|                                                                       |
| 48. OR      					                        |
|                                                                       |
| 49. CA      					                        |
|                                                                       |
| 50. AK      					                        |
|                                                                       |
| 51. WASHINGTON DC      			                        |
|                                                                       |
| 52. VIRGIN ISLANDS      			                        |
|                                                                       |
| 53. PUERTO RICO	      			                        |
|                                                                       |
| 54. PACIFIC ISLANDS      			                        |
|                                                                       |
| 55. OTHER      				                        |
|                                                                       |
| 56. MAIN MENU                                                         |
-------------------------------------------------------------------------
!
echo
echo
echo -n " Select a region from the menu: "

read choice

case $choice in

1) f_1 ;;

2) f_2 ;;

3) f_social ;;

4) f_region ;;

5) f_belkin ;;

56) f_menu ;;

*) echo "\"$choice\" is not valid "; sleep 2 ;;

esac

done
}#!/bin/sh


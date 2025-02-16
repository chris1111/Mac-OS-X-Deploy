#!/bin/sh
# script Mac OS X Deploy.
# Copyright (c) 2016, 2025 chris1111
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

nameh=`users`
function echob() {
  echo "`tput bold`$1`tput sgr0`"
}

function head
{
clear
echo "          ***************************************************************"                      
       echo "                               `tput setaf 7``tput sgr0``tput bold``tput setaf 26` \033[5mMac OS X Deploy`tput sgr0` `tput sgr0` `tput setaf 7``tput sgr0``tput sgr0` `tput sgr0` `tput setaf 7``tput sgr0` "  
echo "          ***************************************************************"
}

function menu
{
echo "                                Welcome  "$nameh"
                                   


                            Mac OS X Deploy Options"
echo "  
                                        ⇓"                         
  

echo "          *************************************************************** 
                           1)   Restore DVD --> DMG
                               *********************
                                                                        
                           2)   Buid DMG Deploy
                               *********************
                               
                           3)   Install Xcode and MacPorts 
                               before Deployement option 4
                               *********************
                               
                           4)   Build DMG Deploy + Update
                               *********************

                           5)   Deploy --> SSD/HD
                               *********************
                               
                           X)   Quit Program
                               *********************                         
          ***************************************************************"                      
                     

read -n 1 option
}
function INSTALLER_DVD
{
head
echo " "
drutil tray open
drutil eject

echo "      ********** IMPORTANT **********"
echo "
Place your Mac OS X Snow Leopard DVD in the tray
and wait until it is clearly visible on the desktop.
A 45 second delay is now applied!"
echo "
***************************************************************" 

Sleep 45
echo " "
echo " "
echo "Mac OS X Restore DVD: "
echo "To use Option #1, you must have the Mac OS X Snow Leopard DVD.
If you have Mac OS X Install DVD.dmg disk image in the Output folder,
it will be deleted automatically."
echo "This program must be run as root Admin:
If your DVD is mounted correctly, type your password followed by Enter!"
echo " "
sudo Scripts/Resources/Scripts/INSTALLER_DVD.sh  
echo " "
echo "Restore DVD --> DMG Completed."
echo " "
echob "Finished."
echo " "
}
function INSTALLERDMG
{
head
echo " "
echo "    ********** IMPORTANT **********"
echo "Mac OS X Deploy DMG: "
echo " 
To use Option # 2 you must have completed
Option # 1 and have in the Output folder Mac OS X Install DVD.dmg
If this is not the case, quit the program and start again option # 1.
If you have Mac OS X Deploy 10.6.X.dmg disk image in the Output folder,
it will be deleted automatically."
echo "This program must be done in root Admin:
Type your password followed by Enter!"
sudo Scripts/Resources/Scripts/INSTALLERDMG.sh
echo " "
echo "Mac OS X Deploy Completed."
echo " "
echob "Finished."
}
function INSTALLER_DMG
{
head
echo " "
echo "    ********** IMPORTANT **********"
echo "Mac OS X Deploy DMG: "
echo "
To use Option # 3 you must have completed
Option # 1 and have in the Output folder Mac OS X Install DVD.dmg
If this is not the case, quit the program and start again option # 1.
If you have Mac OS X Deploy 10.6.X.dmg disk image in the Output folder,
it will be deleted automatically."
echo "This program must be done in root Admin:
Type your password followed by Enter!"
sudo Scripts/Resources/Scripts/INSTALLER_DMG.sh
echo " "
echo "Mac OS X Deploy Completed."
echo " "
echob "Finished."
}
function INSTALLER_DMGG
{
head
echo " "
echo "    ********** IMPORTANT **********"
echo "Mac OS X Deploy DMG: "
echo "
To use Option # 4 you must have completed
Option # 3 and rebooted macOS then have in the Output folder Mac OS X Install DVD.dmg
If this is not the case, quit the program and start again option # 1.
If you have Mac OS X Deploy 10.6.X.dmg disk image in the Output folder,
it will be deleted automatically."
echo "This program must be done in root Admin:
Type your password followed by Enter!"
sudo Scripts/Resources/Scripts/INSTALLER_DMG-1.sh
echo " "
echo "Mac OS X Deploy Completed."
echo " "
echob "Finished."
}
function INSTALLER_VOLUME
{
head

echo " "
echo "    ********** IMPORTANT **********"
echo "Mac OS X Deploy: "
echo "
To use Option # 4 you must have completed
Option # 1 and 2 or 1 and 3 and have in the Output folder
Mac OS X Deploy 10.6.X.dmg"
echo " "
sudo Scripts/Resources/Scripts/RESTORE_DMG.sh  
echo " "
echo "Follow the steps in Deploy Mac OS X.app
Make sure your internal or external SSD is ready for use!."
echo " "
echob "Finished."
}
function Quit
{
clear
echo " " 
echo "
`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Quit Mac OS X Deploy`tput sgr0` `tput setaf 7``tput sgr0`"
echo " " 
echob "Thanks Bye. $hours `tput setaf 7``tput sgr0``tput bold``tput setaf 10`$nameh`tput sgr0` `tput setaf 7``tput sgr0`"
echo " " 
exit 0
}
while [ 1 ]
do
head
menu
case $option in


1|1)
echo
INSTALLER_DVD ;;
2|2)
INSTALLERDMG ;;
3|3)
INSTALLER_DMG ;;
4|4)
echo
INSTALLER_DMGG ;;
5|5)
INSTALLER_VOLUME ;;
x|X)
echo
Quit ;;


*)
echo ""
esac
echo
echob "`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Type any key to return in the menu:`tput sgr0` `tput setaf 7``tput sgr0`"
echo
read -n 1 line
clear
done

exit




	

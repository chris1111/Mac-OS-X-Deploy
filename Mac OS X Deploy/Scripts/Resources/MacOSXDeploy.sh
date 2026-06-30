#!/bin/sh
# script Mac OS X Deploy.
# Copyright (c) 2016, 2026 chris1111
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

                           6)   Use Chameleon Bootloader
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
echo " "

echo "This program must be run as root Admin:
Type your password followed by Enter!"
sudo whoami

# Check Mounted Disk
if [[ -d "/Volumes/install_dmg" ]]; then
 hdiutil detach -Force "/Volumes/install_dmg"
fi

if [ -f ./Out/"Mac OS X Install DVD.dmg" ]; then
   rm -rf ./Out/"Mac OS X Install DVD.dmg" 
fi
 
echo "Build Sparse image!"
echo " "
hdiutil create -size 7.9g -type SPARSE -fs HFS+J -volname "install_dmg" -uid 0 -gid 80 -mode 1775 /Private/tmp/"Mac OS X Install DVD"

hdiutil attach /tmp/"Mac OS X Install DVD.sparseimage" -noverify -nobrowse 
echo "********************************************** " 
echo "  "
echo "Restore DVD --> DMG !"
echo " "

Sleep 2 
sudo asr restore -source /Volumes/"Mac OS X Install DVD" -target /Volumes/install_dmg -noprompt -noverify -erase
echo "********************************************** " 
echo "  "
Sleep 2
hdiutil detach -Force /Volumes/"Mac OS X Install DVD"

hdiutil detach -Force /Volumes/"Mac OS X Install DVD 1"


drutil eject

killall -KILL Finder

echo " "
echo "Convert DMG in folder Out!"
echo " "
echo "********************************************** " 
echo "  "
Sleep 2
hdiutil convert -format UDZO /Private/tmp/"Mac OS X Install DVD.sparseimage" -o ./Out/"Mac OS X Install DVD"

echo " "
echo "Supression /tmp sparse image !"
echo " "

rm -R /Private/tmp/"Mac OS X Install DVD.sparseimage"

open ./Out
echo "********************************************** " 
echo "  "
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

echo "This program must be run as root Admin:
Type your password followed by Enter!"
sudo whoami

# Check Mounted Disk
if [[ -d "/Volumes/Mac OS X Deploy" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Deploy"
fi

if [[ -d "/Volumes/Mac OS X Install DVD" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Install DVD"
fi

if [ -f ./Out/"Mac OS X Deploy 10.6.X.dmg" ]; then
   rm -rf ./Out/"Mac OS X Deploy 10.6.X.dmg" 
fi

hdiutil attach -noverify -nobrowse ./Out/"Mac OS X Install DVD.dmg"
echo " "
echo "Construire Sparse image!"
echo " "
hdiutil create -size 32g -type SPARSE -fs HFS+J -volname "Mac OS X Deploy" -uid 0 -gid 80 -mode 1775 /Private/tmp/"Mac OS X Deploy"
Sleep 1
hdiutil attach -noverify -nobrowse /Private/tmp/"Mac OS X Deploy.sparseimage"

mkdir /Volumes/"Mac OS X Deploy"/Library

mkdir /Volumes/"Mac OS X Deploy"/Library/Caches

echo " "
echo "Installation Mac OS X Install DVD !"
echo " "
sudo installer -verboseR -pkg /Volumes/"Mac OS X Install DVD"/System/Installation/Packages/OSInstall.mpkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
hdiutil detach -Force /Volumes/"Mac OS X Deploy"
Sleep 1
hdiutil resize -size 9G /tmp/"Mac OS X Deploy.sparseimage"

Sleep 2
echo " "
echo "Convert Sparse image in DMG !"
echo " "
hdiutil convert -puppetstrings -format UDZO /Private/tmp/"Mac OS X Deploy.sparseimage" -o ./Out/"Mac OS X Deploy 10.6.X"

hdiutil detach -Force /Volumes/"Mac OS X Install DVD"
open ./Out
echo " "
echo "Remove temp DMG !"
echo " "
rm -R /Private/tmp/"Mac OS X Deploy.sparseimage"
echo " "
echo "********************************************** " 
echo "  "
echo "********************************************** "  
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
Sleep 3
# Check Mounted Disk
if [[ -d "/Volumes/Mac OS X Deploy" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Deploy"
fi

if [[ -d "/Volumes/Mac OS X Install DVD" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Install DVD"
fi

if [ -f ./Out/"Mac OS X Deploy 10.6.X.dmg" ]; then
   rm -rf ./Out/"Mac OS X Deploy 10.6.X.dmg" 
fi

echo "This program must be run as root Admin:
Type your password followed by Enter!"
sudo whoami

echo " "
echo "********************************************** " 
echo "  "

XCODE="/Developer/Applications/Xcode.app"
if [ -e "$XCODE" ]; then
    echo "$XCODE exist"
else 
    echo "$XCODE is not installed on your System!"
    echo "Installation Xcode.mpkg!"
    hdiutil attach -noverify -nobrowse ./Out/"Mac OS X Install DVD.dmg"
    Sleep 2
    sudo installer -verboseR -pkg /Volumes/"Mac OS X Install DVD"/"Optional Installs.localized"/Xcode.mpkg -target /
    Sleep 2
    hdiutil detach -Force /Volumes/"Mac OS X Install DVD"

fi 

Sleep 2

CLI="/opt/local/etc/macports"
if [ -e "$CLI" ]; then
    echo "$CLI exist"
else 
    echo "$CLI is not installed on your System!"
    echo "Installation MacPorts-2.10.5-10.6-SnowLeopard.pkg !"
    sudo installer -verboseR -pkg ./MacPorts/MacPorts-2.10.5-10.6-SnowLeopard.pkg -target /
    echo " " 

fi 

CURL="/opt/local/bin/curl"
if [ -e "$CURL" ]; then
    echo "$CURL exist"
    echo "You can use Options 4 to create 10.6.8 Image!"
else 
    echo "$CURL is not installed on your System!"
    echo "Installation CURL!"
    sudo /opt/local/bin/port -N selfupdate
    Sleep 1
    sudo /opt/local/bin/port -N install curl
    Sleep 1
    echo 'export PATH=/opt/local/bin:/opt/local/sbin:$PATH' >> ~/.bash_profile
    source ~/.bash_profile
    echo " " 
    osascript -e 'tell app "terminal" to display dialog "Xcode and MacPorts are installed.
You absolutely must restart your Mac
After restart you can using option 4." buttons {"Reboot"} default button 1 with title "Installation Completed" giving up after 15'
    echo "System Reboot!"
    Sleep 2
    osascript -e 'tell app "System Events" to restart'
    killall Terminal
fi

echo "All Done for the required component!" 
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
# Check Mounted Disk
if [[ -d "/Volumes/Mac OS X Deploy" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Deploy"
fi

if [[ -d "/Volumes/Mac OS X Install DVD" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Install DVD"
fi

if [ -f ./Out/"Mac OS X Deploy 10.6.X.dmg" ]; then
   rm -rf ./Out/"Mac OS X Deploy 10.6.X.dmg" 
fi

echo "This program must be run as root Admin:
Type your password followed by Enter!"
sudo whoami

echo " "
echo "********************************************** " 
echo "  "

XCODE="/Developer/Applications/Xcode.app"
if [ -e "$XCODE" ]; then
    echo "$XCODE exist"
else 
    echo "$XCODE is not installed on your System!"
    echo "Installation Xcode.mpkg!"
    hdiutil attach -noverify -nobrowse ./Out/"Mac OS X Install DVD.dmg"
    Sleep 2
    sudo installer -verboseR -pkg /Volumes/"Mac OS X Install DVD"/"Optional Installs.localized"/Xcode.mpkg -target /
    Sleep 2
    hdiutil detach -Force /Volumes/"Mac OS X Install DVD"

fi 

Sleep 2

CLI="/opt/local/etc/macports"
if [ -e "$CLI" ]; then
    echo "$CLI exist"
else 
    echo "$CLI is not installed on your System!"
    echo "Installation MacPorts-2.10.5-10.6-SnowLeopard.pkg !"
    sudo installer -verboseR -pkg ./MacPorts/MacPorts-2.10.5-10.6-SnowLeopard.pkg -target /
    echo " " 

fi 

CURL="/opt/local/bin/curl"
if [ -e "$CURL" ]; then
    echo "$CURL exist"
else 
    echo "$CURL is not installed on your System!"
    echo "Installation CURL!"
    sudo /opt/local/bin/port -N selfupdate
    Sleep 1
    sudo /opt/local/bin/port -N install curl
    Sleep 1
    echo 'export PATH=/opt/local/bin:/opt/local/sbin:$PATH' >> ~/.bash_profile
    source ~/.bash_profile
fi

Sleep 2 
echo "********************************************** "

echo "Build Sparse image!"
hdiutil attach -noverify -nobrowse ./Out/"Mac OS X Install DVD.dmg"

echo " "
hdiutil create -size 32g -type SPARSE -fs HFS+J -volname "Mac OS X Deploy" -uid 0 -gid 80 -mode 1775 /Private/tmp/"Mac OS X Deploy"
Sleep 1
hdiutil attach -noverify -nobrowse /Private/tmp/"Mac OS X Deploy.sparseimage"

mkdir /Volumes/"Mac OS X Deploy"/Library

mkdir /Volumes/"Mac OS X Deploy"/Library/Caches

echo " "
echo "Installation Mac OS X Install DVD !"
echo " "
sudo installer -verboseR -pkg /Volumes/"Mac OS X Install DVD"/System/Installation/Packages/OSInstall.mpkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download Combo Update 10.6.8 !"
echo " "
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/MacOSXUpdCombo10.6.8.dmg -o /Private/tmp/MacOSXUpdCombo10.6.8.dmg
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/"MacOSXUpdCombo10.6.8.dmg"

hdiutil detach -Force /Volumes/"Mac OS X Install DVD"
echo " "
echo "Installation Combo Update 10.6.8 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Mac OS X 10.6.8 Update Combo"/MacOSXUpdCombo10.6.8.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download iTunes 11.4 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/iTunes11.4.dmg -o /Private/tmp/iTunes11.4.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/iTunes11.4.dmg
echo " "
echo "Installation iTunes 11.4 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/iTunes/"Install iTunes.pkg" -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download Java For Mac OS X 10.6 Update 17  v 17.1 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/JavaForMacOSX10.6update17.dmg -o /Private/tmp/JavaForMacOSX10.6update17.dmg   
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/JavaForMacOSX10.6update17.dmg
echo " "
echo "Installation Java For Mac OS X 10.6 Update 17  v 17.1 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Java For Mac OS X 10.6 Update 17"/JavaForMacOSX10.6.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download Apple Software install Update V 1.0 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/AppleSoftwareInstallerUpdate.dmg -o /Private/tmp/AppleSoftwareInstallerUpdate.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/AppleSoftwareInstallerUpdate.dmg
echo " "
echo "Installation Apple Software install Update V 1.0 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Apple Software Installer Update"/AppleSoftwareInstallerUpdate.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download Safari v 5.1.10 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/Safari5.1.10SnowLeopardManual.dmg -o /Private/tmp/Safari5.1.10SnowLeopardManual.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/Safari5.1.10SnowLeopardManual.dmg
echo " "
echo "Installation Safari v 5.1.10 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Safari 5.1.10 for Snow Leopard"/Safari5.1.10SnowLeopardManual.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download Security Update 2013-004 V 1.0 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/SecUpd2013-004.dmg -o /Private/tmp/SecUpd2013-004.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/SecUpd2013-004.dmg
echo " "
echo "Installation Security Update 2013-004 V 1.0 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Security Update 2013-004"/SecUpd2013-004.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download Migration Assistant Update for Snow V 1.1 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/SnowLeoMigrationAsst.dmg -o /Private/tmp/SnowLeoMigrationAsst.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/SnowLeoMigrationAsst.dmg
echo " "
echo "Installation Migration Assistant Update for Snow V 1.1 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Snow Leopard Migration Assistant"/SnowLeoMigrationAssistant.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  "
echo "Download Remote Desktop Client Update v 3.5.4 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/ARDClient3.5.4.dmg -o /Private/tmp/ARDClient3.5.4.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/ARDClient3.5.4.dmg
echo " "
echo "Installation Remote Desktop Client Update v 3.5.4 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Apple Remote Desktop 3.5.4 Client Update"/RemoteDesktopClient.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2 
echo "********************************************** " 
echo "  " 
echo "Download Mac App Store Update for OS X Snow Leopard  v1.0 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/macappstoreupdate.dmg -o /Private/tmp/macappstoreupdate.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/macappstoreupdate.dmg
echo " "
echo "Installation Mac App Store Update for OS X Snow Leopard  v1.0 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/"Mac App Store Update"/MacAppStoreUpdate.pkg -target /Volumes/"Mac OS X Deploy"
Sleep 2  
echo "********************************************** " 
echo "  "
echo "AirPort Utility v 5.6.1 !"
curl -L https://github.com/chris1111/Mac-OS-X-Deploy/releases/download/Update/AirPortUtility.dmg -o /Private/tmp/AirPortUtility.dmg
Sleep 2 
echo " "
hdiutil attach -noverify -nobrowse /Private/tmp/AirPortUtility.dmg
echo " "
echo "Installation AirPort Utility  v 5.6.1 !"
echo " "
sudo installer -verboseR -allow -pkg /Volumes/AirPortUtility/AirPortUtility.pkg -target /Volumes/"Mac OS X Deploy" 
Sleep 2  
echo "********************************************** " 
echo "  "
hdiutil detach -Force /Volumes/"Mac OS X 10.6.8 Update Combo"
Sleep 1
hdiutil detach -Force /Volumes/iTunes
Sleep 1
hdiutil detach -Force /Volumes/"Java For Mac OS X 10.6 Update 17"
Sleep 1
hdiutil detach -Force /Volumes/"Apple Software Installer Update"
Sleep 1
hdiutil detach -Force /Volumes/"Safari 5.1.10 for Snow Leopard"
Sleep 1
hdiutil detach -Force /Volumes/"Security Update 2013-004"
Sleep 1
hdiutil detach -Force /Volumes/"Snow Leopard Migration Assistant"
Sleep 1
hdiutil detach -Force /Volumes/"Apple Remote Desktop 3.5.4 Client Update"
Sleep 1
hdiutil detach -Force /Volumes/AirPortUtility
Sleep 1
hdiutil detach -Force /Volumes/"Mac App Store Update"
Sleep 1
hdiutil detach -Force /Volumes/"Mac OS X Deploy"
Sleep 1
hdiutil resize -size 9G /Private/tmp/"Mac OS X Deploy.sparseimage"


Sleep 2
echo " "
echo "Convert Sparse image in DMG !"
echo " "
hdiutil convert -puppetstrings -format UDZO /Private/tmp/"Mac OS X Deploy.sparseimage" -o ./Out/"Mac OS X Deploy 10.6.X"

open ./Out
echo "Remove temp DMG !"
echo " "

rm -R /Private/tmp/"Mac OS X Deploy.sparseimage"

rm -R /Private/tmp/MacOSXUpdCombo10.6.8.dmg
rm -R /Private/tmp/iTunes11.4.dmg
rm -R /Private/tmp/JavaForMacOSX10.6update17.dmg
rm -R /Private/tmp/AppleSoftwareInstallerUpdate.dmg
rm -R /Private/tmp/Safari5.1.10SnowLeopardManual.dmg
rm -R /Private/tmp/SecUpd2013-004.dmg
rm -R /Private/tmp/SnowLeoMigrationAsst.dmg
rm -R /Private/tmp/ARDClient3.5.4.dmg
rm -R /Private/tmp/AirPortUtility.dmg
rm -R /Private/tmp/macappstoreupdate.dmg
echo " "
echo "********************************************** " 
echo "  "
echo "********************************************** " 
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
# Check Mounted Disk
if [[ -d "/Volumes/Mac OS X Deploy" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Deploy"
fi

if [[ -d "/Volumes/Mac OS X Install DVD" ]]; then
 hdiutil detach -Force "/Volumes/Mac OS X Install DVD"
fi

echo "This program must be run as root Admin:
Type your password followed by Enter!"
sudo whoami

hdiutil attach -noverify -nobrowse -mountpoint /Private/tmp/Installer-OS ./Out/"Mac OS X Deploy 10.6.X.dmg"

Sleep 2
echo " "
echo "Open Deploy Mac OS X.app !"
echo " "
Sleep 3
open ./app/Deploy/"Deploy Mac OS X.app"
 
echo " "
echo "Follow the steps in Deploy Mac OS X.app
Make sure your internal or external SSD is ready for use!."
echo " "
echob "Finished."
}
function CHAMELEON
{
head
Open ./App/Deploy/Deploy\ Mac\ OS\ X.app/Contents/Resources/Installer/Chameleon-Snow.pkg
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
6|6)
echo
CHAMELEON ;;
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

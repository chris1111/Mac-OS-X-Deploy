#!/bin/bash
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
echo " "
Sleep 3
unmount_if_necessary() {
    [ -d "$1" ] && umount -f "$1"
}

unmount_if_necessary /Volumes/"Mac OS X Deploy"


unmount_if_necessary() {
    [ -d "$1" ] && umount -f "$1"
}

unmount_if_necessary /Volumes/"Mac OS X Install DVD"

if [ -f ./Out/"Mac OS X Deploy 10.6.X.dmg" ]; then
   rm -rf ./Out/"Mac OS X Deploy 10.6.X.dmg" 
fi


echo " "
echo "********************************************** " 
echo "  "

XCODE=/Developer/Applications/Xcode.app
if [ -e "$XCODE" ]; then
    echo "$XCODE exist"
else 
    echo "$XCODE is not installed on your System!"
    echo "Installation Xcode.mpkg!"
    hdiutil attach -noverify -nobrowse ./Sortie/"Mac OS X Install DVD.dmg"
    Sleep 2
    sudo installer -verboseR -pkg /Volumes/"Mac OS X Install DVD"/"Optional Installs.localized"/Xcode.mpkg -target /
    Sleep 2
    hdiutil detach -Force /Volumes/"Mac OS X Install DVD"

fi 

Sleep 2

CLI=/opt/local/etc/macports
if [ -e "$CLI" ]; then
    echo "$CLI exist"
else 
    echo "$CLI is not installed on your System!"
    echo "Installation MacPorts-2.10.5-10.6-SnowLeopard.pkg !"
    sudo installer -verboseR -pkg ./MacPorts/MacPorts-2.10.5-10.6-SnowLeopard.pkg -target /
    echo " " 

fi 

PHP56=/opt/local/include/curl
if [ -e "$PHP56" ]; then
    echo "$PHP56 exist"
else 
    echo "$PHP56 is not installed on your System!"
    echo "Installation php56-curl!"
    ./Scripts/Resources/Scripts/PHP56.command
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
curl -L https://www.dropbox.com/s/wm0qmsy9qkylxlr/MacOSXUpdCombo10.6.8.dmg?dl=0 -o /Private/tmp/MacOSXUpdCombo10.6.8.dmg
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
curl -L https://www.dropbox.com/s/q6dieisrpyb6gju/iTunes11.4.dmg?dl=0 -o /Private/tmp/iTunes11.4.dmg
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
curl -L https://www.dropbox.com/s/43zztbb6nbdwhwh/JavaForMacOSX10.6update17.dmg?dl=0 -o /Private/tmp/JavaForMacOSX10.6update17.dmg   
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
curl -L https://www.dropbox.com/s/f02u0zblfrzvfb1/AppleSoftwareInstallerUpdate.dmg?dl=0 -o /Private/tmp/AppleSoftwareInstallerUpdate.dmg
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
curl -L https://www.dropbox.com/s/msfk36e8blf73xe/Safari5.1.10SnowLeopardManual.dmg?dl=0 -o /Private/tmp/Safari5.1.10SnowLeopardManual.dmg
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
curl -L https://www.dropbox.com/s/0l88ytqijti3c9k/SecUpd2013-004.dmg?dl=0 -o /Private/tmp/SecUpd2013-004.dmg
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
curl -L https://www.dropbox.com/s/p73q3k6t7e7annk/SnowLeoMigrationAsst.dmg?dl=0 -o /Private/tmp/SnowLeoMigrationAsst.dmg
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
curl -L https://www.dropbox.com/s/cbm33owlfqbnah0/ARDClient3.5.4.dmg?dl=0 -o /Private/tmp/ARDClient3.5.4.dmg
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
curl -L https://www.dropbox.com/s/o1c30y73ma25tq1/macappstoreupdate.dmg?dl=0 -o /Private/tmp/macappstoreupdate.dmg
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
curl -L https://www.dropbox.com/s/nwawc52qi0apgpm/AirPortUtility.dmg?dl=0 -o /Private/tmp/AirPortUtility.dmg
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


exit 0 


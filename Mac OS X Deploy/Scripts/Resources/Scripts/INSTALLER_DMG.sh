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
    hdiutil attach -noverify -nobrowse ./Out/"Mac OS X Install DVD.dmg"
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
    echo "Reinstallation MacPorts-2.10.5-10.6-SnowLeopard.pkg !"
    sudo installer -verboseR -pkg ./MacPorts/MacPorts-2.10.5-10.6-SnowLeopard.pkg -target /
    echo " " 
    cp -Rp ./Scripts/Resources/Scripts/profile ~/.profile
    Sleep 3
    osascript -e 'tell app "terminal" to display dialog "Xcode and MacPorts are installed.
You absolutely must restart your Mac and redo option 4" buttons {"Reboot"} default button 1 with title "Installation Completed"'
    echo "System Reboot!"
    Sleep 2
    osascript -e 'tell app "loginwindow" to «event aevtrrst»'
    Sleep 2
    killall Terminal

fi


exit 0 


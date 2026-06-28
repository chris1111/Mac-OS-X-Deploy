#!/bin/bash
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
echo " "
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

exit 0 


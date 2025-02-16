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


exit 0 



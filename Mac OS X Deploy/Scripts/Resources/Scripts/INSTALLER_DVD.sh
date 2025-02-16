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


unmount_if_necessary() {
    [ -d "$1" ] && umount -f "$1"
}

unmount_if_necessary /Volumes/install_dmg



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
exit 0 


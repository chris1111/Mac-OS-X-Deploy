display dialog "Welcome Mac OS X Deploy

This program will deploy 
Mac OS X Snow Leopard
to the volume of your choice.

For Hackintosh User You will also have the option to be able to install 
OpenCore 1.0.2 Duet Legacy
Note: OpenCore is bootable from 10.6 to macOS Sequoia 15
" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
--If Cntinue
if result = {button returned:"Continue"} then
	
	display dialog "
Format your disk with Disk Utility
Mac OS Extended Journaled (GUID) Partition
*** Warning ***
You will need to quit Disk Utility
to continue the installation! " with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
	
	
	tell application "/Applications/Utilities/Disk Utility.app"
		activate
	end tell
	
	repeat
		if application "Disk Utility" is not running then exit repeat
		
	end repeat
	activate me
	set all to paragraphs of (do shell script "ls /Volumes")
	set w to choose from list all with prompt " 
to continue, select the volume you just formatted.

Then press the OK button" OK button name "OK" with multiple selections allowed
	if w is false then
		display dialog "Quit Installer " with icon note buttons {"EXIT"} default button {"EXIT"}
		
		return
	end if
	try
		repeat with teil in w
			do shell script "diskutil `diskutil list | awk '/ " & teil & "  / {print $NF}'`"
		end repeat
	end try
	
	set theName to "Install-Snow"
	tell application "Finder"
		set name of disk w to theName
		
	end tell
	
	--If Continue	
	display dialog "
Restore Mac OS
Continue Restore on Volume Install-Snow!" with icon note buttons {"Quit", "Continue Restore"} cancel button "Quit" default button {"Continue Restore"}
	
	--If user Continue Restore
	if result = {button returned:"Continue Restore"} then
		--display dialog cmd	
		set cmd to "sudo asr restore -source " & quoted form of "/tmp/Installer-OS" & " -target " & quoted form of "/Volumes/Install-Snow" & " -erase -noprompt -noverify"
		do shell script cmd with administrator privileges
		delay 2
	end if
	tell application "Finder"
		if exists "Mac OS X Deploy" then
			do shell script "hdiutil detach \"/Volumes/Mac OS X Deploy\""
		end if
	end tell
	activate me
	set Box to text returned of (display dialog " 
 - - - - - - - - - - - - - - - - - - - - 
	
⬇ ︎Choose: 
The name you want for the Deployment volume.
NOTE: (Mac OS X Deploy) should not be used!
Type the name in the dialog box
and press the (OK) button                 
- - - - - - - - - - - - - - - - - - - - " with icon note default answer "MY DISK" buttons {"OK"} default button {"OK"} giving up after 60)
	tell application "Finder"
		set name of disk "Mac OS X Deploy" to Box
		
	end tell
	
	delay 2
	display dialog "
Complete successfully!" with icon note buttons {"Done"} default button {"Done"} giving up after 20
	
	set theAction to button returned of (display dialog "
Use Bootloader OpenCore Duet 1.0.2" with icon note buttons {"Quit", "OpenCore"} cancel button {"Quit"} default button {"OpenCore"} giving up after 30)
	
	if theAction = "OpenCore" then set theFile to ((path to me) as string) & "Contents:Resources:Installer:Legacy-OpenCore-Package.pkg"
	tell application "Finder" to open theFile
	
end if


return Box

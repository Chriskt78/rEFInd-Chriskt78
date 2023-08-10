# rEFInd-Chriskt78
Packaged & customized by Christ78

Windows-RetrogamingOS multiboot installation package (rEFInd)

Check whether your Windows is in UEFI or BIOS mode:
- Win+R keys
- Type ``msinfo32``, press Enter
- on the right-hand side of the System Information screen, look for the BIOS mode
- if its value is UEFI, go to the Configure UEFI section
- if its value is BIOS, you need to convert your Windows disk from MBR to GPT

How to convert your disk from MBR to GPT :
- Locate the disk number :
	- Right-click on the Windows button
	- Select Disk Manager
	- Find your hard disk containing Windows (C:) and note the disk number (later noted as ``<disknumber>``, to be replaced by the value noted here).
- Convert MBR disk to GPT :
	- Click on the Windows button
	- Type ``cmd`` then Enter
	- Right-click, run as administrator
	- type ``mbr2gpt /validate /disk:<disknumber> /allowFullOS`` then Enter
	- if no error occurs, type ``mbr2gpt /convert /disk:<disknumber> /allowFullOS`` then Enter

Configure UEFI : 
- Make sure BIOS mode is set to UEFI
- Disable Secure Boot
- Disable Compatibility Support Module (CSM)

Install rEFInd :
- Unzip, go to unzipped folder
- To install, right-click on install.bat, run as administrator
- Check that you have no error messages, and that file copies do not give 0 copied files
- Reboot and check that rEFIind starts and runs on your retrogaming distribution, Windows or any other system. You can use the left/right/enter arrows, mouse and touchscreen to make your choice (but not the touchpad).

To uninstall rEFInd :
- Unzip, go to the unzipped folder.
- Right-click on uninstall.bat and run as administrator.
- Check for error messages
- Check that you are booting directly into Windows. 

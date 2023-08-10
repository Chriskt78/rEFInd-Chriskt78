@echo off

rem Check Windows Version
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if not "%VERSION%" == "10.0" (
  echo Win10 or Win11 mandatory. Exiting.
  goto :EndScript
)

rem Check 64bit OS
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if not %OS%==64BIT (
  echo Need to be 64bit Operating system
  goto :EndScript
)

rem Check admin rights
net session >nul 2>&1
if not %errorLevel% == 0 (
  echo Need to be executed in a command prompt as administrator. Exiting.
  goto :EndScript
)

rem Getting first drive letter unused
for %%a in (z y x w v u t s r q p o n m l k j i h g f e d c) do if not exist %%a:\ set drv=%%a:

rem Mounting EFI partition
echo - Mounting EFI partition
mountvol %drv% /s

rem Read Previous Refind UEFI GUID
if exist "%drv%\EFI\refind\GUID.txt" set /p RefindGUID=<%drv%\EFI\refind\GUID.txt

rem Setting Windows Boot Manager as default boot manager
echo - Setting Windows Boot Manager as default boot manager
bcdedit.exe /set "{fwbootmgr}" displayorder {bootmgr} /remove
bcdedit.exe /set "{fwbootmgr}" displayorder {bootmgr} /addfirst

rem Removing rEFInd UEFI entry
echo - Removing rEFInd UEFI entry
if defined RefindGUID bcdedit /delete %RefindGUID%

rem Removing rEFInd files from EFI partition
echo - Removing rEFInd files from EFI partition
rd /s /q %drv%\EFI\refind

rem Unmounting EFI partition
echo - Unmounting EFI partition
mountvol %drv% /d

set RefindGUID=
@echo on

pause

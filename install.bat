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

rem Removing previous rEFInd installation from EFI partition
if not exist %drv%\EFI\refind goto :skipDeletePreviousInstall
echo - Removing previous rEFInd installation from EFI partition
rd /s /q %drv%\EFI\refind

:skipDeletePreviousInstall
rem Copying Refind 0.14.0.2 to EFI partition
echo - Copying Refind 0.14.0.2 to EFI partition
xcopy /e /q /y %~dp0refind %drv%\EFI\refind\

rem Copying Refind Themes to EFI partition
echo - Copying Refind Themes to EFI partition
xcopy /e /q /y %~dp0themes %drv%\EFI\refind\themes\

rem Copying Refind Configuration to EFI partition
echo - Copying Refind Configuration to EFI partition
xcopy /s /q /y %~dp0config\refind.conf %drv%\EFI\refind\

rem Restore Previous Refind GUID if exists
if defined RefindGUID echo %RefindGUID%>%drv%\EFI\refind\GUID.txt

rem skip rEFInd creation if already exists
if defined RefindGUID goto :skipCreateUEFIentry

rem Setting rEFInd as default boot manager
rem To see BCD entries : bcdedit /enum firmware
echo - Creating rEFInd UEFI entry
For /F "tokens=2 delims={}" %%i in ('bcdedit /copy "{bootmgr}" /d "rEFInd"') do (set RefindGUID={%%i})
echo %RefindGUID%>%drv%\EFI\refind\GUID.txt
bcdedit /set "%RefindGUID%" path \EFI\refind\refind_x64.efi
bcdedit /deletevalue "%RefindGUID%" locale
bcdedit /deletevalue "%RefindGUID%" inherit
bcdedit /deletevalue "%RefindGUID%" default
bcdedit /deletevalue "%RefindGUID%" resumeobject
bcdedit /deletevalue "%RefindGUID%" displayorder
bcdedit /deletevalue "%RefindGUID%" toolsdisplayorder
bcdedit /deletevalue "%RefindGUID%" timeout
bcdedit.exe /set "{fwbootmgr}" displayorder %RefindGUID% /remove
bcdedit.exe /set "{fwbootmgr}" displayorder %RefindGUID% /addfirst

:skipCreateUEFIentry

rem Unmount EFI partition
echo - Unmounting EFI partition
mountvol %drv% /d

:EndScript
set RefindGUID=
@echo on

pause
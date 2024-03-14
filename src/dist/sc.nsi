!include MUI2.nsh


#!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
#!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE English

!define APPNAME "Loza"
!define COMPANYNAME "Wsoum"
!define DESCRIPTION "The Loza Programming Language"
!define HELPURL "https://loza.wsoum.eu.org" # "Support Information" link
!define UPDATEURL "https://loza.wsoum.eu.org" # "Product Updates" link
!define ABOUTURL "https://loza.wsoum.eu.org" # "Publisher" link

# These three must be integers
!define VERSIONMAJOR 1
!define VERSIONMINOR 1
!define VERSIONBUILD 1

!define INSTALLSIZE 7233
 
RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
 
InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAME}"
 
# rtf or txt file - remember if it is txt, it must be in the DOS text format (\r\n)
#LicenseData "license.rtf"
# This will be in the installer/uninstaller's title bar
Name "${COMPANYNAME} - ${APPNAME}"
Icon "logo.ico"
outFile "lozainstaller.exe"
 
#!include LogicLib.nsh
 
# Just three pages - license agreement, install location, and installation
#page license
page directory
Page instfiles
 
section "install"
	# Files for the install directory - to build the installer, these should be in the same directory as the install script (this file)
	setOutPath $INSTDIR
	# Files added here should be removed by the uninstaller (see section "uninstall")
	file "loza.exe"
	file "logo.ico"
	# Add any other files for the install directory (license files, app data, etc) here
 
	# Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "$INSTDIR\lozauninstall.exe"
 
	# Start Menu
	createDirectory "$SMPROGRAMS\${COMPANYNAME}"
	createShortCut "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk" "$INSTDIR\loza.exe" "" "$INSTDIR\logo.ico"
 
	# Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayName" "${APPNAME} - ${DESCRIPTION}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "UninstallString" "$\"$INSTDIR\lozauninstall.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\lozauninstall.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\logo.ico$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "Publisher" "${COMPANYNAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayVersion" "$\"${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}$\""
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMinor" ${VERSIONMINOR}
	# There is no option for modifying or repairing the install
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoRepair" 1
	# Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "EstimatedSize" ${INSTALLSIZE}
	
	WriteRegStr HKCR ".loza" "" "LozaFile"
	WriteRegStr HKCR "LozaFile" "" "Loza File"
	WriteRegStr HKCR "LozaFile\shell\open\command" "" '"$INSTDIR\loza.exe" "%1"'

	
 
	# Uninstaller - See function un.onInit and section "uninstall" for configuration
	 ; Check for write access
  EnVar::Check "NULL" "NULL"
  Pop $0
  DetailPrint "EnVar::Check write access HKCU returned=|$0|"
 
  ; Set to HKLM
  EnVar::SetHKLM

  ; Check for write access
  EnVar::Check "NULL" "NULL"
  Pop $0
  DetailPrint "EnVar::Check write access HKLM returned=|$0|"
 
  ; Set back to HKCU
  EnVar::SetHKCU
  DetailPrint "EnVar::SetHKCU"
 
  ; Check if the 'temp' variable exists in EnVar::SetHKxx
  EnVar::Check "temp" "NULL"
  Pop $0
  DetailPrint "EnVar::Check returned=|$0|"
 
  ; Append a value
  EnVar::AddValue "ZTestVariable" "$SMPROGRAMS"
  Pop $0
  DetailPrint "EnVar::AddValue returned=|$0|"
  
    ; Append an expanded value (REG_EXPAND_SZ)
  EnVar::AddValueEx "ZTestVariable1" "$INSTDIR"
  Pop $0
  DetailPrint "EnVar::AddValue returned=|$0|"
sectionEnd
 
# Uninstaller
 
function un.onInit
	SetShellVarContext all
 
	#Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Permanantly remove ${APPNAME}?" IDOK next
		Abort
	next:
functionEnd
 
section "uninstall"
 
	# Remove Start Menu launcher
	delete "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk"
	# Try to remove the Start Menu folder - this will only happen if it is empty
	rmDir "$SMPROGRAMS\${COMPANYNAME}"
 
	# Remove files
	delete $INSTDIR\loza.exe
	delete $INSTDIR\logo.ico
 
	# Always delete uninstaller as the last action
	delete $INSTDIR\lozauninstall.exe
 
	# Try to remove the install directory - this will only happen if it is empty
	rmDir $INSTDIR
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"
	
	
	
	  ; Delete a value from a variable
  EnVar::DeleteValue "ZTestVariable1" "$INSTDIR"
  Pop $0
  DetailPrint "EnVar::DeleteValue returned=|$0|"
 
  ; Delete a variable
  EnVar::Delete "ZTestVariable"
  Pop $0
  DetailPrint "EnVar::Delete returned=|$0|"
 
  ; Try deleting "path", this should give an error (%path% is a shared resource)
  EnVar::Delete "path"
  Pop $0
  DetailPrint "EnVar::Delete returned=|$0|"
sectionEnd
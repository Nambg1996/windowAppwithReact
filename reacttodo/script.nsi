; The name of the installer
Name "apptomlite"

; To change from default installer icon:
;Icon "atomicon.ico"

; The setup filename
OutFile "apptomlite_Setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\apptomlite

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\apptomlite" "Install_Dir"

RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Python version Platformio (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR

 
  
  ; Put file there (you can add more File lines too)
  ;File "finalproject\dist\win-unpacked\apptomlite.exe"
  ;File "config.json"
  ;File "atomicon.ico"
  File /r dist\*.*
  
  ; Wildcards are allowed:
  ; File *.dll
  ; To add a folder named MYFOLDER and all files in it recursively, use this EXACT syntax:
  ; File /r MYFOLDER\*.*
  ; See: https://nsis.sourceforge.io/Reference/File
  ; MAKE SURE YOU PUT ALL THE FILES HERE IN THE UNINSTALLER TOO
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\apptomlite "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\apptomlite" "DisplayName" "apptomlite"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\apptomlite" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\apptomlite" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\apptomlite" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts (required)"
  SectionIn RO

  CreateDirectory "$SMPROGRAMS\apptomlite"
  ;CreateShortcut "$SMPROGRAMS\apptomlite\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  ;CreateShortcut "$SMPROGRAMS\apptomlite\apptomlite.lnk" "$INSTDIR\dist\win-unpacked\apptomlite.exe" "" "$INSTDIR\dist\win-unpacked\apptomlite.exe" 0
  CreateShortcut "$DESKTOP\apptomlite.lnk" "$INSTDIR\win-unpacked\apptomlite.exe"
  ; make Shortcut to desktop from exe file
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\apptomlite"
  DeleteRegKey HKLM SOFTWARE\apptomlite

  ; Remove files and uninstaller
  ; MAKE SURE NOT TO USE A WILDCARD. IF A
  ; USER CHOOSES A STUPID INSTALL DIRECTORY,
  ; YOU'LL WIPE OUT OTHER FILES TOO
  Delete $INSTDIR\apptomlite.exe
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\builder-debug.yml
  Delete $INSTDIR\builder-effective-config.yaml
  ;Delete $INSTDIR\atomicon.ico
  ;Delete $INSTDIR\config.json
  RMDir /r "$INSTDIR\win-unpacked"
  ;RMDir /r "$INSTDIR\build"

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\apptomlite\*.*"

  ; Remove directories used (only deletes empty dirs)
  RMDir "$SMPROGRAMS\apptomlite"
  RMDir "$INSTDIR"
  Delete "$DESKTOP\apptomlite.lnk"

SectionEnd
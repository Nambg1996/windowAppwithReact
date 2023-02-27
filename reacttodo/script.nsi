; The name of the installer
Name "appTomlite"

; To change from default installer icon:
Icon "atomicon.ico"

; The setup filename
OutFile "appTomlite_Setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\appTomlite

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\appTomlite" "Install_Dir"

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
  ;File "finalproject\dist\win-unpacked\appTomlite.exe"
  ;File "config.json"
  File "atomicon.ico"
  File /r finalproject\*.*
  
  ; Wildcards are allowed:
  ; File *.dll
  ; To add a folder named MYFOLDER and all files in it recursively, use this EXACT syntax:
  ; File /r MYFOLDER\*.*
  ; See: https://nsis.sourceforge.io/Reference/File
  ; MAKE SURE YOU PUT ALL THE FILES HERE IN THE UNINSTALLER TOO
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\appTomlite "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\appTomlite" "DisplayName" "appTomlite"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\appTomlite" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\appTomlite" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\appTomlite" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts (required)"
  SectionIn RO

  CreateDirectory "$SMPROGRAMS\appTomlite"
  ;CreateShortcut "$SMPROGRAMS\appTomlite\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  ;CreateShortcut "$SMPROGRAMS\appTomlite\appTomlite.lnk" "$INSTDIR\dist\win-unpacked\appTomlite.exe" "" "$INSTDIR\dist\win-unpacked\appTomlite.exe" 0
  CreateShortcut "$DESKTOP\appTomlite.lnk" "$INSTDIR\dist\win-unpacked\electron-todo-app.exe"
  ; make Shortcut to desktop from exe file
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\appTomlite"
  DeleteRegKey HKLM SOFTWARE\appTomlite

  ; Remove files and uninstaller
  ; MAKE SURE NOT TO USE A WILDCARD. IF A
  ; USER CHOOSES A STUPID INSTALL DIRECTORY,
  ; YOU'LL WIPE OUT OTHER FILES TOO
  Delete $INSTDIR\appTomlite.exe
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\atomicon.ico
  ;Delete $INSTDIR\config.json
  RMDir /r "$INSTDIR\Atomlite"
  RMDir /r "$INSTDIR\build"

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\appTomlite\*.*"

  ; Remove directories used (only deletes empty dirs)
  RMDir "$SMPROGRAMS\appTomlite"
  RMDir "$INSTDIR"
  Delete "$DESKTOP\appTomlite.lnk"

SectionEnd
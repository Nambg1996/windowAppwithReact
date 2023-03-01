!define APP_NAME "apptomlite"

Name "${APP_NAME}"

OutFile "${APP_NAME}_Setup.exe"

InstallDir $PROGRAMFILES\${APP_NAME}

InstallDirRegKey HKLM "Software\${APP_NAME}" "Install_Dir"
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
Section 

  SectionIn RO
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR

  File /r dist\*.*
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\${APP_NAME} "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section  "Start Menu Shortcuts (required)"
  SectionIn RO
  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortcut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\win-unpacked\${APP_NAME}.exe"
  ; make Shortcut to desktop from exe file
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
  DeleteRegKey HKLM SOFTWARE\${APP_NAME}

  ; Remove files and uninstaller

  Delete $INSTDIR\${APP_NAME}.exe
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\builder-debug.yml
  Delete $INSTDIR\builder-effective-config.yaml
  RMDir /r "$INSTDIR\win-unpacked"
 
  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\${APP_NAME}\*.*"
  ; Remove directories used (only deletes empty dirs)
  RMDir "$SMPROGRAMS\${APP_NAME}"
  RMDir "$INSTDIR"
  Delete "$DESKTOP\${APP_NAME}.lnk"

SectionEnd

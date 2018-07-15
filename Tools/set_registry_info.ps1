$BrowserSuffix="-main"
$BrowserRegName="BROWSERSELECT${BrowserSuffix}"
new-item -Path HKCU:\Software\Clients\StartMenuInternet\$BrowserRegName -Name "" -Value "Browser Select"


<#
  ;for register as default browser
  ;create entry in startmenuinternet
  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE" \
                 "" "Browser Select"
;add capabilities
  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities" \
                 "ApplicationName" "BrowserSelect"
  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities" \
                 "ApplicationDescription" "Choose a Browser dynamically."
  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities" \
                 "ApplicationIcon" "$INSTDIR\BrowserSelect.exe,0"

  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities\StartMenu" \
                 "StartMenuInternet" "BROWSERSELECT.EXE"

  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities\URLAssociations" \
                 "http" "bselectURL"
  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities\URLAssociations" \
                 "https" "bselectURL"
;add icon and command				 
  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\DefaultIcon" \
                 "" "$INSTDIR\BrowserSelect.exe,0"
  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\shell\open\command" \
                 "" "$\"$INSTDIR\BrowserSelect.exe$\""
;register capablities
  WriteRegStr HKCU "Software\RegisteredApplications" \
                 "BrowserSelect" "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities"
;register handler
  WriteRegStr HKCU "Software\Classes\bselectURL" \
                 "" "BrowserSelect Url"
  WriteRegStr HKCU "Software\Classes\bselectURL\shell\open\command" \
                 "" "$\"$INSTDIR\BrowserSelect.exe$\" $\"%1$\""
  
  #>


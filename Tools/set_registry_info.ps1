Function Add-BrowserSelectToBrowserList {
    [cmdletBinding(SupportsShouldProcess=$True)]
    Param(
        [string]$BinPath,
        [string]$BrowserSuffix
    )

    $BrowserRegName="BROWSERSELECT${BrowserSuffix}"
    $HKCUStartMenuInternet = "Software\Clients\StartMenuInternet\$BrowserRegName"
    $HKCUStartMenuInternetFullPath = "HKCU:\$HKCUStartMenuInternet"


    new-item -Path "HKCU:\Software\$BrowserRegName" -Name "" -Value $(Split-Path -Path $BinPath -Parent)

    #  ;for register as default browser
    #  ;create entry in startmenuinternet
    new-item -Path $HKCUStartMenuInternetFullPath -Name "" -Value "Browser Select"



    #;add capabilities
    New-Item -Path "$HKCUStartMenuInternetFullPath\Capabilities"
    New-ItemProperty -Path "$HKCUStartMenuInternetFullPath\Capabilities" -Name "ApplicationName" -Value $BrowserRegName
    New-ItemProperty -Path "$HKCUStartMenuInternetFullPath\Capabilities" -Name "ApplicationDescription" -Value "Choose a Browser dynamically."
    New-ItemProperty -Path "$HKCUStartMenuInternetFullPath\Capabilities" -Name "ApplicationIcon" -Value "$BinPath,0"

    New-Item -Path "$HKCUStartMenuInternetFullPath\StartMenu"
    New-ItemProperty -Path "$HKCUStartMenuInternetFullPath\StartMenu" -Name "StartMenuInternet" -Value $BrowserRegName


    #; add protocols
    New-Item -Path "$HKCUStartMenuInternetFullPath\Capabilities\URLAssociations"
    $Protocols=@('http','https')
    $Protocols | % {
        New-ItemProperty -Path "$HKCUStartMenuInternetFullPath\Capabilities\URLAssociations" -Name $_ -Value "bselectURL"
    }

    #;add icon and command				 
    New-Item -Path "$HKCUStartMenuInternetFullPath\DefaultIcon" -Name "" -Value "$BinPath,0"
    New-Item -Path "$HKCUStartMenuInternetFullPath\shell\open\command" -Name "" -Value "`"$BinPath`"" -Force

    #;register capablities
    New-ItemProperty -Path "HKCU:\Software\RegisteredApplications" -Name $BrowserRegName -Value "$HKCUStartMenuInternet\Capabilities"

    #;register handler
    new-item -Path "HKCU:\Software\Classes\bselectURL" -Name "" -Value "BrowserSelect URL"
    new-item -Path "HKCU:\Software\Classes\bselectURL\shell\open\command"  -Name "" -Value "`"$BinPath`" `"%1`"" -Force
    



    #;add capabilities
    #  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities" \
    #                 "ApplicationName" "BrowserSelect"
    #  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities" \
    #                 "ApplicationDescription" "Choose a Browser dynamically."
    #  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities" \
    #                 "ApplicationIcon" "$INSTDIR\BrowserSelect.exe,0"

      #WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities\StartMenu" \
      #               "StartMenuInternet" "BROWSERSELECT.EXE"

    #  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities\URLAssociations" \
    #                 "http" "bselectURL"
    #  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities\URLAssociations" \
    #                 "https" "bselectURL"
    #;add icon and command				 
    #  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\DefaultIcon" \
    #                 "" "$INSTDIR\BrowserSelect.exe,0"
    #  WriteRegStr HKCU "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\shell\open\command" \
    #                 "" "$\"$INSTDIR\BrowserSelect.exe$\"" 
    #;register capablities
    #  WriteRegStr HKCU "Software\RegisteredApplications" \
    #                 "BrowserSelect" "Software\Clients\StartMenuInternet\BROWSERSELECT.EXE\Capabilities"
    #;register handler
    #  WriteRegStr HKCU "Software\Classes\bselectURL" \
    #                 "" "BrowserSelect Url"
    #  WriteRegStr HKCU "Software\Classes\bselectURL\shell\open\command" \
    #                 "" "$\"$INSTDIR\BrowserSelect.exe$\" $\"%1$\""
    #  
      #>


}

Add-BrowserSelectToBrowserList -BinPath "C:\AO\tools\BrowserSelect\BrowserSelect.exe" -BrowserSuffix "-main" -Verbose


#
# For testing/debugging purposes, clear BrowserSelect registry info.
#
Function Remove-BrowserSelectToBrowserList {
    [cmdletBinding(SupportsShouldProcess=$True)]
    Param(
        [string]$BrowserSuffix
    )

    $BrowserRegName="BROWSERSELECT${BrowserSuffix}"
    $HKCUStartMenuInternet = "Software\Clients\StartMenuInternet\$BrowserRegName"
    $HKCUStartMenuInternetFullPath = "HKCU:\$HKCUStartMenuInternet"

    Remove-Item -Path HKCU:\Software\$BrowserRegName 
    Remove-item -Path $HKCUStartMenuInternetFullPath -Recurse
    Remove-ItemProperty -Path HKCU:\Software\RegisteredApplications -Name $BrowserRegName
    Remove-Item -Path HKCU:\Software\Classes\bselectURL -Recurse

}

Remove-BrowserSelectToBrowserList -BrowserSuffix ".exe" -Verbose


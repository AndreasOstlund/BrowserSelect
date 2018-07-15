#
# For testing/debugging purposes, clear BrowserSelect registry info.
#
Remove-Item -Path HKCU:\Software\BrowserSelect 
Remove-item -Path HKCU:\Software\Clients\StartMenuInternet\BrowserSelect.exe -Recurse
Remove-ItemProperty -Path HKCU:\Software\RegisteredApplications -Name "BrowserSelect"
Remove-Item -Path HKCU:\Software\Classes\bselectURL -Recurse


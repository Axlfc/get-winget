Set-ExecutionPolicy RemoteSigned
$MyLink = "https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"



Write-Host "Winget is being downloaded"

<#
  Ensure a concrete path to perform the download and execution of the file.
#>

Invoke-WebRequest -Uri $MyLink -OutFile winget-installer.msixbundle
Write-Host "Winget installer downloaded, launching installer."
#Add-AppxPackage -Path .\winget-installer.msixbundle -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown


.\winget-installer.msixbundle

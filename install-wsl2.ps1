$MyLink = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart

Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart

# Set Linux Kernel to last version
##

## Reboot?

Invoke-WebRequest -Uri $MyLink -OutFile wsl2-linux-kernel-installer.msixbundle

Add-AppxPackage -Path .\wsl2-linux-kernel-installer.msixbundle -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown

Write-Host "WSL2 installer downloaded, launching installer."
#.\wsl2-linux-kernel-installer.msixbundle


wsl --set-default-version 2

winget install -s msstore "Ubuntu"
#winget install -s msstore "Debian"...



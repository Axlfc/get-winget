Set-ExecutionPolicy Unrestricted

Write-Host "DO: Installing WSL2"
# https://thomasward.com/wsl2-x11/ <- Reference

wsl --set-default-version 2

$MyLink = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$AppPath = echo $(Get-Location) | Select-String "C:"
$AppPath = $AppPath -replace "`n|`r"
$AppPath = $AppPath + "\wsl2-linux-kernel-installer.msi"
$condition = $(Test-Path -Path $(echo $AppPath))
if ( ! $condition )
{
    Write-Host "WSL2 launching update file download"
    Invoke-WebRequest -Uri $MyLink -OutFile wsl2-linux-kernel-installer.msi
}
Write-Host "WSL2 launching update install"
msiexec /qn /i $(echo $AppPath)

#Add-AppxPackage -Path $(echo $AppPath) -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown

wsl --unregister "Ubuntu"
Write-Host "Wait until Ubuntu is fully installed in WSL2 and ´don't forget to set up your local user name/password"
wsl --install -d "Ubuntu"

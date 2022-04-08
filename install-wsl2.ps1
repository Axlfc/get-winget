Set-ExecutionPolicy Unrestricted

Write-Host "DO: Installing WSL2"
# https://thomasward.com/wsl2-x11/ <- Reference

$MyLink = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
Write-Host "Reboot the computer, enable Virtualization in BIOS if isn't aready enabled or if it's the first run time"
Write-Host "Run again this script after rebooting"


wsl --set-default-version 2

$AppPath = echo $(Get-Location) | Select-String "C:"
$AppPath = $AppPath -replace "`n|`r"
$AppPath = $AppPath + "\wsl2-linux-kernel-installer.msi"
$condition = $(Test-Path -Path $(echo $AppPath))
if ( ! $condition )
{
    Invoke-WebRequest -Uri $MyLink -OutFile wsl2-linux-kernel-installer.msi
}

Write-Host "WSL2 launching update"

# TODO: Protect package download if already present from run before reboot
#Add-AppxPackage -Path $(echo $AppPath) -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown
msiexec /qn /i $(echo $AppPath)
#wsl --unregister "Ubuntu"
wsl --install -d "Ubuntu"

Write-Host "You have to set up Ubuntu, waiting 2 min."
Start-Sleep -s 120
#winget install -s msstore "Ubuntu"
#winget install -s msstore "Debian"


Write-Host "DO: Configuring Windows firewall to only allow connections to the X11 display server from the WSL2 instance running on your computer."

Write-Host "Running command in WSL2:"
# This command isn't probably going to work.
wsl bash -c 'source ~/.profile;
LINUX_IP=$(ip addr | awk "/inet / && !/127.0.0.1/ {split($2,a,"/"); print a[1]}");
WINDOWS_IP=$(ip route | awk "/^default/ {print $3}");
powershell.exe -Command "Start-Process netsh.exe -ArgumentList \"advfirewall firewall add rule name=X11-Forwarding dir=in action=allow program=%ProgramFiles%\VcXsrv\vcxsrv.exe localip=$WINDOWS_IP remoteip=$LINUX_IP localport=6000 protocol=tcp\" -Verb RunAs"'
Write-Host "Firewall command has been runned within WSL2."


Write-Host "DO: Installing an X11 display server, VcXsrv"
$MyLink = "https://downloads.sourceforge.net/project/vcxsrv/vcxsrv/vcxsrv.1.13.0.0.installer.exe?ts=gAAAAABiTtu01DSPfakGxjUn3b-OuXGM7aNxGBZ5INVe-8X0rQGfh8bT9F-3xc9Ful4XciXxYnPrmOqhgMtfLMYWcs489rHPYQ%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fvcxsrv%2Ffiles%2Fvcxsrv%2Fvcxsrv.1.13.0.0.installer.exe%2Fdownload"
Invoke-WebRequest -Uri $MyLink -OutFile VcXsrv-Windows-X-Server.exe
Write-Host "VcXsrv Windows X Server installer downloaded, launching installer."
$AppPath = echo $(Get-Location) | Select-String "C:"
$AppPath = $AppPath -replace "`n|`r"
$AppPath = $AppPath + "\VcXsrv-Windows-X-Server.msixbundle"
# Add-AppxPackage -Path $(echo $AppPath) -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown
.\$(echo $AppPath)


Write-Host "Adding VcXsrv to autostart (not working)"
$StartupAllUsersPath = "%SystemDrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
Write-Host "path: $StartupAllUsersPath"
$VcXsrvStartupCondition = '"%ProgramFiles%\VcXsrv\vcxsrv.exe" :0 -multiwindow -clipboard -wgl -ac'
Write-Host "startup: $VcXsrvStartupCondition"
Write-Host "DON'T: Create desktop shortcut pointing to VcXsrv"
Write-Host "DON'T: Move desktop shortcut to Windows AutoStart folder"


Write-Host "Configuring WSL2 to auto-update the firewall rule when IP addresses change and know how to send graphical output to VcXsrv."
# Append the following script to WSL2's ~/.profile

Write-Host "echo command appending to WSL2's profile"
# The following line might probably not run as expected
wsl bash -c 'echo "LINUX_IP=$(ip addr | awk "/inet / && !/127.0.0.1/ {split($2,a,"/"); print a[1]}")
WINDOWS_IP=$(ip route | awk "/^default/ {print $3}")
FIREWALL_WINDOWS_IP=$(netsh.exe advfirewall firewall show rule name=X11-Forwarding | awk "/^LocalIP/ {split($2,a,"/");print a[1]}")
FIREWALL_LINUX_IP=$(netsh.exe advfirewall firewall show rule name=X11-Forwarding | awk "/^RemoteIP/ {split($2,a,"/");print a[1]}")

if [ "$FIREWALL_LINUX_IP" != "$LINUX_IP" ] || [ "$WINDOWS_IP" != "$FIREWALL_WINDOWS_IP" ]; then
	powershell.exe -Command "Start-Process netsh.exe -ArgumentList \"advfirewall firewall set rule name=X11-Forwarding new localip=$WINDOWS_IP remoteip=$LINUX_IP \" -Verb RunAs"
fi

DISPLAY="$WINDOWS_IP:0"
LIBGL_ALWAYS_INDIRECT=1
export DISPLAY LIBGL_ALWAYS_INDIRECT" >> ~/.profile'

Write-Host "Enjoy X11 forwarding from WSL2 to Windows."

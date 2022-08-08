Set-ExecutionPolicy RemoteSigned
$MyLink = "http://bosmans.ch/pulseaudio/pulseaudio-1.1.zip"

Write-Host "Pulseaudio is being downloaded"
Invoke-WebRequest -Uri $MyLink -OutFile "pulseaudio-1.1.zip"
Write-Host "Pulseaudio installer downloaded, try to decompress to C:\pulse\"
Expand-Archive -LiteralPath pulseaudio-1.1.zip -DestinationPath "C:\pulse\"

# Set service with path C:\pulse\pulseaudio.exe
# Set startupdirectory C:\pulse
# Set arguments -F C:\pulse\config.pa --exit-idle-time=-1
# startup type automatic

$serviceName = "PulseAudio"

if (Get-Service $serviceName -ErrorAction SilentlyContinue)
{
    $serviceToRemove = Get-WmiObject -Class Win32_Service -Filter "name='$serviceName'"
    $serviceToRemove.delete()
    "service removed"
}
else
{
    "service does not exists"
}

"installing service"

$secpasswd = ConvertTo-SecureString "MyPassword" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential (".\MYUser", $secpasswd)
$binaryPath = "C:\pulse\pulseaudio.exe -F C:\pulse\config.pa --exit-idle-time=-1"
New-Service -name $serviceName -binaryPathName $binaryPath -displayName $serviceName -startupType Automatic -credential $mycreds

"service installation completed"

"START Configure PulseAudio for Windows."

New-Item "C:\pulse\config.pa" -ItemType File -Value "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;172.16.0.0/12
load-module module-esound-protocol-tcp auth-ip-acl=127.0.0.1;172.16.0.0/12
load-module module-waveout sink_name=output source_name=input record=0"

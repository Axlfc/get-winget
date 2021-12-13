$es_comm=([CultureInfo]::InstalledUICulture | Select-String -Pattern 'es-ES' -CaseSensitive -SimpleMatch) -replace(" ", "");
$ca_comm=([CultureInfo]::InstalledUICulture | Select-String -Pattern 'ca-ES' -CaseSensitive -SimpleMatch)-replace(" ", "");

if( $es_comm -eq 'es-ES' ) {
    $DISPLAY_GROUP="Compartir archivos e impresoras"
}elseif( $ca_comm -eq 'ca-ES') {
    # This need to be confirmed
    $DISPLAY_GROUP="Compartir fitxers i impressores"
}
else {
   $DISPLAY_GROUP="Enable Printers and Files Sharing"
}
Set-NetFirewallRule -DisplayGroup $DISPLAY_GROUP -Enabled True -Profile Any

Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'

# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~0.0.1.0

# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

.\install-winget.ps1
.\install-python.ps1
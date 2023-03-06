winget install --accept-package-agreements --accept-source-agreements -h --id "marha.VcXsrv"
# Moving program shortcut to autostart.
# Example Get-ChildItem "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -Recurse | Where-Object { $_.Name -like '*.lnk' -and $_.Name -like '*adobe*' } | ForEach-Object { $_.FullName }
$programDirectLink="$(Get-ChildItem "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -Recurse -Directory | Where-Object { $_.Name -like '*VcXsrv*' } | Get-ChildItem -Filter '*.lnk' | Where-Object { $_.Name -notlike '*Uninstall*' } | ForEach-Object { $_.FullName })"
$username="$($env:USERNAME)"
$windowsAutostartPath="C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
cp $programDirectLink $windowsAutostartPath

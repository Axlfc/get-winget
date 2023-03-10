winget install --accept-package-agreements --accept-source-agreements -h --id "marha.VcXsrv"
# TODO: The command of execution of the desktop shortcut is "vcxsrv.exe -multiwindow"
# REF: https://www.reddit.com/r/bashonubuntuonwindows/comments/b2twx1/small_guide_on_getting_x_applications_on_windows/
# Moving program shortcut to autostart.
# Example Get-ChildItem "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -Recurse | Where-Object { $_.Name -like '*.lnk' -and $_.Name -like '*adobe*' } | ForEach-Object { $_.FullName }
$programDirectLink="$(Get-ChildItem "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" -Recurse -Directory | Where-Object { $_.Name -like '*VcXsrv*' } | Get-ChildItem -Filter '*.lnk' | Where-Object { $_.Name -notlike '*Uninstall*' } | ForEach-Object { $_.FullName })"
$username="$($env:USERNAME)"
$windowsAutostartPath="C:\Users\$username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
cp $programDirectLink $windowsAutostartPath

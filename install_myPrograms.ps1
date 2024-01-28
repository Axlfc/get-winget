function Populate-Windows {
	Param(
		[Parameter(Mandatory=$true,Position=0)] [String]$ProgramName
	)
	winget install -e --id $ProgramName --force
}
$pop_apps = "Mozilla.Firefox",
"Kitware.CMake",
"Microsoft.VisualStudio.2022.BuildTools",
"EpicGames.EpicGamesLauncher", 
"Spotify.Spotify",
"Ytmdesktop.Ytmdesktop",
"File-New-Project.EarTrumpet",
"Telegram.TelegramDesktop",
"Bandisoft.Honeyview",
"VideoLAN.VLC",
"Valve.Steam",
"PeterPawlowski.foobar2000",
"Nvidia.GeForceExperience",
"Nvidia.CUDA",
"BleachBit.BleachBit",
"RiotGames.LeagueOfLegends.EUW",
"Notepad++.Notepad++",
"AntibodySoftware.WizTree",
"EliasFotinis.DeskPins",
"AppWork.JDownloader",
"Discord.Discord",
"Adobe.Acrobat.Reader.64-bit",
"TheDocumentFoundation.LibreOffice",
"Autodesk.DesktopApp",
"Python.Python.3.11",
"TortoiseGit.TortoiseGit",
"GitHub.GitLFS",
"Git.Git",
"OBSProject.OBSStudio",
"Oracle.VirtualBox",
"Transmission.Transmission",
"calibre.calibre",
"Mozilla.Thunderbird",
"Google.Drive",
"TeamViewer.TeamViewer",
"RealVNC.VNCServer",
"RealVNC.VNCViewer",
"Audacity.Audacity",
"BlenderFoundation.Blender",
"Microsoft.WindowsTerminal",
"Mega.MEGASync",
"Unity.UnityHub",
"AnyDeskSoftwareGmbH.AnyDesk",
"JetBrains.PyCharm.Community",
"Fork.Fork",
"Microsoft.DotNet.SDK.7",
"Microsoft.PowerToys",
"VSCodium.VSCodium.Insiders",
"VB-Audio.Voicemeeter.Banana",
"OpenVPNTechnologies.OpenVPNConnect"

foreach ($pop_app in $pop_apps)
{
	Write-Host $pop_app
	Populate-Windows $pop_app
}

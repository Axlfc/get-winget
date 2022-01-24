function Debloat-Windows {
	Param(
		[Parameter(Mandatory=$true,Position=0)] [String]$ProgramName
	)
	Get-AppxPackage -name $ProgramName | Remove-AppxPackage
}
$bloat_apps = "Microsoft.ZuneMusic", "Microsoft.Music.Preview", "Microsoft.XboxGameCallableUI", "Microsoft.XboxIdentityProvider", "Microsoft.BingTravel", "Microsoft.BingHealthAndFitness", "Microsoft.BingFoodAndDrink", "Microsoft.People", "Microsoft.BingFinance", "Microsoft.3DBuilder", "Microsoft.WindowsCalculator", "Microsoft.BingNews", "Microsoft.XboxApp", "Microsoft.BingSports", "Microsoft.WindowsCamera", "Microsoft.Getstarted", "Microsoft.Office.OneNote", "Microsoft.WindowsMaps", "Microsoft.MicrosoftSolitaireCollection", "Microsoft.MicrosoftOffi1ceHub", "Microsoft.BingWeather", "Microsoft.BioEnrollment", "Microsoft.WindowsStore", "Microsoft.Windows.Photos", "Microsoft.WindowsPhone"

foreach ($bloat_app in $bloat_apps)
{
	Write-Host $bloat_app
	Debloat-Windows $bloat_app
}

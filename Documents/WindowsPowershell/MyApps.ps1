# MyApps.ps1

# Array to store app configurations
$MyApps = @(
    @{
        alias = "pycharm"
        path = "C:\Program Files (x86)\JetBrains\PyCharm Community Edition 2023.3.3\bin\"
        executable = "pycharm64.exe"
    }
    # Add more app configurations here as needed, for example:
    # ,@{
    #     alias = "vscode"
    #     path = "C:\Program Files\Microsoft VS Code"
    #     executable = "Code.exe"
    # }
)


function Add-PathAndAlias {
    param (
        [string]$path,
        [string]$alias,
        [string]$executable
    )

    # Validate the provided path
    if (-not (Test-Path $path)) {
        Write-Host "The path '$path' does not exist." -ForegroundColor Red
        return
    }

    # Check if the executable exists in the provided path
    $executablePath = Join-Path -Path $path -ChildPath $executable
    if (-not (Test-Path $executablePath)) {
        Write-Host "The executable '$executable' does not exist in the path '$path'." -ForegroundColor Red
        return
    }

    # Add the path to the PATH environment variable
    if ($env:Path.Split(';') -notcontains $path) {
        $env:Path += ";$path"
        # Write-Host "Added '$path' to the PATH environment variable." -ForegroundColor Green
    } else {
        Write-Host "The path '$path' is already in the PATH environment variable." -ForegroundColor Yellow
	return
    }

    # Create a new function that launches the executable with or without arguments
    $functionDefinition = @"
function global:$alias {
    param(
        [Parameter(ValueFromRemainingArguments=`$true)]
        [string[]]`$args
    )
    
    if (`$args.Count -eq 0) {
        Start-Process -FilePath "$executablePath" -WindowStyle Hidden
    } else {
        Start-Process -FilePath "$executablePath" -ArgumentList `$args
    }
}
"@
    Invoke-Expression $functionDefinition
    # Write-Host "Created function '$alias' to launch '$executable' with or without arguments." -ForegroundColor Green
}

# Function to load all app configurations
function Load-MyApps {
    foreach ($app in $MyApps) {
        Add-PathAndAlias -alias $app.alias -path $app.path -executable $app.executable
    }
}

# Call Load-MyApps function
# Load-MyApps

Set-ExecutionPolicy RemoteSigned
$MyLink = "https://www.python.org/ftp/python/3.10.1/python-3.10.1-amd64.exe"


Write-Host "Python is being downloaded"

<#
  Ensure a concrete path to perform the download and execution of the file.
#>

Invoke-WebRequest -Uri $MyLink -OutFile python-installer.exe

Add-AppxPackage -Path .\python-installer.exe -ForceUpdateFromAnyVersion -Confirm -ForceTargetApplicationShutdown

Write-Host "python installer downloaded, launching installer."
.\python-installer.exe

# get-winget
Windows shell &amp; powershell script to install version v1.0.11692 of winget, Window's default package manager, directly from the Windows shell itself.

### Install procedure:
You may need to run the consoles with administrative privileges.

- Knowing actual Windows Execution Policy:

`Get-ExecutionPolicy`

- To get all the execution directives that affect the current session and display them in order of precedence:

`Get-ExecutionPolicy -List`

- To see the actual scope of the Execution Policy for the current user using the windows machine:

`Get-ExecutionPolicy -Scope CurrentUser`

- Enable Execution of scripts (be careful to know your previous Policy of execution and to launch shell with administrator privileges, consider changing it back to the same Execution Policy as the previous one after installing winget via this script to prevent possible malware vulnerabilities associated with the Execution Policy. You should be knowing what are you doing... )

`Set-ExecutionPolicy RemoteSigned`

Clone this repository into your desired folder (You should use [MINGW](https://gitforwindows.org/) or [MSYS2 with git installed](https://www.youtube.com/watch?v=pb6Yb819pF0) to do this. Beware spaces in folder names...) optional

Inside MINGW bash console:

`cd ~/Documents/Scripts`

`git clone https://github.com/Axlfc/get-winget`

Back to cmd or Powershell:

- Navigate to the same folder via cmd or powershell (example):

`cd c:\Users\USERNAME\Documents\Scripts\get-winget`

- Check for the [installer script](https://github.com/Axlfc/get-winget/blob/main/install-winget.ps1) (https://github.com/Axlfc/get-winget/blob/main/install-winget.ps1) Download the script, check for recent stable versions of releases of winget github inside the script variable to hold the link of winget's intaller.

- Execute `install-winget` script to begin the installation of winget on the computer if the Execution Policies have been correctly set.

`.\install-winget.ps1`

- Reconsider changing back to the previous Execution Policy you had before the changes made (if there are any) in the previous steps. (optional but recommended)

`Set-ExecutionPolicy Default`

- Now you should be able to install applications via command using `winget`:

- Remove `get-winget` folder and .ps1 file and `winget-installer.msixbundle`

Example:

`winget install git`

Running this in cmd/powershell will install again MINGW into your Windows computer.

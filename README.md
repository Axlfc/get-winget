# get-winget
Windows shell &amp; powershell script to install version v1.0.11692 of winget, Window's default package manager, directly from the Windows shell itself.

### Install procedure:
Install App Installer from Microsoft Store.
You may need to run the cmd or Powershell: with administrative privileges. MINGW and MSYS2 might be run as administrator also.

- Knowing actual Windows Execution Policy:

<code>`Get-ExecutionPolicy`</code>

- To get all the execution directives that affect the current session and display them in order of precedence:

<code>`Get-ExecutionPolicy -List`</code>

- To see the actual scope of the Execution Policy for the current user using the windows machine:

<code>`Get-ExecutionPolicy -Scope CurrentUser`</code>

- Enable Execution of scripts (be careful to know your previous Policy of execution and to launch shell with administrator privileges, consider changing it back to the same Execution Policy as the previous one after installing winget via this script to prevent possible malware vulnerabilities associated with the Execution Policy. You should be knowing what are you doing... )

<code>`Set-ExecutionPolicy RemoteSigned`</code>

- Navigate to the same folder via cmd or powershell (example):

<code>`cd c:\Users\USERNAME\Documents\Scripts\get-winget`</code>

- Download the script, check for recent stable versions of releases of winget github inside the script variable to hold the url of winget's intaller from its github.

- Execute `install-winget` script to begin the installation of winget on the computer if the Execution Policies have been correctly set.

<code>`Invoke-WebRequest https://github.com/Axlfc/get-winget/blob/main/install-winget.ps1 -OutFile install-winget.ps1`</code>
<br></br>
<code>`.\install-winget.ps1`</code>

- Reconsider changing back to the previous Execution Policy you had before the changes made (if there are any) in the previous steps. (optional but recommended)

<code>`Set-ExecutionPolicy Default`</code>

- Remove `get-winget` folder and .ps1 script and `winget-installer.msixbundle` file.

<br></br>

- Now you should be able to install applications via command using `winget`, Windows' package manager.

Examples:
 
<code>`winget --version`</code>

<code>`winget show`</code>

Running this in cmd/powershell will install MINGW, MSYS2, the app you desire and it's in the list shown previously in your Windows computer.

<code>`winget install git`</code>

<code>`winget install MSYS2`</code>

<br></br>

To clone this repository into your desired folder (You can use [MINGW](https://gitforwindows.org/) or [MSYS2 with git installed](https://www.youtube.com/watch?v=pb6Yb819pF0) to do this. Beware spaces in folder/file names...) `optional`

Inside MINGW or MINGW from MYSYS2 bash console you can:

<code>`cd ~/Documents/Scripts`</code>

<code>`git clone https://github.com/Axlfc/get-winget`</code>

# TODO: get winget add_to_terminal_profile

# install-winget
Windows shell &amp; powershell script to install last version of winget, directly from windows shell.
### Useful link (spanish)
  - https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.1

-Knowing actual Windows Execution Policy:
`Get-ExecutionPolicy`

-To get all the execution directives that affect the current session and display them in order of precedence, add `-List` to previous command.
`Get-ExecutionPolicy -List`

- To see the actual scope of the Execution Policy for the current user using the windows machine:
`Get-ExecutionPolicy -Scope CurrentUser`

- Enable Execution of scripts (be careful to know your previous Policy of execution and to launch shell with administrator privileges, consider changing it back to the same Execution Policy as the previous one after installing winget via this script to prevent possible malware vulnerabilities associated with the Execution Policy. You should be knowing what are you doing... )
`Set-ExecutionPolicy RemoteSigned`


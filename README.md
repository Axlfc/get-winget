# install-winget
Windows shell &amp; powershell script to install last version of winget, directly from windows shell.
### Useful link (spanish)
  - https://docs.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.1

-Knowing actual Windows Execution Policy:
`Get-ExecutionPolicy`
  *To get all the execution directives that affect the current session and display them in order of precedence, add `-List` to previous command.
    `Get-ExecutionPolicy -List`


- Enable Execution of scripts (be careful to know your actual Policy of execution and to launch shell with administrator privileges)
`Set-ExecutionPolicy RemoteSigned`

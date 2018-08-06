echo off
powershell.exe Set-ExecutionPolicy Unrestricted

PowerShell.exe "& '%~dpn0.ps1'"

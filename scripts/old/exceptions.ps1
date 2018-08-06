#--------------------------------------------------------------------------------
#  Controle des prérequis: Validation de l'adresse du serveur par l'utilisateur #
#--------------------------------------------------------------------------------

Add-Type -AssemblyName PresentationCore,PresentationFramework
Add-Type -Path C:\Windows\Microsoft.NET\assembly\GAC_MSIL\System.IO.Compression.ZipFile\v4.0_4.0.0.0__b77a5c561934e089\System.IO.Compression.ZipFile.dll


#--------------------
# Désactivation UAC #
#--------------------

### Méthode modification registre
New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force

### Ouverture fenêtre pour règlage manuel
#C:\WINDOWS\System32\UserAccountControlSettings.exe

#--------------------------------------
# Installation du module NTFSSecurity #
#--------------------------------------

Install-PackageProvider -Name NuGet -Force
Install-Module -Name NTFSSecurity -Force

#--------------------------------------------------------------------------------
# Ajout droits "controle total" sur les dossiers pour le groupe "tout le monde" #
#--------------------------------------------------------------------------------

Add-NTFSAccess –Path "C:\temp" –Account "Tout le monde" –AccessRights FullControl
Add-NTFSAccess –Path "C:\Pyxvital" –Account "Tout le monde" –AccessRights FullControl
Add-NTFSAccess –Path "C:\VZLan" –Account "Tout le monde" –AccessRights FullControl
Add-NTFSAccess –Path "C:\PyxLan" –Account "Tout le monde" –AccessRights FullControl
Add-NTFSAccess –Path "C:\Program Files (x86)\Comunica SAS" –Account "Tout le monde" –AccessRights FullControl
Add-NTFSAccess –Path "C:\Program Files (x86)\santesocial" –Account "Tout le monde" –AccessRights FullControl
Add-NTFSAccess –Path "C:\Program Data\santesocial" –Account "Tout le monde" –AccessRights FullControl
Add-NTFSAccess –Path "C:\Program Files\santesocial" –Account "Tout le monde" –AccessRights FullControl


#----------------------------------------------------
# Ajout des exclusions antivirus Microsoft Defender #
#----------------------------------------------------

Add-MpPreference -ExclusionPath "C:\temp"
Add-MpPreference -ExclusionPath "C:\Pyxvital"
Add-MpPreference -ExclusionPath "C:\VZLan"
Add-MpPreference -ExclusionPath "C:\PyxLan"
Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Comunica SAS"
Add-MpPreference -ExclusionPath "C:\Program Files (x86)\santesocial"
Add-MpPreference -ExclusionPath "C:\Program Data\santesocial"
Add-MpPreference -ExclusionPath "C:\Program Files\santesocial"
Add-MpPreference -ExclusionProcess "C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenRepeater.exe"
Add-MpPreference -ExclusionProcess "C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenService.exe"
Add-MpPreference -ExclusionProcess "C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenUpdater.exe"
Add-MpPreference -ExclusionProcess "C:\pyxvital\cpgesw32.exe"
Add-MpPreference -ExclusionProcess "C:\pyxvital\Pyxvital.exe"
Add-MpPreference -ExclusionProcess "C:\pyxvital\Pyxnet.exe"
Add-MpPreference -ExclusionProcess "C:\Program Files (x86)\santesocial\CPS\cpgesw32.exe"
Add-MpPreference -ExclusionProcess "C:\Program Files\santesocial\CPS\cpgesw64.exe"
Add-MpPreference -ExclusionProcess "C:\Program Files\santesocial\galss\galsvw64.exe"
 
Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan $False

# Si vous spécifiez la valeur $True, Windows Defender analyse les lecteurs réseau mappés.
# Si vous spécifiez une valeur de $False ou si vous ne spécifiez pas de valeur, Windows Defender n'analyse pas les lecteurs réseau mappés.

Set-MpPreference -DisableScanningNetworkFiles $False

# Si vous spécifiez la valeur $True, Windows Defender analyse les fichiers réseau.
# Si vous spécifiez une valeur de $False ou si vous ne spécifiez aucune valeur, Windows Defender n'analyse pas les fichiers réseau.
# Nous ne vous recommandons pas d'analyser les fichiers réseau.

Set-MpPreference -MAPSReporting 0

# 0: Disabled. Send no information to Microsoft. This is the default value.

Set-MpPreference -PUAProtection 0
Set-MpPreference -SubmitSamplesConsent 2



#-----------------------------------
# Ajout des autorisations Firewall #
#-----------------------------------


### Autorisation VitalZenRepeater
$firewallRuleName = "Autorisation VitalZenRepeater"
$firewallpath = "C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenRepeater.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation VitalZenService
$firewallRuleName = "Autorisation VitalZenService"
$firewallpath = "C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenService.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation VitalZenUpdater
$firewallRuleName = "Autorisation VitalZenUpdater"
$firewallpath = "C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenUpdater.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation cpgesw32 pyxvital
$firewallRuleName = "Autorisation cpgesw32 pyxvital"
$firewallpath = "C:\pyxvital\cpgesw32.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation pyxvital
$firewallRuleName = "Autorisation pyxvital"
$firewallpath = "C:\pyxvital\pyxvital.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation pyxnet
$firewallRuleName = "Autorisation pyxnet"
$firewallpath = "C:\pyxvital\pyxnet.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation cpgesw32
$firewallRuleName = "Autorisation cpgesw32"
$firewallpath = "C:\Program Files (x86)\santesocial\CPS\cpgesw32.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation cpgesw64
$firewallRuleName = "Autorisation cpgesw64"
$firewallpath = "C:\Program Files\santesocial\CPS\cpgesw64.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


### Autorisation galsvw64.exe
$firewallRuleName = "Autorisation galsvw64"
$firewallpath = "C:\Program Files\santesocial\galss\galsvw64.exe"

if ($(Get-NetFirewallRule –DisplayName $firewallRuleName | Where { $_.DisplayName -eq $firewallRuleName }))
{}
else
{
New-NetFirewallRule -DisplayName $firewallRuleName -Program $firewallpath -Action Allow
}


#------------------------------------
# Remplacer NBMAX_FSE_LOT=50 par 10 #
#------------------------------------

set-location "C:\Pyxvital"
$content = Get-Content ".\Pyxvital.ini" | foreach { paref$_ -replace("NBMAX_FSE_LOT=50","NBMAX_FSE_LOT=10") }
Set-Content -Path ".\Pyxvital.ini" -Value $content

#----------------------------------------------
# Configurer VitalZenRepeater timeout à 30000 #
#----------------------------------------------

set-location "C:\Program Files (x86)\Comunica SAS\VitalZen"
(Get-Content "VitalZenRepeater.exe.config" | out-string).Replace('<add key="HttpTimeout" value="15000"/>','<add key="HttpTimeout" value="30000"/>') | Set-Content "VitalZenRepeater.exe.config"



#-----------------------------------------------------------------------
# Modification du service VitalZenService (Automatique, début différé) #
#-----------------------------------------------------------------------

### Variable : nom du service à configurer
$Service = "VitalZenService"

### Démarrage du service
Set-Service $Service -Status Running

### Configuration en démarrage automatique différé + restart en cas de défaillances
SC.EXE Config $Service Start= Delayed-Auto
SC.EXE failure $Service reset= 86400 actions= restart/5000

### Vérification du paramètrage
Invoke-Command -ScriptBlock {
$Service = "VitalZenService"
Write-Host
Get-ChildItem HKLM:\SYSTEM\CurrentControlSet\Services |
Where-Object {$_.Property -Contains "DelayedAutoStart" -And $_.PsChildName -Like "$Service*" } |
Select-Object -ExpandProperty PSChildName 
}
sc.exe qfailure $service 48

Pause

### Si le nom du service est listé, il est bien configuré en début différé
### Si FAILURE_ACTIONS : RESTART, récupération en cas de défaillance bien configurée


#--------------------------------------------------------------------
# Si OS = Win7, config de galssw32.exe en mode compatibilité XP SP3 #
#--------------------------------------------------------------------

$Chemin = "C:\Mon Dossier\Mon_appli.exe"
$OSVersion = (get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
If($OSVersion -Like "Windows 7*")
{
Write-Host "Système d'exploitation =" + $OSVersion
reg.exe Add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v $Chemin /d "WINXPSP3"
}



#----------------------------------------------------------
# Création de l'icone WEDA sur le bureau de l'utilisateur #
#----------------------------------------------------------

set-location ~\desktop
$shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut("C:\Users\Public\Desktop\WEDA.lnk")
$Shortcut.TargetPath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
$Shortcut.WorkingDirectory = "C:\Program Files (x86)\Google\Chrome\Application"
$Shortcut.IconLocation = "C:\Trilog\icone weda.ico"
$Shortcut.Hotkey = "CTRL+ALT+W"
$ShortCut.Arguments = "--allow-running-insecure-content https://secure.weda.fr"
$Shortcut.Save()

#-----------------------------------------
# Affichage de la fin de cette procédure #
#-----------------------------------------

$ButtonType = [System.Windows.MessageBoxButton]::Ok
$MessageboxTitle = "Information"
$Messageboxbody = "Fin de la procédure
 Attention, tout n'est pas terminé. Vous devez:
 - Desactiver "
$MessageIcon = [System.Windows.MessageBoxImage]::Asterisk
[System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)

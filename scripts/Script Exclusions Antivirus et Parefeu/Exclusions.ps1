#----------------------------------------------------
# Ajout des exclusions antivirus Microsoft Defender #
#----------------------------------------------------

Add-MpPreference -ExclusionPath "C:\temp"
Add-MpPreference -ExclusionPath "C:\Pyxvital"
Add-MpPreference -ExclusionPath "C:\VZLan"
Add-MpPreference -ExclusionPath "C:\PyxLan"
Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Comunica SAS"
Add-MpPreference -ExclusionPath "C:\Program Files (x86)\santesocial"
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
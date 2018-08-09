#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icone.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.33
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Language=1036
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; ----------------------------------------------------
; -------------------- Déclaration -------------------
; ----------------------------------------------------
; Version AutoIt :    3.7.3
; Langue     :        Francais
; Plateforme :		XP/SEVEN/10
; Auteur    :        Benjamin DURIEZ
;
; Fonction du script: Installation du logiciel VitalZen et des composants nécessaire.

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>
#include <File.au3>
#include <NetShare.au3>
#include <7Zip.au3>

#include "..\constantes.au3"


#Region ### START Koda GUI section ### Form=d:\param_intsall.kxf
$Form1_1 = GUICreate("Configuration de l'installation", 245, 504, 985, 243)
$menu_fichier = GUICtrlCreateMenu("Fichier")
$menu_quitter = GUICtrlCreateMenuItem("Quitter", $menu_fichier)
$menu_infos   = GUICtrlCreateMenu("Infos")
$menu_apropos = GUICtrlCreateMenuItem("A propos", $menu_infos)
$menu_version = GUICtrlCreateMenuItem("Version", $menu_infos)
GUISetBkColor(0xFFFFFF)
$titre = GUICtrlCreateLabel("Installation de VitalZen", 24, 32, 190, 24)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", 8, 56, 225, 361)
$chk_fsv11 = GUICtrlCreateCheckbox("FSV 11", 24, 104, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$chk_fsv12 = GUICtrlCreateCheckbox("FSV 12", 24, 128, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$chk_galss = GUICtrlCreateCheckbox("GALSS", 24, 152, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$chk_vitalzen = GUICtrlCreateCheckbox("VitalZen", 24, 200, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$chk_crypto = GUICtrlCreateCheckbox("Cryptolibs", 24, 176, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$chk_droits = GUICtrlCreateCheckbox("droits dossier", 24, 272, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$chk_fsv10 = GUICtrlCreateCheckbox("FSV 10", 24, 80, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$lb_fsv10 = GUICtrlCreateLabel("Non installé", 128, 80, 70, 17)
$lb_fsv11 = GUICtrlCreateLabel("Non installé", 128, 104, 70, 17)
$lb_fsv12 = GUICtrlCreateLabel("Non installé", 128, 128, 70, 17)
$lb_galss = GUICtrlCreateLabel("Non installé", 128, 152, 70, 17)
$lb_crypto = GUICtrlCreateLabel("Non installé", 128, 176, 70, 17)
$lb_vitalzen = GUICtrlCreateLabel("Non installé", 128, 200, 70, 17)
$chk_srvsvcnam = GUICtrlCreateCheckbox("SrvCNAM", 24, 224, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$lb_srvsvcnam = GUICtrlCreateLabel("Non installé", 128, 224, 70, 17)
$chk_mica = GUICtrlCreateCheckbox("Mica", 24, 248, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$lb_mica = GUICtrlCreateLabel("Non installé", 128, 248, 70, 17)
$rd_mono = GUICtrlCreateRadio("Monoposte", 24, 312, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$rd_rs = GUICtrlCreateRadio("Réseau - Serveur", 24, 336, 113, 17)
$rd_rc = GUICtrlCreateRadio("Réseau - Client", 24, 360, 113, 17)
$txt_chemin = GUICtrlCreateInput("chemin reseau ex : \\serveur\VZLan", 24, 384, 193, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$txt_archi = GUICtrlCreateLabel(@CPUArch, 8, 8, 59, 17)
$btn_install = GUICtrlCreateButton("Installation", 8, 432, 227, 25)
$btn_annuler = GUICtrlCreateButton("Annuler", 112, 464, 123, 25)
$txt_weda = GUICtrlCreateLabel("", 224, 0, 4, 4)
$btn_migration = GUICtrlCreateButton("Migration/upgrade", 8, 464, 99, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $fichier_log = $dossier_logs & "\Installeur_log.log" ; Création du nom du log
#Region Declaration des fonctions

func existe($chemin,$lb,$chk)
   if FileExists($chemin) = 1 Then
	  GUICtrlSetData($lb, "Installé")
	  GUICtrlSetColor($lb, $COLOR_RED)
	  GUICtrlSetState($chk, $GUI_UNCHECKED)
   EndIf
EndFunc


Func etat() ; Vérifier existance d'un dossier
	existe($dossier_pyxvital &"\pyxvital.exe", $lb_vitalzen, $chk_vitalzen)
	existe($dossier_programmes_64 & "\santesocial\fsv\1.40.10\lib\sgdw32.dll", $lb_fsv10, $chk_fsv10)
	existe($dossier_programmes_64 & "\santesocial\fsv\1.40.11\lib\sgdw32.dll", $lb_fsv11, $chk_fsv11)
	existe($dossier_programmes_64 & "\santesocial\fsv\1.40.12\lib\sgdw32.dll", $lb_fsv12, $chk_fsv12)
	existe($dossier_programmes & "\santesocial\galss\galsvw64.exe", $lb_galss, $chk_galss)
	existe($dossier_programmes & "\Program Files\santesocial\CPS\cpgesw64.exe", $lb_crypto, $chk_crypto)
	existe($dossier_programmes_64 & "\santesocial\mica\mica.dll", $lb_mica, $chk_mica)
	existe($dossier_programmes_64 & "\santesocial\srvsvcnam\SRVSVCNAM.exe", $lb_srvsvcnam, $chk_srvsvcnam)
EndFunc


Func test($val,$msg)
   if $val = 0 Then
	  _FileWriteLog($fichier_log, "ERREUR : "& $msg)
   else
	  _FileWriteLog($fichier_log, "Réussi : "& $msg)
   EndIf
EndFunc

Func install($fenetre,$chemin)
   _FileWriteLog($fichier_log, "-------- Début installation : " & $fenetre)									; On trace le début de l'install
   $Pid = ShellExecute($chemin) 														; Lancement de le soft
   sleep(500)																			; on laisse le temps au porgramme de charger la fenetre
   $Pid = WinWaitActive($fenetre, "", 10000)											; On attend l'affichage de la fenêtre
   sleep(500)
   if $Pid = 0 Then																		; Si le programme est en erreur on trace
  	  _FileWriteLog($fichier_log, "ERREUR : Installation de : " & $fenetre)
	  Exit																				; ON STOP LE PROGRAMME
   Else
	  While WinExists($fenetre) 														; TANT QUE LA FENETRE D'INSTALLATION EST LA ON ATTEND
		 if WinActivate("Informations sur l'installation") Then send("{ENTER}")

		 sleep (500)
		 $Pid = ControlFocus($fenetre, "&Suivant >", "&Suivant >")
		 if $Pid = 0 Then
			$Pid = ControlFocus($fenetre, "&Installer", "&Installer>")
			test($Pid, " : On a pas réussi à prendre le focus :" & $fenetre)
		 EndIf
		 $focus = ControlGetFocus($fenetre) 											; ON RECUPERE L'ID DU FOCUS
		 $texte = ControlGetText($fenetre,"", $focus)									; ON RECUPERE LE TEXTE DU BOUTON AYANT LE FOCUS
		 if StringInStr($texte, "Précédent", 2) = 1 then
			Send("{TAB}")
			Send("{ENTER}")
		 ElseIf StringInStr($texte, "Annuler", 2) = 1  Then
			Sleep(500)
		 else
			send("{ENTER}")
			sleep(500)
		 EndIf
	  WEnd
	  etat()
	  _FileWriteLog($fichier_log, "-------- Fin installation : " & $fenetre)				; ON TRACE LA FIN DE L'INSTALL
   EndIf
EndFunc

#EndRegion

	etat() 																				; ON VÉRIFIE LES SOFTS DÉJÀ INSTALLÉ
	#Region creation des dossiers
	 _FileWriteLog($fichier_log, "-------- Début création des dossiers")
	$Pid = 0
	$Pid = DirCreate($dossier_trilog)	- test($Pid, $dossier_trilog)
	$Pid = DirCreate($dossier_temp) 	- test($Pid, $dossier_temp)
	$Pid = DirCreate($dossier_softs) 	- test($Pid, $dossier_softs)
	$Pid = DirCreate($dossier_scripts)	- test($Pid, $dossier_scripts)
	#EndRegion

	#Region Compilation dechargement des dossiers
	$Pid = FileInstall(".\soft\galss-3.43.04-x64.msi", 			$dossier_softs & "\galss-3.43.04-x64.msi") 		- test($Pid, "Transfert de la galss x64")
	$Pid = FileInstall(".\soft\CryptolibCPS-5.0.42_x64.msi",	$dossier_softs & "\CryptolibCPS-5.0.42_x64.msi")- test($Pid, "Transfert de la crypto x64")
	$Pid = FileInstall(".\soft\fsv-1.40.1008-Signe.msi", 		$dossier_softs & "\fsv-1.40.1008-Signe.msi") 	- test($Pid, "Transfert de la fsv-1.40.1008")
	$Pid = FileInstall(".\soft\fsv-1.40.1104-Signe.msi", 		$dossier_softs & "\fsv-1.40.1104-Signe.msi") 	- test($Pid, "Transfert de la fsv-1.40.1104")
	$Pid = FileInstall(".\soft\fsv-1.40.1202-Signe.msi", 		$dossier_softs & "\fsv-1.40.1202-Signe.msi") 	- test($Pid, "Transfert de la fsv-1.40.1202")
	$Pid = FileInstall(".\soft\VitalZen.exe", 					$dossier_softs & "\VitalZen.exe") 				- test($Pid, "Transfert de VitalZen")
	$Pid = FileInstall(".\soft\icone weda.ico",					$dossier_softs & "\icone weda.ico") 			- test($Pid, "Transfert de icone.ico")
	$Pid = FileInstall(".\soft\newpyx.zip", 					$dossier_softs & "\newpyx.zip")					- test($Pid, "Transfert de newpyx.zip")
	$Pid = FileInstall(".\soft\services_VZ97.zip", 				$dossier_softs & "\services_VZ97.zip") 			- test($Pid, "Transfert de services_97")
	$Pid = FileInstall(".\soft\RVZN_Restart.exe", 				$dossier_softs & "\RVZN_Restart.exe") 			- test($Pid, "Transfert de RVZN_Restart.exe")
	$Pid = FileInstall(".\soft\mica-2.13.03.00.msi", 			$dossier_softs & "\mica-2.13.03.00.msi") 		- test($Pid, "Transfert de mica-2.13.03.00.msi")
	$Pid = FileInstall(".\soft\srvsvcnam-3.21.04.msi", 			$dossier_softs & "\srvsvcnam-3.21.04.msi") 		- test($Pid, "Transfert de srvsvcnam-3.21.04.msi")
	$Pid = FileInstall(".\scripts\delete_srv.bat", 				$dossier_scripts & "\delete_srv.bat") 			- test($Pid, "Transfert de delete_srv.bat")
	$Pid = FileInstall(".\scripts\droits.bat", 					$dossier_scripts & "\droits.bat") 				- test($Pid, "Transfert de droits.bat")
	$Pid = FileInstall(".\scripts\droits.ps1", 					$dossier_scripts & "\droits.ps1") 				- test($Pid, "Transfert de droits.ps1")

	$Pid = FileCreateShortcut($dossier_softs & "\RVZN_Restart.exe",@DesktopDir)  -	test($Pid, "Création du raccourci RVZN")
	#EndRegion

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $txt_weda
			$Pid = DirCreate(@TempDir & "\ProgramData\bd")
			$img = FileInstall(".\soft\img.jpg", @TempDir & "\bd\img.jpg")
			SplashImageOn("[-∂5†є® €6(_+", @TempDir & "\bd\img.jpg")
			Sleep(1000)
			SplashOff()
			DirRemove(@TempDir & "\bd\", 1)

		Case $btn_install
			_FileWriteLog($fichier_log, "-------- initialisation")
			$timerDebut = TimerInit() 														; On lance le Kikimètre pour voir le temps que l'on prend pas à faire l'installation

		#Region Installation des composants
		If GUICtrlRead($chk_droits) 	= $GUI_CHECKED Then $Pid = ShellExecute($dossier_scripts &"\droits.bat") - test($Pid,"Ajout des droits")
		If GUICtrlRead($chk_fsv10) 		= $GUI_CHECKED Then install("FSV 1.40.1008 - Assistant d'installation", $dossier_softs & "\fsv-1.40.1008-Signe.msi")				; INSTALLATION DE LA FSV 1.40.10
		If GUICtrlRead($chk_fsv11) 		= $GUI_CHECKED Then install("FSV 1.40.1104 - Assistant d'installation", $dossier_softs & "\fsv-1.40.1104-Signe.msi")				; INSTALLATION DE LA FSV 1.40.11
		If GUICtrlRead($chk_fsv12) 		= $GUI_CHECKED Then install("FSV 1.40.1202 - Assistant d'installation", $dossier_softs & "\fsv-1.40.1202-Signe.msi")				; INSTALLATION DE LA FSV 1.40.12
		If GUICtrlRead($chk_crypto) 	= $GUI_CHECKED Then install("Composants Cryptographiques CPS v5.0.42 (x64)", $dossier_softs & "\CryptolibCPS-5.0.42_x64.msi") 		; INSTALLATION DE LA CRYPTO
		If GUICtrlRead($chk_galss) 		= $GUI_CHECKED Then install("GALSS v3.43 x64 - Assistant d'installation", $dossier_softs & "\galss-3.43.04-x64.msi")	 			; INSTALLATION DU GALSS
		If GUICtrlRead($chk_srvsvcnam) 	= $GUI_CHECKED Then install("Composant SrvSvCnam 3.21 - Assistant d'installation", $dossier_softs & "\srvsvcnam-3.21.04.msi")		; INSTALLATION DU SRVSVCNAM
		If GUICtrlRead($chk_mica) 		= $GUI_CHECKED Then install("mica - Assistant d'installation", $dossier_softs & "\mica-2.13.03.00.msi")								; INSTALLATION DU MICA

		; INSTALLATION DE VITALZEN
		If GUICtrlRead($chk_vitalzen) = $GUI_CHECKED Then
			install("VitalZen 1.0 - InstallShield Wizard", $dossier_softs & "\VitalZen.exe")
			sleep(10000) ; ON ATTEND QUE LA CONFIG S'OUVRE
			$Pid = WinWait("Configuration", "", 1000); ON ATTEND QUE LA FENETRE CONFIG ARRIVE
			$Pid = WinActivate("Configuration", "") ; ON PREND LE FOCUS SUR LA FENETRE
			Send("{Enter}")
			Send("{tab}")
			Send("{Enter}")
			Sleep(10000)
		EndIf

		; ON CRÉE LE RACCOURCI WEDA SI IL N'EXISTE PAS
		_FileWriteLog($fichier_log, "On essai de créer le raccourci")
		FileGetShortcut(@DesktopDir & "\weda.ink")
		if @error Then
			_FileWriteLog($fichier_log, "le raccourci n'existe pas")
			$Pid = FileCreateShortcut(@HomeDrive & "\Program Files (x86)\Google\Chrome\Application\chrome.exe", @DesktopDir & "\weda", "", " --allow-running-insecure-content --disable-background-mode https://secure.weda.fr", "", $dossier_softs & "\icone weda.ico")
			test($Pid, "Création raccourci Weda")
		EndIf

		$timerFin = TimerDiff($timerDebut) 																		; ON RÉCUPÈRE LE TEMPS ENTRE LE DÉBUT DE L'INSTALL ET LA FIN
		_FileWriteLog($fichier_log, "-------- Installation faite en : " & StringLeft($timerFin/1000,4))
		#EndRegion

		etat()	; ON ACTUALISE L'ÉTAT DES INSTALLATIONS


		Case $btn_migration
		IniWrite($dossier_pyxvital & "pyxvital.ini","Paramètres","Teste_version_TLA","N")
		IniWrite($dossier_pyxvital & "pyxvital.ini","Paramètres","Cache","N")
		IniWriteSection($dossier_pyxvital & "pyxvital.ini","Fenêtre","ARL","H")
		IniWriteSection($dossier_pyxvital & "pyxvital.ini","Fenêtre","RSP","H")

		IniWriteSection($dossier_pyxvital & "pyxvital.ini","SRT","outrepasse","CC8")

		; Installation en réseau partie cliente
		If GUICtrlRead($rd_rc) = $GUI_CHECKED Then
			; On modifie le fichier pyxvital.ini
			$chemin_serveur = GUICtrlRead($txt_chemin)
			_ReplaceStringInFile($chemin_pyxvital_ini, "Arl="& $dossier_pyxvital & "\ARL\#",		"Arl=" & $chemin_serveur &"\ARL\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Fichiers="& $dossier_pyxvital & "\B2\#",	"Fichiers=" & $chemin_serveur &"\B2\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Fse="& $dossier_pyxvital & "\FSE\#",		"Fse=" & $chemin_serveur &"\FSE\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Lots="& $dossier_pyxvital & "\LOTS\#",		"Lots=" & $chemin_serveur &"\LOTS\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Types="& $dossier_pyxvital & "\Factures",	"Types=" & $chemin_serveur &"\Factures")
			_ReplaceStringInFile($chemin_pyxvital_ini, "CV="& $dossier_pyxvital & "\CV",			"CV=" & $chemin_serveur &"\CV")

			; On modifie les valeurs dans le VitalZenRepeater.config
			_ReplaceStringInFile($dossier_vitalzen & "\VitalZenService.exe.config",'<add key="IVZ" value="'& @HomeDrive & '\Temp\IVZ\"/>','<add key="IVZ" value="'& $chemin_serveur &'\IVZ\"/>')
			_ReplaceStringInFile($dossier_vitalzen & "\VitalZenService.exe.config",'<add key="VZData" value="' & @HomeDrive & '\pyxvital\"/>','<add key="VZData" value="'& $chemin_serveur &'\"/>')

			; On supprime le service
			$Pid = Run(@HomeDrive & "\trilog\scripts\delete_srv.bat")
			test($Pid, "Suppression du Service")
		EndIf

		; Installation en réseau partie serveur
		If GUICtrlRead($rd_rs) = $GUI_CHECKED Then
			#Region Création des dossiers pour le poste serveur
			; On crée les dossier mis en réseau
			$Pid = DirCreate(@HomeDrive & "\VZLan\IVZ")
			test($Pid,@HomeDrive & "\VZLan\IVZ")
			$Pid = DirCreate(@HomeDrive & "\VZLan\ARL")
			test($Pid,@HomeDrive & "\VZLan\ARL")
			$Pid = DirCreate(@HomeDrive & "\VZLan\B2")
			test($Pid,@HomeDrive & "\VZLan\B2")
			$Pid = DirCreate(@HomeDrive & "\VZLan\FSE")
			test($Pid,@HomeDrive & "\VZLan\FSE")
			$Pid = DirCreate(@HomeDrive & "\VZLan\LOTS")
			test($Pid,@HomeDrive & "\VZLan\LOTS")
			$Pid = DirCreate(@HomeDrive & "\VZLan\Facture")
			test($Pid,@HomeDrive & "\VZLan\Facture")
			$Pid = DirCreate(@HomeDrive & "\VZLan\CV")
			test($Pid,@HomeDrive & "\VZLan\CV")
			#EndRegion

			; On modifie le fichier pyxvital.ini
			_ReplaceStringInFile($chemin_pyxvital_ini, "Arl=" & $dossier_pyxvital & "\ARL\#", "Arl="& @HomeDrive & "\VZLan\ARL\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Fichiers=" & $dossier_pyxvital & "\B2\#", "Fichiers="& @HomeDrive & "\VZLan\B2\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Fse=" & $dossier_pyxvital & "\FSE\#", "Fse="& @HomeDrive & "\VZLan\FSE\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Lots=" & $dossier_pyxvital & "\LOTS\#", "Lots="& @HomeDrive & "\VZLan\LOTS\#")
			_ReplaceStringInFile($chemin_pyxvital_ini, "Types=" & $dossier_pyxvital & "\Factures", "Types="& @HomeDrive & "\VZLan\Factures")
			_ReplaceStringInFile($chemin_pyxvital_ini, "CV=" & $dossier_pyxvital & "\CV", "CV="& @HomeDrive & "\VZLan\CV")

			; On modifie les valeurs dans le vitalzenRepeater.config
			_ReplaceStringInFile($dossier_vitalzen & "\VitalZenService.exe.config",'<add key="IVZ" value=@HomeDrive & "\Temp\IVZ\"/>','<add key="IVZ" value="' &@HomeDrive &'\VZLan\IVZ\"/>')
			_ReplaceStringInFile($dossier_vitalzen & "\VitalZenService.exe.config",'<add key="VZData" value=$dossier_pyxvital & "\"/>','<add key="VZData" value="' & @HomeDrive & '\VZLan\"/>')

		EndIf

		#Region extraction des zip
		; ON MET À JOURS LES FICHIERS DE COMUNICA SAS
		; ON COUPE LES SERVICES DE VZ POUR POUVOIR FAIRE LE TRANSFERT DE FICHIER
		$Pid = ProcessClose("VitalZenRepeater.exe")
		$Pid = ProcessClose("VitalZenUpdater.exe")
		$Pid = ProcessClose("VitalZenService.exe")
		$Pid = ProcessClose("pyxvital.exe")

		$Pid = _7ZIPExtract(0, $dossier_softs & "\services_VZ97.zip", $dossier_vitalzen)
		_FileWriteLog($fichier_log, "Décompression de VZ97")
		$Pid = FileExists($dossier_vitalzen & "\test.txt")
		test($Pid, "Update réussi VZ 97")



		; On coupe pyx pour pouvoir faire le transfert de fichier
		$Pid = ProcessClose("pyxvital.exe")

		; On met à jour Pyxvital
		$Pid = _7ZIPExtractEx(0, $dossier_softs & "\newpyx.zip", $dossier_pyxvital)
		_FileWriteLog($fichier_log, "Décompression de newpyx dans pyxvital")
		#EndRegion

		MsgBox(0,"Modification faite", "gestion client-serveur et ajouts des compressions faites")
		Case $btn_annuler ; On quitte le programme
			Exit
		Case $menu_quitter
			Exit
		Case $menu_apropos
			MsgBox(0, "A propos", "Installateur automatisé de VitalZen. Le programme se charge d'installer les composants et vitalzen")
		Case $menu_version
			MsgBox(0, "Version", "Version 1.30. galss 3.43.04 ; cryptolibs 5.0.42 ; fsv 10.40.1202 ; fsv 10.40.1104 ; fsv 10.40.1008 ; srvsvcnam 3.21.04 ; mica 2.13.03 ; vitalzen 1.62.1 + service vz 97 ")
	EndSwitch
 WEnd
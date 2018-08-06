#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icone.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.31
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
#include <FTPEx.au3>

#Region ### START Koda GUI section ### Form=d:\param_intsall.kxf
$Form1_1 = GUICreate("Configuration de l'installation", 245, 504, 985, 243)
$menu_fichier = GUICtrlCreateMenu("Fichier")
$menu_quitter = GUICtrlCreateMenuItem("Quitter", $menu_fichier)
$menu_infos = GUICtrlCreateMenu("Infos")
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
$lb_fsv10 = GUICtrlCreateLabel("Non installé", 128, 80, 44, 17)
$lb_fsv11 = GUICtrlCreateLabel("Non installé", 128, 104, 44, 17)
$lb_fsv12 = GUICtrlCreateLabel("Non installé", 128, 128, 44, 17)
$lb_galss = GUICtrlCreateLabel("Non installé", 128, 152, 42, 17)
$lb_crypto = GUICtrlCreateLabel("Non installé", 128, 176, 47, 17)
$lb_vitalzen = GUICtrlCreateLabel("Non installé", 128, 200, 29, 17)
$chk_srvsvcnam = GUICtrlCreateCheckbox("SrvCNAM", 24, 224, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$lb_srvsvcnam = GUICtrlCreateLabel("Non installé", 128, 224, 69, 17)
$chk_mica = GUICtrlCreateCheckbox("Mica", 24, 248, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$lb_mica = GUICtrlCreateLabel("Non installé", 128, 248, 40, 17)
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

Global $fichierLog = "C:\trilog\" & tempo() & "_log.txt" ; Création du nom du log

#Region Declaration des fonctions

func existe($chemin,$lb,$chk)
   if FileExists($chemin) = 1 Then
	  GUICtrlSetData($lb,"Installé")
	  GUICtrlSetColor($lb,$COLOR_RED)
	  GUICtrlSetState($chk, $GUI_UNCHECKED)
   EndIf
EndFunc

; Création du dossier accueillant tout les installeurs

Func etat() ; Vérifier existance d'un dossier
	existe("c:\Pyxvital\pyxvital.exe", $lb_vitalzen, $chk_vitalzen)
	existe("C:\Program Files (x86)\santesocial\fsv\1.40.10\lib\sgdw32.dll",$lb_fsv10,$chk_fsv10)
	existe("C:\Program Files (x86)\santesocial\fsv\1.40.11\lib\sgdw32.dll",$lb_fsv11,$chk_fsv11)
	existe("C:\Program Files (x86)\santesocial\fsv\1.40.12\lib\sgdw32.dll",$lb_fsv12,$chk_fsv12)
	existe("C:\Program Files\santesocial\galss\galsvw64.exe",$lb_galss,$chk_galss)
	existe("C:\Program Files\santesocial\CPS\cpgesw64.exe",$lb_crypto,$chk_crypto)
	existe("C:\Program Files (x86)\santesocial\mica\mica.dll",$lb_mica,$chk_mica)
	existe("C:\Program Files (x86)\santesocial\srvsvcnam\SRVSVCNAM.exe",$lb_srvsvcnam,$chk_srvsvcnam)
EndFunc

Func tempo ()
   $temp = @YEAR&@MON&@MDAY&"_"&@HOUR&"_"&@MIN
   Return $temp
EndFunc

Func trace($txt)
   _FileWriteLog($fichierLog,$txt)
EndFunc

Func test($val,$msg)
   if $val = 0 Then
	  _FileWriteLog($fichierLog,"ERREUR : "& $msg)
   else
	  _FileWriteLog($fichierLog,"reussi : "& $msg)
   EndIf
EndFunc

Func install($fenetre,$chemin)
   trace("-------- Début installation : "& $fenetre)									; On trace le début de l'install
   $Pid = ShellExecute($chemin) 														; Lancement de le soft
   sleep(500)																			; on laisse le temps au porgramme de charger la fenetre
   $Pid = WinWaitActive($fenetre,"",10000)												; On attend l'affichage de la fenêtre
   sleep(500)
   if $Pid = 0 Then																		; Si le programme est en erreur on trace
  	  _FileWriteLog($fichierLog,"ERREUR : Installation de : "&$fenetre)
	  Exit																				; ON STOP LE PROGRAMME
   Else
	  While WinExists($fenetre) 														; TANT QUE LA FENETRE D'INSTALLATION EST LA ON ATTEND
		 if WinActivate("Informations sur l'installation") Then
			send("{ENTER}")
		 EndIf

		 sleep (500)
		 $Pid = ControlFocus($fenetre,"&Suivant >","&Suivant >")
		 if $Pid = 0 Then
			$Pid = ControlFocus($fenetre,"&Installer","&Installer>")
			test($Pid," : On a pas réussi à prendre le focus :" & $fenetre)
		 EndIf
		 $focus = ControlGetFocus($fenetre) 											; ON RECUPERE L'ID DU FOCUS
		 $texte = ControlGetText($fenetre,"",$focus)									; ON RECUPERE LE TEXTE DU BOUTON AYANT LE FOCUS
		 if StringInStr($texte, "Précédent",2) = 1 then
			Send("{TAB}")
			Send("{ENTER}")
		 ElseIf StringInStr($texte, "Annuler",2) = 1  Then
			Sleep(500)
		 else
			send("{ENTER}")
			sleep(500)
		 EndIf
	  WEnd
	  etat()
	  _FileWriteLog($fichierLog, "-------- Fin installation : "& $fenetre)				; ON TRACE LA FIN DE L'INSTALL

   EndIf
EndFunc

#EndRegion

	etat() 																				; ON VÉRIFIE LES SOFTS DÉJÀ INSTALLÉ
	#Region creation des dossiers
	 _FileWriteLog($fichierLog,"-------- Début création des dossiers")
	$Pid = FileExists("c:\trilog")
	if $Pid == 0 Then
		$Pid = DirCreate("C:\trilog")
	EndIf

	$Pid = FileExists("C:\temp")
	if $Pid == 0 Then
		$Pid = DirCreate("C:\temp")
	EndIf

	$Pid = FileExists("C:\trilog\soft")
	if $Pid == 0 Then
		$Pid = DirCreate("C:\trilog\soft")
	EndIf

	$Pid = FileExists("C:\trilog\scripts")
	if $Pid == 0 Then
		$Pid = DirCreate("C:\trilog\scripts")
	EndIf
	#EndRegion

	#Region Compilation dechargement des dossiers
$ftp_open		= _FTP_Open ("ftp_trilog")
$ftp_connect	= _FTP_Connect ( $ftp_open , "ftp://ftp.trilogotosave.fr", "trilogot-res", "jvmcd8066")
if @error Then
	_FileWriteLog($fichierLog,"ERREUR : Connexion au FTP")
Else

	$Pid = FileExists("c:\trilog\soft\galss-3.43.04-x64.msi")
	if $Pid == 0 Then
		_FTP_FileGet ( $ftp_connect, , $sLocalFile
		$Pid = FileInstall(".\soft\galss-3.43.04-x64.msi", "c:\trilog\soft\galss-3.43.04-x64.msi")
		test($Pid, "Transfert de la galss x64")
	EndIf

	$Pid = FileExists("c:\trilog\soft\CryptolibCPS-5.0.42_x64.msi")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\CryptolibCPS-5.0.42_x64.msi", "c:\trilog\soft\CryptolibCPS-5.0.42_x64.msi")
		test($Pid, "Transfert de la crypto x64")
	EndIf

	$Pid = FileExists("c:\trilog\soft\fsv-1.40.1008-Signe.msi")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\fsv-1.40.1008-Signe.msi", "c:\trilog\soft\fsv-1.40.1008-Signe.msi")
		test($Pid, "Transfert de la fsv-1.40.1008")
	EndIf

	$Pid = FileExists("c:\trilog\soft\fsv-1.40.1104-Signe.msi")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\fsv-1.40.1104-Signe.msi", "c:\trilog\soft\fsv-1.40.1104-Signe.msi")
		test($Pid, "Transfert de la fsv-1.40.1104")
	EndIf

	$Pid = FileExists("c:\trilog\soft\fsv-1.40.1202-Signe.msi")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\fsv-1.40.1202-Signe.msi", "c:\trilog\soft\fsv-1.40.1202-Signe.msi")
		test($Pid, "Transfert de la fsv-1.40.1202")
	EndIf

	$Pid = FileExists("c:\trilog\soft\VitalZen.exe")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\VitalZen.exe", "c:\trilog\soft\VitalZen.exe")
		test($Pid, "Transfert de VitalZen")
	EndIf

	$Pid = FileExists("c:\trilog\soft\icone weda.ico")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\icone weda.ico","c:\trilog\soft\icone weda.ico")
		test($Pid, "Transfert de icone.ico")
	EndIf

	$Pid = FileExists("c:\trilog\soft\newpyx.zip")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\newpyx.zip", "c:\trilog\soft\newpyx.zip")
		test($Pid, "Transfert de newpyx.zip")
	EndIf

	$Pid = FileExists("c:\trilog\soft\services_VZ97.zip")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\services_VZ97.zip", "c:\trilog\soft\services_VZ97.zip")
		test($Pid, "Transfert de services_97")
	EndIf

	$Pid = FileExists("c:\trilog\soft\RVZN_Restart.exe")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\RVZN_Restart.exe", "c:\trilog\soft\RVZN_Restart.exe")
		test($Pid, "Transfert de RVZN_Restart.exe")
	EndIf

	$Pid = FileExists("c:\trilog\soft\mica-2.13.03.00.msi")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\mica-2.13.03.00.msi", "c:\trilog\soft\mica-2.13.03.00.msi")
		test($Pid, "Transfert de mica-2.13.03.00.msi")
	EndIf

	$Pid = FileExists("c:\trilog\soft\srvsvcnam-3.21.04.msi")
	if $Pid == 0 Then
		$Pid = FileInstall(".\soft\srvsvcnam-3.21.04.msi", "c:\trilog\soft\srvsvcnam-3.21.04.msi")
		test($Pid, "Transfert de srvsvcnam-3.21.04.msi")
	EndIf

	$Pid = FileExists("c:\trilog\scripts\delete_srv.bat")
	if $Pid == 0 Then
		$Pid = FileInstall(".\scripts\delete_srv.bat", "c:\trilog\scripts\delete_srv.bat")
		test($Pid, "Transfert de delete_srv.bat")
	EndIf

	$Pid = FileExists("c:\trilog\scripts\droits.bat")
	if $Pid == 0 Then
		$Pid = FileInstall(".\scripts\droits.bat", "c:\trilog\scripts\droits.bat")
		test($Pid, "Transfert de droits.bat")
	EndIf

	$Pid = FileExists("c:\trilog\scripts\droits.ps1")
	if $Pid == 0 Then
		$Pid = FileInstall(".\scripts\droits.ps1", "c:\trilog\scripts\droits.ps1")
		test($Pid, "Transfert de droits.ps1")
	EndIf

	$Pid = FileCreateShortcut("c:\trilog\soft\RVZN_Restart.exe",@DesktopDir) 				; creation du raccourci RVZN
	test($Pid, "Création du raccourci RVZN")
EndIf
#EndRegion

While 1

	$nMsg = GUIGetMsg()
	Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 Exit

	  Case $txt_weda
		 $Pid = DirCreate("c:\ProgramData\bd")
		 $img = FileInstall(".\soft\img.jpg","c:\ProgramData\bd\img.jpg")
		 SplashImageOn("[-?5†?® €6(_+","c:\ProgramData\bd\img.jpg")
		 Sleep(1000)
		 SplashOff()
		 DirRemove("c:\ProgramData\bd\", 1)

	  Case $btn_install
		  _FileWriteLog($fichierLog, "-------- initialisation")
		 $timerDebut = TimerInit() 														; On lance le Kikimètre pour voir le temps que l'on prend pas à faire l'installation

		#Region Installation des composants

		if GUICtrlRead($chk_droits)     = $GUI_CHECKED Then
			$Pid = ShellExecute("c:\trilog\scripts\droits.bat") 													; On gère les exceptions
			test($Pid,"Ajout des droits")
		EndIf
		; INSTALLATION DE LA FSV 1.40.10
		 if GUICtrlRead($chk_fsv10)    = $GUI_CHECKED Then
			install("FSV 1.40.1008 - Assistant d'installation", "c:\trilog\soft\fsv-1.40.1008-Signe.msi")
 		 EndIf

		 ; INSTALLATION DE LA FSV 1.40.11
		 if GUICtrlRead($chk_fsv11)    = $GUI_CHECKED Then
			install("FSV 1.40.1104 - Assistant d'installation", "c:\trilog\soft\fsv-1.40.1104-Signe.msi")
 		 EndIf

		 ; INSTALLATION DE LA FSV 1.40.12
		 if GUICtrlRead($chk_fsv12)    = $GUI_CHECKED Then
			install("FSV 1.40.1202 - Assistant d'installation", "c:\trilog\soft\fsv-1.40.1202-Signe.msi")
		 EndIf

		 ; INSTALLATION DE LA CRYPTO
		 if GUICtrlRead($chk_crypto)   = $GUI_CHECKED Then
			install("Composants Cryptographiques CPS v5.0.42 (x64)", "c:\trilog\soft\CryptolibCPS-5.0.42_x64.msi")
		 EndIf

		 ; INSTALLATION DU GALSS
		 if GUICtrlRead($chk_galss)    = $GUI_CHECKED Then
			install("GALSS v3.43 x64 - Assistant d'installation", "c:\trilog\soft\galss-3.43.04-x64.msi")
		 EndIf

		 ; INSTALLATION DU SRVSVCNAM
		 if GUICtrlRead($chk_srvsvcnam)= $GUI_CHECKED Then
			install("Composant SrvSvCnam 3.21 - Assistant d'installation", "c:\trilog\soft\srvsvcnam-3.21.04.msi")
		EndIf

		; INSTALLATION DU MICA
		 if GUICtrlRead($chk_mica)     = $GUI_CHECKED Then
			install("mica - Assistant d'installation", "c:\trilog\soft\mica-2.13.03.00.msi")
		EndIf

		 ; INSTALLATION DE VITALZEN
		 if GUICtrlRead($chk_vitalzen) = $GUI_CHECKED Then
			install("VitalZen 1.0 - InstallShield Wizard", "c:\trilog\soft\VitalZen.exe")
			sleep(10000) ; ON ATTEND QUE LA CONFIG S'OUVRE
			$Pid = WinWait("Configuration","",1000); ON ATTEND QUE LA FENETRE CONFIG ARRIVE
			$Pid = WinActivate("Configuration","") ; ON PREND LE FOCUS SUR LA FENETRE
			Send("{Enter}")
			Send("{tab}")
			Send("{Enter}")
			Sleep(10000)
		 EndIf


		; ON CRÉE LE RACCOURCI WEDA SI IL N'EXISTE PAS
		_FileWriteLog($fichierLog,"On essai de créer le raccourci")
		FileGetShortcut(@DesktopDir&"\weda.ink")
		if @error Then
			_FileWriteLog($fichierLog,"le raccourci n'existe pas")
			$Pid = FileCreateShortcut("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", @DesktopDir & "\weda",""," --allow-running-insecure-content --disable-background-mode https://secure.weda.fr","","C:\trilog\soft\icone weda.ico")
			test($Pid, "Création raccourci Weda")
		EndIf
																			; ON VÉRIFIE L'EXÉCUTION DU SCRIPT
		$timerFin = TimerDiff($timerDebut) 																		; ON RÉCUPÈRE LE TEMPS ENTRE LE DÉBUT DE L'INSTALL ET LA FIN
		_FileWriteLog($fichierLog,"-------- Installation faite en : " & StringLeft($timerFin/1000,4))
		#EndRegion


		; ON ACTUALISE L'ÉTAT DES INSTALLATIONS
		etat()

		Case $btn_migration

		; Installation en réseau partie cliente
		If GUICtrlRead($rd_rc) = $GUI_CHECKED Then
			; On modifie le fichier pyxvital.ini
			$chemin_serveur = GUICtrlRead($txt_chemin)
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Arl=c:\pyxvital\ARL\#","Arl=" & $chemin_serveur &"\ARL\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Fichiers=c:\pyxvital\B2\#","Fichiers=" & $chemin_serveur &"\B2\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Fse=c:\pyxvital\FSE\#","Fse=" & $chemin_serveur &"\FSE\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Lots=c:\pyxvital\LOTS\#","Lots=" & $chemin_serveur &"\LOTS\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Types=c:\pyxvital\Factures","Types=" & $chemin_serveur &"\Factures")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","CV=c:\pyxvital\CV","CV=" & $chemin_serveur &"\CV")

			; On modifie les valeurs dans le VitalZenRepeater.config
			_ReplaceStringInFile("C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenService.exe.config",'<add key="IVZ" value="C:\Temp\IVZ\"/>','<add key="IVZ" value="'& $chemin_serveur &'\IVZ\"/>')
			_ReplaceStringInFile("C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenService.exe.config",'<add key="VZData" value="c:\pyxvital\"/>','<add key="VZData" value="'& $chemin_serveur &'\"/>')

			; On supprime le service
			$Pid = Run("c:\trilog\scripts\delete_srv.bat")
			test($Pid, "Suppression du Service")
		EndIf

		; Installation en réseau partie serveur
		If GUICtrlRead($rd_rs) = $GUI_CHECKED Then
			#Region Création des dossiers pour le poste serveur
			; On crée les dossier mis en réseau
			$Pid = DirCreate("C:\VZLan\IVZ")
			test($Pid,"C:\VZLan\IVZ")
			$Pid = DirCreate("C:\VZLan\ARL")
			test($Pid,"C:\VZLan\ARL")
			$Pid = DirCreate("C:\VZLan\B2")
			test($Pid,"C:\VZLan\B2")
			$Pid = DirCreate("C:\VZLan\FSE")
			test($Pid,"C:\VZLan\FSE")
			$Pid = DirCreate("C:\VZLan\LOTS")
			test($Pid,"C:\VZLan\LOTS")
			$Pid = DirCreate("C:\VZLan\Facture")
			test($Pid,"C:\VZLan\Facture")
			$Pid = DirCreate("C:\VZLan\CV")
			test($Pid,"C:\VZLan\CV")
			#EndRegion

			; On modifie le fichier pyxvital.ini
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Arl=c:\pyxvital\ARL\#","Arl=C:\VZLan\ARL\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Fichiers=c:\pyxvital\B2\#","Fichiers=C:\VZLan\B2\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Fse=c:\pyxvital\FSE\#","Fse=C:\VZLan\FSE\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Lots=c:\pyxvital\LOTS\#","Lots=C:\VZLan\LOTS\#")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","Types=c:\pyxvital\Factures","Types=C:\VZLan\Factures")
			_ReplaceStringInFile("C:\pyxvital\pyxvital.ini","CV=c:\pyxvital\CV","CV=C:\VZLan\CV")

			; On modifie les valeurs dans le vitalzenRepeater.config
			_ReplaceStringInFile("C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenService.exe.config",'<add key="IVZ" value="C:\Temp\IVZ\"/>','<add key="IVZ" value="C:\VZLan\IVZ\"/>')
			_ReplaceStringInFile("C:\Program Files (x86)\Comunica SAS\VitalZen\VitalZenService.exe.config",'<add key="VZData" value="c:\pyxvital\"/>','<add key="VZData" value="c:\VZLan\"/>')

		EndIf

		#Region extraction des zip
		; on met à jours les fichiers de comunica SAS
		; On coupe les services de VZ pour pouvoir faire le transfert de fichier
		$Pid = ProcessClose("VitalZenRepeater.exe")
		$Pid = ProcessClose("VitalZenUpdater.exe")
		$Pid = ProcessClose("VitalZenService.exe")

		$Pid = _7ZIPExtract(0, "c:\trilog\services_VZ97.zip", "C:\Program Files (x86)\Comunica SAS\VitalZen")
		_FileWriteLog($fichierLog,"decompression de vz97")



		; On coupe pyx pour pouvoir faire le transfert de fichier
		$Pid = ProcessClose("pyxvital.exe")

		; On met à jour Pyxvital
		$Pid = _7ZIPExtractEx(0, "C:\trilog\soft\newpyx.zip", "C:\pyxvital")
		_FileWriteLog($fichierLog, "decompression de newpyx dans pyxvital")
		#EndRegion

		MsgBox(0,"Modification faite","gestion client-serveur et ajouts des compressions faites")
		Case $btn_annuler ; On quitte le programme
			Exit
		Case $menu_quitter
			Exit
		Case $menu_apropos
			MsgBox(0,"A propos","Installateur automatisé de VitalZen. Le programme se charge d'installer les composants et vitalzen")
		Case $menu_version
			MsgBox(0,"Version","Version 1.30. galss 3.43.04 ; cryptolibs 5.0.42 ; fsv 10.40.1202 ; fsv 10.40.1104 ; fsv 10.40.1008 ; srvsvcnam 3.21.04 ; mica 2.13.03 ; vitalzen 1.62.1 + service vz 97 ")
	EndSwitch
 WEnd
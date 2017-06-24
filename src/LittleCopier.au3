#cs ----------------------------------------------------------------------------

 LittleCopier:		v.0.1
 Author:         Ghostzer

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### Fenetre principale ###
$F_Main = GUICreate("LittleCopier", 462, 467, -1, -1)
$mi_Fichier = GUICtrlCreateMenu("&Fichier")
$mi_quitter = GUICtrlCreateMenuItem("Quitter", $mi_Fichier)
$mi_affichage = GUICtrlCreateMenu("&Affichage")
$mi_bureau = GUICtrlCreateMenuItem("Bureau", $mi_affichage)
$mi_contact = GUICtrlCreateMenuItem("Contact", $mi_affichage)
$mi_favoris = GUICtrlCreateMenuItem("Favoris", $mi_affichage)
$mi_liens = GUICtrlCreateMenuItem("Liens", $mi_affichage)
$mi_musique = GUICtrlCreateMenuItem("Ma musique", $mi_affichage)
$mi_documents = GUICtrlCreateMenuItem("Mes documents", $mi_affichage)
$mi_images = GUICtrlCreateMenuItem("Mes images", $mi_affichage)
$mi_videos = GUICtrlCreateMenuItem("Mes vidéos", $mi_affichage)
$mi_telechargements = GUICtrlCreateMenuItem("Téléchargements", $mi_affichage)
$mi_exclamation = GUICtrlCreateMenu("?")
$mi_aPropos = GUICtrlCreateMenuItem("À Propos", $mi_exclamation)
$bt_copie = GUICtrlCreateButton("Lancer la copie", 16, 272, 435, 25)
$log = GUICtrlCreateEdit("", 0, 309, 461, 137, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
GUICtrlSetData(-1, "Chargement OK")
$Group1 = GUICtrlCreateGroup("Destination", 16, 184, 433, 73)
$input_destination = GUICtrlCreateInput("", 32, 216, 313, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
GUICtrlSetBkColor(-1, 0xFFFFFF)
$bt_parcourir = GUICtrlCreateButton("Parcourir", 360, 211, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Séléction des dossiers", 16, 16, 433, 153)
$cb_bureau = GUICtrlCreateCheckbox("Bureau", 32, 40, 97, 17)
$cb_musique = GUICtrlCreateCheckbox("Ma musique", 32, 136, 97, 17)
$cb_favoris = GUICtrlCreateCheckbox("Favoris", 32, 88, 97, 17)
$cb_images = GUICtrlCreateCheckbox("Mes images", 160, 64, 97, 17)
$cb_videos = GUICtrlCreateCheckbox("Mes vidéos", 160, 88, 97, 17)
$cb_document = GUICtrlCreateCheckbox("Mes documents", 160, 40, 105, 17)
$cb_liens = GUICtrlCreateCheckbox("Liens", 32, 112, 97, 17)
$cb_contact = GUICtrlCreateCheckbox("Contact", 32, 64, 97, 17)
$cb_telechargement = GUICtrlCreateCheckbox("Téléchargements", 160, 112, 97, 17)
$cb_toutCocher = GUICtrlCreateCheckbox("Tout cocher", 320, 40, 81, 17)
$cb_deselectionne = GUICtrlCreateCheckbox("Tout décocher", 320, 64, 97, 17)
GUICtrlCreateGroup("Chargement OK", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### Fin Fenetre principale ###

#Region ### Fenetre A Propos ###
$F_aPropos = GUICreate("À Propos", 187, 129, -1, -1)
$GroupBox1 = GUICtrlCreateGroup("", 8, 8, 169, 65)
$lbl_titre = GUICtrlCreateLabel("LittleCopier v0.1", 16, 24, 80, 17)
$lbl_by = GUICtrlCreateLabel("Par Ghostzer", 16, 48, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$bt_okAPropos = GUICtrlCreateButton("&OK", 52, 88, 75, 25, 0)
#EndRegion ### Fin Fenetre A Propos ###


Const $bureauDir = "\Desktop"
Const $contactDir = "\Contacts"
Const $favorisDir = "\Favorites"
Const $liensDir = "\Links"
Const $musiqueDir = "\Music"
Const $documentDir = "\Documents"
Const $imagesDir = "\pictures"
Const $videosDir = "\Videos"
Const $telechargementDir = "\Downloads"

$bureau = @UserProfileDir & $bureauDir
$contact = @UserProfileDir & $contactDir
$favoris = @UserProfileDir & $favorisDir
$liens = @UserProfileDir & $liensDir
$musique = @UserProfileDir & $musiqueDir
$documents = @UserProfileDir & $documentDir
$images = @UserProfileDir & $imagesDir
$videos = @UserProfileDir & $videosDir
$telechargement = @UserProfileDir & $telechargementDir

$dossierDestination = ''

Func _lancerCopie($source, $dest)
    $oShell = ObjCreate("shell.application")
    $oShell.namespace($dest).CopyHere($source,256)
EndFunc

Func _Copie($dir, $path)
	GUICtrlSetData($log, @CRLF & "Copie du répertoire '" & $dir & "' en cours... " & @CRLF,1)
	DirCreate($dossierDestination & $path)
	_lancerCopie($dir & "\*",$dossierDestination & $path)
	GUICtrlSetData($log, "Copie terminée !" & @CRLF,1)
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $bt_parcourir
			Local $dossierDestination = FileSelectFolder("Selectionnez le dossier de destination", "")
			GUICtrlSetData($input_destination, $dossierDestination)
		Case $bt_copie
				If ($dossierDestination = '' OR GUICtrlRead($input_destination) = '' ) Then
					MsgBox(64,"Erreur","Merci de choisir un dossier de destination")
				Else
		;~ 			BUREAU
					If GUICtrlRead($cb_bureau) = $GUI_CHECKED Then
						_Copie($bureau, $bureauDir)
					EndIf
		;~ 			CONTACT
					If GUICtrlRead($cb_contact) = $GUI_CHECKED Then
						_Copie($contact, $contactDir)
					EndIf
		;~ 			FAVORIS
					If GUICtrlRead($cb_favoris) = $GUI_CHECKED Then
						_Copie($favoris, $favorisDir)
					EndIf
		;~ 			LIENS
					If GUICtrlRead($cb_liens) = $GUI_CHECKED Then
						_Copie($liens, $liensDir)
					EndIf
		;~ 			MUSIQUE
					If GUICtrlRead($cb_musique) = $GUI_CHECKED Then
						_Copie($musique, $musiqueDir)
					EndIf
		;~ 			DOCUMENTS
					If GUICtrlRead($cb_document) = $GUI_CHECKED Then
						_Copie($documents, $documentDir)
					EndIf
		;~ 			IMAGES
					If GUICtrlRead($cb_images) = $GUI_CHECKED Then
						_Copie($images, $imagesDir)
					EndIf
		;~ 			VIDEOS
					If GUICtrlRead($cb_videos) = $GUI_CHECKED Then
						_Copie($videos, $videosDir)
					EndIf
		;~ 			TELECHARGEMENT
					If GUICtrlRead($cb_telechargement) = $GUI_CHECKED Then
						_Copie($telechargement, $telechargementDir)
					EndIf
					GUICtrlSetData($log, @CRLF & "Copie(s) terminée(s) avec succès." & @CRLF,1)
				EndIf

		Case $mi_aPropos
			GUISetState(@SW_SHOW, $F_aPropos)
		Case $bt_okAPropos
			GUISetState(@SW_HIDE, $F_aPropos)

		Case $mi_contact
			ShellExecute($contact)

		Case $mi_favoris
			ShellExecute($favoris)

		Case $mi_liens
			ShellExecute($liens)

		Case $mi_musique
			ShellExecute($musique)

		Case $mi_documents
			ShellExecute($documents)

		Case $mi_images
			ShellExecute($images)

		Case $mi_videos
			ShellExecute($videos)

		Case $mi_telechargements
			ShellExecute($telechargement)

		Case $mi_quitter
			Exit

		Case $cb_toutCocher
			GUICtrlSetState($cb_bureau, $GUI_CHECKED)
			GUICtrlSetState($cb_contact, $GUI_CHECKED)
 			GUICtrlSetState($cb_favoris, $GUI_CHECKED)
			GUICtrlSetState($cb_liens, $GUI_CHECKED)
 			GUICtrlSetState($cb_musique, $GUI_CHECKED)
 			GUICtrlSetState($cb_document, $GUI_CHECKED)
 			GUICtrlSetState($cb_images, $GUI_CHECKED)
 			GUICtrlSetState($cb_videos, $GUI_CHECKED)
 			GUICtrlSetState($cb_telechargement, $GUI_CHECKED)
 			GUICtrlSetState($cb_deselectionne, $GUI_UNCHECKED)


		Case $cb_deselectionne
			GUICtrlSetState($cb_bureau, $GUI_UNCHECKED)
			GUICtrlSetState($cb_bureau, $GUI_UNCHECKED)
			GUICtrlSetState($cb_contact, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_favoris, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_liens, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_musique, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_document, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_images, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_videos, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_telechargement, $GUI_UNCHECKED)
 			GUICtrlSetState($cb_toutCocher, $GUI_UNCHECKED)

	EndSwitch
WEnd

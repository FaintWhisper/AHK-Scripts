#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

global gSupportedExts := ".7z.zip.rar.tar"		; add extensions to support (include preceeding period with each, no spaces!)
return

#IfWinActive, ahk_class CabinetWClass

; option 1 - use context menu for extract here
^e::	; Ctrl+e
	if (getFilePath()=="")
		return
	;SetKeyDelay, 30
	SendInput, {AppsKey}7ee{enter}	; extract here
	return

; ; option 2 - use command line
; ^+e::	; Ctrl+Shift+e
; 	fp := getFilePath()
; 	if (fp=="")
; 		return
; 	SplitPath, fp,, oDir
; 	7z	:= "C:\Program Files\7-Zip\7z.exe"	; change to path for 7zip executable
; 	cmd	:= """" . 7z . """" . " x " . fp . " -o" . oDir . " -y"
; 	Run, %cmd%,, Hide UseErrorLevel
; 	; add Errorlevel handling if desired
; 	return

; option 2 - use context menu for extract to folder
^+e::	; Ctrl+e
	if (getFilePath()=="")
		return
	;SetKeyDelay, 30
	SendInput, {AppsKey}7eee{enter}	; extract to folder
	return
	
#IfWinActive	
;################################################################################
isZipFile(srcFileName)
{
	SplitPath, srcFileName,,, oExt
	needle := "i)(?>(\.\w{2,4}))(?=.*\1)"
	haystack := gSupportedExts . " ." . oExt
	RegExMatch(haystack, needle, m)
	return (m != "")
}
;################################################################################
getFilePath()
{
	SendInput, ^c
	Sleep, 100
	fp := Clipboard	; convert to text path
	return isZipFile(fp) ? fp : ""	; verify that it is a zip file
}

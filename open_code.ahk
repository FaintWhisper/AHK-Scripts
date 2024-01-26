#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

#IfWinActive, ahk_class CabinetWClass

!s::
	if (getFilePath() == "")
		return
	SendInput, {AppsKey}c{Enter}
	return
	
#IfWinActive	
getFilePath()
{
	SendInput, ^c
	Sleep, 100
	fp := Clipboard	; convert to text path
	return fp
}

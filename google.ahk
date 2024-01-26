#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

^+f:: ; change to preferred hotkey
	WinGet, active_id, ID, A ; get handle of active window
	clip := clipboard
	send, ^c
	Sleep, 1 ; wait for clipboard to contain something
	url := "https://www.google.com/search?q="
	is_it_an_url := SubStr(clipboard, 1 , 8)

	if (is_it_an_url = "https://") { ; if it starts with "https://" go to, rather than search in google search
		run, %clipboard%
	}
	else { ; search using google search
		joined_url = %url%%clipboard%
		run, %joined_url%
	}

	clipboard := clip ;put the last copied thing back in the clipboard
	sleep 500 ;Up from 50, you might be able to fine-tune this number based on your computer's speed
	WinActivate, ahk_id %active_id%
return
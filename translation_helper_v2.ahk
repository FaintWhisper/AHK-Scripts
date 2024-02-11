#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

^!s::
    Send, ^c
    Sleep, 500
    text := Clipboard
    Run, %comspec% /k C:\Users\Amit\miniconda3\Scripts\activate.bat main && cd "C:\Workspace\translation_helper\" && python "translate.py",, Hide
    
    return

^!d::
    Send, ^c
    Sleep, 500
    text := Clipboard
    Run, %comspec% /k C:\Users\Amit\miniconda3\Scripts\activate.bat main && cd "C:\Workspace\translation_helper\" && python "back-translate.py",, Hide

    return

^!t::
    Send, ^c
    Sleep, 500
    text := Clipboard
    Run, %comspec% /k C:\Users\Amit\miniconda3\Scripts\activate.bat main && cd "C:\Workspace\translation_helper\" && python "show-translate.py",, Hide

    return
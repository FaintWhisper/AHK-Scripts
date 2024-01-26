#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

; Define a hotkey (e.g., Ctrl+Alt+E) to trigger the command
^!e::
    ; Save the currently selected text to the clipboard
    Clipboard := ""
    Send, ^c
    ClipWait
    
    ; Get the selected text from the clipboard
    selectedText := Clipboard

    ; If the selected text contains spaces, enclose it in double quotes
    if InStr(selectedText, " ")
        selectedText := """" . selectedText . """"

    ; Replace newlines with spaces
    StringReplace, selectedText, selectedText, `n, ` , All
    
    ; Run the command with the selected text
    Run, %comspec% /k C:\Users\Amit\miniconda3\Scripts\activate.bat main && edge-playback -t %selectedText% -v en-US-JennyNeural
    
    ; Clear the clipboard for security
    Clipboard := ""
return
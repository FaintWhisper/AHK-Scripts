#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

^!c::
    ; Check if the active window is a File Explorer window
    WinGetClass, vClass, A
    if (vClass != "CabinetWClass")
        ; Copy as normal if it isn't
        Send, ^c
        return

    WinGet, hWnd, ID, A

    vPath := ""
    for oWin in ComObjCreate("Shell.Application").Windows
        if (oWin.HWND = hWnd)
        {
            for oItem in oWin.Document.SelectedItems
            {
                vPath .= oItem.Path "`n" ; Append each path to vPath, followed by a newline
            }
            ; If no items are selected, get the current folder's path
            if (vPath = "")
                vPath := oWin.Document.Folder.Self.Path
            break
        }
    oWin := oItem := ""
    Clipboard := vPath
    return
#IfWinActive
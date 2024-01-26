#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, % script_icon()

; when hotkey is pressed and explorer is focused execute the command "PasteIntoFiles" alonside the current working directory in the explorer
GetExplorerPath(hwnd=0){
    explorerHwnd := WinActive("ahk_class CabinetWClass")
	
	if (explorerHwnd){
		for window in ComObjCreate("Shell.Application").Windows{
			try{
				if (window && window.hwnd && window.hwnd==explorerHwnd)
					return window.Document.Folder.Self.Path
			}
		}
	}
	return false
}

^!v::
#IfWinActive ahk_class ExploreWClass
    ExplorerPath := GetExplorerPath()
    
    if (ExplorerPath) {
        Valid := RegExMatch(ExplorerPath, "(.*):\\")

        if Valid = 1
            Run, "C:\Apps\PasteIntoFiles.exe" "%ExplorerPath%"
    }
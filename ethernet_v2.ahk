#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

; MsgBox A_IsAdmin: %A_IsAdmin%`nCommand line: %full_command_line%

adapter:="Ethernet" ; set to the adapter name

ConnectedToInternet(flag=0x40) { 
    Return DllCall("Wininet.dll\InternetGetConnectedState", "Str", flag, "Int", 0) 
}

SwitchAdapterState()
{
    if (ConnectedToInternet()) {
        runwait,netsh interface set interface %adapter% disabled,,hide 
        TrayTip, Ethernet, Disabled
    } else {
        runwait,netsh interface set interface %adapter% enabled,,hide
        TrayTip, Ethernet, Enabled
    }
}

; Ctrl + Win + F3
^#F3::
    full_command_line := DllCall("GetCommandLine", "str")

    if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    {
        try
        {
            if A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ExitApp
    } else
    {
        SwitchAdapterState()
    }

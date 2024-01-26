#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
Menu, Tray, Icon, % script_icon()

adapter := "Ethernet" ; set to the adapter name
adapter_state := "enabled"

; Ctrl + Win + F3
^#F3::
    if (adapter_state = "enabled") {
        adapter_state := "disabled"
        Run *RunAs %comspec% /c netsh interface set interface name="%adapter%" disabled,, Hide
        MsgBox, "Ethernet disabled"
    } else {
        adapter_state := "enabled"
        Run *RunAs %comspec% /c netsh interface set interface name="%adapter%" enabled,, Hide
        MsgBox, "Ethernet enabled"
    }

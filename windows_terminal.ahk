﻿#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, % script_icon()

^!x::
    Run, wt.exe -d C:\Users\Amit\Downloads
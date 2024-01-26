^+a::
    WinGet, hWnd, ID, A

    vPath := ""
    for oWin in ComObjCreate("Shell.Application").Windows
        if (oWin.HWND = hWnd)
        {
            vPath := oWin.Document.FocusedItem.Path
            if (vPath = "")
                vPath := oWin.Document.Folder.Self.Path
            else
            {
                vIsSelected := 0
                for oItem in oWin.Document.SelectedItems
                    if (vPath = oItem.Path)
                    {
                        vIsSelected := 1
                        break
                    }
                if !vIsSelected
                    vPath := oWin.Document.Folder.Self.Path
            }
            break
        }
    oWin := oItem := ""
    Clipboard := vPath
    return
    #IfWinActive
TraySetup() {
    menu, tray, nostandard
    f := Func("setupdefaultconfig")
    Menu, Tray, Add, Restore default config, % f
    f2 := Func("reload")
    menu, tray, Add, Reload, % f2
    f3 := Func("exitApp")
    menu, tray, Add, Exit Applicaton, % f3
    DllCall("DestroyIcon", "Ptr", hICON) ; Destroy original HICON
    return
}
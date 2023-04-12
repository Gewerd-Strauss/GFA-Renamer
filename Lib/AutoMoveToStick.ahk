;#warn
global aa
if (searchfor="") {
    searchfor:="Galaxy A33 REDACTED"
}

OnMessage(0x219, "notify_change")
notify_change(wParam, lParam, msg, hwnd)
{
    SetTimer,FindUSBDevice,1000 
}




return
;-----------------------------------
FindUSBDevice() {
    static
    ttip("Checking Devices...")
    sleep, zz000
    if (found) {
        settimer,% A_ThisFunc,off
        i=0
        e:=""
        device_name:=""
        for device in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity") {
            if (script.config.Config.USB_Stick_Name="") {
                script:={}
                script.config:={}
                script.config.Config:={}
                script.config.Config.USB_Stick_Name:="Galaxy A33 REDACTED"
            }
            device_searchedFor:=script.config.Config.USB_Stick_Name 
            device_name:=device.Name
            if Instr(device_name,device_searchedFor) {
    
                device_name:=device.Name
                found:=false
                dvc:=device
                guicontrol,GFAR:,vUsedStick,% "used Stick: " (device_name!=""? "'" device_name "'": "Device '" script.config.config.USB_Stick_Name "' could not be found.") 
                break
            }
        }
        if (device_name!="") && Instr(device_name,device_searchedFor) {
            Return {dvc:dvc,device_name:device_name}
        }
        else {
            guicontrol,GFAR:,vUsedStick,% "used Stick: " (Instr(device_name,device_searchedFor)?"'" device_name "'": "Device '" script.config.config.USB_Stick_Name "' could not be found.") 
            return -1
        }
    }
    sleep,1000
    i=0
    e:=""
    device_name:=""
    found:=false
    for device in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity")
        {
        if (script.config.Config.USB_Stick_Name="") {
            script:={}
            script.config:={}
            script.config.Config:={}
            script.config.Config.USB_Stick_Name:="Galaxy A33 REDACTED"
        }
        device_searchedFor:=script.config.Config.USB_Stick_Name 
        device_name:=device.Name
        ttip(["Searching for device: ","<" script.config.Config.USB_Stick_Name ">","<" device_searchedFor ">", "|" device.name "|","|" device_name "|"],mode:=1,to:=400)
        if Instr(device_name,device_searchedFor) {

            ;msgbox, % "match: " device.name "`nGalaxy A" 
            device_name:=device.Name
            found:=true
            dvc:=device
            guicontrol,GFAR:,vUsedStick,% "used Stick: " (device_name!=""? "'" device_name "'": "Device '" script.config.config.USB_Stick_Name "' could not be found.") 
            break
        }
        ; If InStr(device.name,script.config.Config.USB_Stick_Name)
        ; {
        ;     settimer,% A_ThisFunc,off
        ;     i++  
        ;     aa:=device.name
        ;     e .= i . "--" . aa . "`r`n"
        ; }
        settimer,% A_ThisFunc,off
    }
    ; aa:=""
    ; if device_name<>
    e:=""
    if (found) {
        Return {dvc:dvc,device_name:device_name}
    }
    else {
        guicontrol,GFAR:,vUsedStick,% "used Stick: " (Instr(device_name,device_searchedFor)?"'" device_name "'": "Device '" script.config.config.USB_Stick_Name "' could not be found.") 
        return -1
    }
}

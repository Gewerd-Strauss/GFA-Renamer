#Requires AutoHotkey v1.1.36+ ;; version at which script was written.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
#MaxHotkeysPerInterval, 99999999
#Warn All, Outputdebug
;#Persistent 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On
SetKeyDelay -1,-1
SetBatchLines,-1
SetTitleMatchMode, 2

FileGetTime, ModDate,%A_ScriptFullPath%,M
FileGetTime, CrtDate,%A_ScriptFullPath%,C
CrtDate:=SubStr(CrtDate,7,  2) "." SubStr(CrtDate,5,2) "." SubStr(CrtDate,1,4)
ModDate:=SubStr(ModDate,7,  2) "." SubStr(ModDate,5,2) "." SubStr(ModDate,1,4)
global script := {   base         : script
                    ,name         : regexreplace(A_ScriptName, "\.\w+")
                    ,version      : ""
                    ,author       : "Gewerd Strauss"
                    ,authorID	  : "Laptop-C"
                    ,authorlink   : ""
                    ,email        : ""
                    ,credits      : ""
                    ,creditslink  : ""
                    ,email        : "csa-07@freenet.de"
                    ,crtdate      : CrtDate
                    ,moddate      : ModDate
                    ,homepagetext : ""
                    ,homepagelink : ""
                    ,ghtext 	  : "GH-Repo"
                    ,ghlink       : "https://github.com/Gewerd-Strauss/GFA-Renamer"
                    ,doctext	  : ""
                    ,doclink	  : ""
                    ,forumtext	  : ""
                    ,forumlink	  : ""
                    ,donateLink	  : ""
                    ,resfolder    : A_ScriptDir "\res"
                    ,iconfile	  : ""
;					  ,reqInternet: false
                    ,rfile  	  : "https://github.com/Gewerd-Strauss/GFA-Renamer/archive/refs/heads/master.zip"
                    ,vfile_raw	  : "https://raw.githubusercontent.com/Gewerd-Strauss/GFA-Renamer/master/version.ini" 
                    ,vfile 		  : "https://raw.githubusercontent.com/Gewerd-Strauss/GFA-Renamer/master/version.ini" 
                    ,vfile_local  : A_ScriptDir "\version.ini" 
;					,DataFolder:	A_ScriptDir ""
                    ,config:		[]
                    ,configfile   : A_ScriptDir "\INI-Files\" regexreplace(A_ScriptName, "\.\w+") ".ini"
                    ,configfolder : A_ScriptDir "\INI-Files"}
;; 


script.SetIcon("iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAYAAAA6/NlyAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAARISURBVGhD7dtLbxNXGMbxbFh2yRIpzkWQgpIUKFAVibCBknIJqCFOZNIbJg0Xp7ikkAAh4SJoCxUENiBgW6ktUldIKQURbmpAIkSiqlqg6gcAvsLLPPPKVjp5bM/xnAllMpb+K4/PeX9yjj1epGKmPpqcBmdAcLqPwcrKSol6cCo3BkczOJUbg6MZnMqNwdEMTuXG4GgGp3JjcDSDU7kG4OzvJ+TAs3NT6p04Kd1XB6TtbJc0fbZGaupq6etNqplX666VPNflrH1QesdP0b2/evAtfb03OJVrAext7x/fS9vwNlnwXiNdp1gLljXI5jNpdw22trdQwZnRI3TTQvX/NSwth1NSVVNF15tcorpKNgylZN+fp+lahfry7jG6njc4lWsAxp8W27RU237pk7kNdXRNNLe+TtJX9tHXlmr7yEG6pjc4lWsATl3aRTf1E96JhhWLp6xZv3yh9Nw+Sl/jp87LPVPWZMGpXANw89etdFO/ZcdOyPwl9fn18M6aHhNvH/a1/WfGQsGpXAPwwlVL6aYmdV89INW11e6ZTV/ZS68xadHqZXRWb3Aq1wCMMjcP041NWru/XdYPdNDnTMqMHpVEIkHn9Aancg3BH2Q30c1Nyj46Lnsef0OfM2lVz0Y6IwtO5RqCcUOQfXCcDuC39P1dkh4r/wMQZW4e8/V1lwtO5RqC0crPm+kQfup/Oizt1zZJ8teN0v/kLL3GTys+WU1nKxScyi0DjFIXd9JBSpWZOCRtI+vdMhMD9JpS4euRzVQsOJVbJhh/2uXciKTHdubBW8d20GuKhT3LuVeHU7llghG+R/E1wwYrVOetzjy4c/Rjek2h8ANlXuPbdJZSwancAGCEd3rL5QwdkNVxvTUP7vjN/41MytkjyK8wOJUbEJwLH2S4fWTDTi55rSUPTo600GsmhzVXbm2me5oEp3ItgRHuoNbs+Uh23yv8MzKHzbX/2TC9Dms097a6a7K9TINTuRbBuRJVCVmy7n3ZMJiST3/IundEvY9OSt/fZ6aA+5yfkHgO1+BavAavxRps7XKDU7khgIvlfSfZNWEEp3JjcLi9seCXdypea2ymYsGp3BjsLzbEdMZmKhacyg0AfnGjQv4Zchqcppy9nl9/jWD073dksJDCXrl92UzFglO5ZYJznR96Kz9E2GEvNoOf4FRuQPAX7bPpcGHUlZxNZ/ATnMoNCF7UOEee3+ID2u7dd+bQGfwEp3IDgtH4j7PogDZ7+NMsurff4HS1ziMw+MI0nOMg5xfBqVwL4O6O8M8xPivY3n6DU7kWwIudc8yGtFmQ84vgVK4FMArzHGNttqdJcLpa52EFfPFIeOcYnxFsT5PgVK4lcJjnGGuzPU2CU7mWwGGe46DnF8GpXEtgNP6z/XNs4/wiOF2t87AGDuMcY022l2lwKtci+P8cnMqNwdEMTuXG4GgGp3JjcDSDU7kz5j/TKppeAamEQurI/tgFAAAAAElFTkSuQmCC")


script.loadCredits(script.resfolder "\credits.txt")

script.config:=ini(script.configfile)
OutputDebug, % Obj2Str(script.config.LastRun)
OutputDebug, % script.config.Count()
if !script.config.Count()
{ 
    script.config:={"Config":{version:1.3.2},"LastRun":{Names:"",PlantsPerGroup:""}}
    OnMessage(0x44, "MsgBoxCallback")
    MsgBox 0x40, % script.name " - Initialisation",% "Initialised settings-file. `nThis will keep track of the last data you provided.`n`nThis config-file is located at`n`n'" A_ScriptDir "\INI-Files\" A_ScriptName ".ini'`n`nYou can now continue."
    OnMessage(0x44, "")
}

script.version:=script.config.Config.Version
;; setup the GUI.
yP:=A_ScreenHeight-500
gui, GFAR: new, +AlwaysOnTop -SysMenu -ToolWindow -caption +Border  +hwndGFAGui
gui, Font, s10
gui, add, text,,% "Please drag and drop the folder you want to use on this window.`n`nChosen folder:"
gui, add, Edit, w400 h110 vFolder disabled, % script.config.LastRun.Folder
gui, add, text,, % "Enter Group names, delimited by a comma ','."
gui, add, edit, vNames w200, % script.config.LastRun.Names
gui, add, text,, % "Please set the number of pots/plants per group.`nValue must be an integer."
gui, add, edit, vPlantsPerGroup w200 Number, % script.config.LastRun.PlantsPerGroup

gui, add, Button, gGFARSubmit, &Submit
gui, add, Button, yp xp+60 gGFARHelp, &Help
gui, add, Button, yp xp+200 gGFARAbout, &About
gui, GFAR: show, w200 x0  y%yP%  AutoSize,% "Drop folder with images on this window"
gui, font, s7
gui, add, text,yp+20 x350,% "v." script.version " by ~Gw"
return
#if Winactive("ahk_id " GFAGui) ;; make the following hotkey only trigger when the GUI has keyboard-focus.
Esc::GFAREscape()
#if ;; end the hotkey-condition

;; receive the GuiDropFiles_message
GFARGuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) { 
    for i, file in FileArray {
        guicontrol,, Folder, % file
    }
    return
}
GFARAbout() {
    script.About()
    return
}
GFARHelp() {
    Gui +OwnDialogs
    MsgBox 0x20, % script.name " - Help/HowTo", 1. Drag and Drop a folder containing all images you want to rename on the GUI.`n`n2. Please give all group names in the correct order from top to bottom`nas seen in the list of images when sorted by name in descending`norder (1.png → 2.png → 3.png → ...). Names must be delimited by a`ncomma '`,'. Commas cannot be part of the name`, use dots '.'.`n`n3. Please set the number of pots/plants per group.`nValue must be an integer.`n`n4. Submit & check the proposed changes if you want.`n`n5. Confirm. The files will now be renamed.
    return
}
GFAREscape() {
    gui, GFAR: destroy
    ExitApp
    return
}
GFARSubmit() {
    global
    gui, GFAR: Submit, NoHide
    if (Names="") {
        ttip("Please provide the number of pots/plants per group.")
    }
    if (PlantsPerGroup="") {
        ttip("Please provide the number of pots/plants per group.")
    }
    if (Folder="") {
        ttip("Please provide a Folder containing the images you want to name by dragging it onto this window.")
    }
    Arr:={}
    script.config.LastRun.Folder:=Folder
    script.config.LastRun.Names:=Names
    script.config.LastRun.PlantsPerGroup:=PlantsPerGroup
    ; script.save()
    LoopCount:=PlantsPerGroup*strsplit(Names,",").Count()
    loop % LoopCount
        Arr.push(repeatElementIofarrayNKtimes(strsplit(Names,","),PlantsPerGroup) " (" repeatIndex(PlantsPerGroup) ")")

    ttip(repeatElementIofarrayNKtimes())
    TrueNumberOfFiles:=0
    Loop, Files, % Folder "\*." script.config.Config.filetype, F
        TrueNumberOfFiles++
    str:="Number of Images that would be renamed given the settings provided: "  Arr.Count() "`nFound number of images: " TrueNumberOfFiles "`n"
    Files:=str
    Loop, Files, % Folder "\*." script.config.Config.filetype, F
    {
        compareTimestamp(A_LoopFileFullPath)
        if (A_Index<41)
            Files.= A_LoopFileFullPath " - " Arr[A_Index] "`n"
    }
    Clipboard:=Files
    Gui +OwnDialogs
    MsgBox 0x40034, % script.name " - Confirm",% "Below you can see the first 40 images changed as a sample.`n" Files "`nDo you want to proceed?"

    IfMsgBox Yes, {
        Loop, Files, % Folder "\*." script.config.Config.filetype, F
        {
            scriptWorkingDir:=renameFile(A_LoopFileFullPath,Arr[A_Index],true,A_Index,TrueNumberOfFiles)
            writeFile(scriptWorkingDir "\gfa_renamer_log.txt",Files, "UTF-8-RAW","w",true)
        }
        ttip(script.name " - Finished running")
        OnMessage(0x44, "OnMsgBox2")
        MsgBox 0x40, `% script.name " - " Script finished, The script finished running.`nThe folder containing the renamed images will open once this message box is closed.`n`nA log mapping each image to its new name is given in the file 'gfa_renamer_log.txt' within the output directory 'GFAR_WD'. The original image files are preserved in the original folder.
        OnMessage(0x44, "")

        if (WinExist(scriptWorkingDir " ahk_exe explorer.exe")) {
            WinActivate
            return
        } 
        Else {
            run, % scriptWorkingDir
        }
    } Else IfMsgBox No, {
        MsgBox 0x40034, % script.name " - Confirm", % "No changes occured. Exiting application now."
    }
    ExitApp
    return
}
compareTimestamp(File) {
    static lastCT:=""
    bool:=false
    FileGetTime, CT, % FIle, C
    FileGetTime, MT, % FIle, M
    if (lastCT="")
        lastCT:=CT
    else {

        Diff:=CT-lastCT
    }
    m("prep a double image by the auslöser for testing here!")
    return bool
}
MsgBoxCallback() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        ControlSetText Button1, Continue
    }
    return
}
MsgBoxCallback2() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        ControlSetText Button1, Exit Script
    }
    return
}

writeFile(Path,Content,Encoding:="",Flags:=0x2,bSafeOverwrite:=false) { 

    if (bSafeOverwrite && FileExist(Path))  ;; if we want to ensure nonexistance.
        FileDelete, % Path
    if (Encoding!="")
    {
        if (fObj:=FileOpen(Path,Flags,Encoding))
        {
            fObj.Write(Content) ;; insert contents
            fObj.Close()        ;; close file
        }
        else
            throw Exception("File could not be opened. Flags:`n" Flags, -1, myFile)
    }
    else
    {
        if (fObj:=FileOpen(Path,Flags))
        {
            fObj.Write(Content) ;; insert contents
            fObj.Close()        ;; close file
        }
        else
            throw Exception("File could not be opened. Flags:`n" Flags, -1, myFile)
    }
    return
}
renameFile(Path,Name,Backup:=true,CurrentIndex:="",TotalCount:="") {
    static HasBackuped:=false
    SplitPath, % Path, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
    if !Instr(FileExist(scriptWorkingDir:=OutDir "\"  "GFAR_WD"),"D")
        FileCreateDir, % scriptWorkingDir
    ttip(["Renaming (" CurrentIndex "/" TotalCount ")",[Path,Name]])
    FileCopy, % Path, % scriptWorkingDir  "\" Name "." OutExtension
    return scriptWorkingDir
}

repeatIndex(repetitions) {
    static lastreturn:=0
    lastreturn++
    if (lastreturn>repetitions)
        lastreturn:=1
    OutputDebug, % lastreturn "`n"
    return lastreturn
}
repeatElementIofarrayNKtimes(array:="",repetitions:="",bDebug:=true) {
    static k, callIndex, position, sites := []
    if (sites.Count() = 0) { ; It is the first run, let set variables and see their contents
        k := 5         ; Arbitrary set to a desired value
        k := repetitions
        callIndex := 0 ; Always start at zero to add from there
        position := 1  ; Have a value on the first iteration
        sites := {}
        sites := array
        OutputDebug % "Sites (N-elements):   " sites.Count() "`n"
        OutputDebug % "Calls (K-iterations): " k "`n"
    }
    site := sites[position]
    OutputDebug % position ": " site "`n"

    callIndex++ ; Increment `callIndex`, meaning that we made a new call to the function
    modResult := Mod(callIndex, k)
    if (modResult = 0) ; If there is a remainder (ie, not exactly divisible by k)
        position++ ; Increase the position by 1
    if (position > sites.Count()) ; If the new position is bigger than the actual number of elements in the array
        position := 1 ; Reset the position to start over
    return site
}



return


fTraySetup(IconString) {
    hICON := Base64PNG_to_HICON( IconString )  ; Create a HICON for Tray
    Menu, Tray, Icon, HICON:*%hICON%                      ; AHK makes a copy of HICON when * is used
    Menu, Tray, Icon
    f:=ObjBindMethod(script, "About")
    Menu, Tray, Add, About, % f
    DllCall( "DestroyIcon", "Ptr",hICON  )                ; Destroy original HICON
    return
}




#Include, <script>
#include, <ini>
#Include, <Base64PNG_to_HICON>
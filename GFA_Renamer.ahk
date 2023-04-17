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
global script := new script()
script := {base         : script.base
                    ,name         : regexreplace(A_ScriptName, "\.\w+")
                    ,Computername : A_ComputerName
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
                    ,ghtext 	  : "GitHub-Repository"
                    ,ghlink       : "https://github.com/Gewerd-Strauss/GFA-Renamer"
                    ,doctext	  : "Documentation"
                    ,doclink	  : "https://github.com/Gewerd-Strauss/GFA-Renamer#readme"
                    ,offdoclink   : A_ScriptDir "\assets\Documentation\GFA_Renamer_Readme.html"
                    ,forumtext	  : ""
                    ,forumlink	  : ""
                    ,donateLink	  : ""
                    ,resfolder    : A_ScriptDir "\res"
                    ,iconfile	  : ""
                    ,reqInternet: false
                    ,rfile  	  : "https://github.com/Gewerd-Strauss/GFA-Renamer/archive/refs/heads/master.zip"
                    ,vfile_raw	  : "https://raw.githubusercontent.com/Gewerd-Strauss/GFA-Renamer/master/version.ini" 
                    ,vfile 		  : "https://raw.githubusercontent.com/Gewerd-Strauss/GFA-Renamer/master/version.ini" 
                    ,vfile_local  : A_ScriptDir "\res\version.ini" 
                    ,EL           : "359b3d07acd54175a1257e311b5dfaa8370467c95f869d80dba32f4afdcae19f4485d67815d9c1f4fe9a024586584b3a0e37489e7cfaad8ce4bbc657ed79bd74"
                    ,config:		[]
                    ,configfile   : A_ScriptDir "\res\" regexreplace(A_ScriptName, "\.\w+") ".ini"
                    ,configfolder : A_ScriptDir "\res"
                    ,license      : A_ScriptDir "\res\LICENSE.txt"}
currLicense:=Hash_File(A_ScriptDir "\res\LICENSE.txt","sha512")
global bTestSet:=false
global TEST_FOLDERPATH:=false
F:=(FileExist(A_ScriptDir "\res\LICENSE.txt") && (currLicense==script.EL))
if !F {
    OnMessage(0x44, "MsgBoxCallback3")
    MsgBox 0x11, script.name - Invalid or missing license, Please keep the expected license-file for this application in the resources-subfolder of the application's directory. The license is provided with the software at download`, or at this application's github repository.`n`nThe program will exit now.
    OnMessage(0x44, "")
    IfMsgBox OK, {
        ExitApp, 
    } Else IfMsgBox Cancel, {
        run, % script.ghlink
        ExitApp, 
    }
}


if !script.requiresInternet() {
    ExitApp
}
script.loadCredits(script.resfolder "\credits.txt")
script.setIcon("iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAYAAAA6/NlyAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAARISURBVGhD7dtLbxNXGMbxbFh2yRIpzkWQgpIUKFAVibCBknIJqCFOZNIbJg0Xp7ikkAAh4SJoCxUENiBgW6ktUldIKQURbmpAIkSiqlqg6gcAvsLLPPPKVjp5bM/xnAllMpb+K4/PeX9yjj1epGKmPpqcBmdAcLqPwcrKSol6cCo3BkczOJUbg6MZnMqNwdEMTuXG4GgGp3JjcDSDU7kG4OzvJ+TAs3NT6p04Kd1XB6TtbJc0fbZGaupq6etNqplX666VPNflrH1QesdP0b2/evAtfb03OJVrAext7x/fS9vwNlnwXiNdp1gLljXI5jNpdw22trdQwZnRI3TTQvX/NSwth1NSVVNF15tcorpKNgylZN+fp+lahfry7jG6njc4lWsAxp8W27RU237pk7kNdXRNNLe+TtJX9tHXlmr7yEG6pjc4lWsATl3aRTf1E96JhhWLp6xZv3yh9Nw+Sl/jp87LPVPWZMGpXANw89etdFO/ZcdOyPwl9fn18M6aHhNvH/a1/WfGQsGpXAPwwlVL6aYmdV89INW11e6ZTV/ZS68xadHqZXRWb3Aq1wCMMjcP041NWru/XdYPdNDnTMqMHpVEIkHn9Aancg3BH2Q30c1Nyj46Lnsef0OfM2lVz0Y6IwtO5RqCcUOQfXCcDuC39P1dkh4r/wMQZW4e8/V1lwtO5RqC0crPm+kQfup/Oizt1zZJ8teN0v/kLL3GTys+WU1nKxScyi0DjFIXd9JBSpWZOCRtI+vdMhMD9JpS4euRzVQsOJVbJhh/2uXciKTHdubBW8d20GuKhT3LuVeHU7llghG+R/E1wwYrVOetzjy4c/Rjek2h8ANlXuPbdJZSwancAGCEd3rL5QwdkNVxvTUP7vjN/41MytkjyK8wOJUbEJwLH2S4fWTDTi55rSUPTo600GsmhzVXbm2me5oEp3ItgRHuoNbs+Uh23yv8MzKHzbX/2TC9Dms097a6a7K9TINTuRbBuRJVCVmy7n3ZMJiST3/IundEvY9OSt/fZ6aA+5yfkHgO1+BavAavxRps7XKDU7khgIvlfSfZNWEEp3JjcLi9seCXdypea2ymYsGp3BjsLzbEdMZmKhacyg0AfnGjQv4Zchqcppy9nl9/jWD073dksJDCXrl92UzFglO5ZYJznR96Kz9E2GEvNoOf4FRuQPAX7bPpcGHUlZxNZ/ATnMoNCF7UOEee3+ID2u7dd+bQGfwEp3IDgtH4j7PogDZ7+NMsurff4HS1ziMw+MI0nOMg5xfBqVwL4O6O8M8xPivY3n6DU7kWwIudc8yGtFmQ84vgVK4FMArzHGNttqdJcLpa52EFfPFIeOcYnxFsT5PgVK4lcJjnGGuzPU2CU7mWwGGe46DnF8GpXEtgNP6z/XNs4/wiOF2t87AGDuMcY022l2lwKtci+P8cnMqNwdEMTuXG4GgGp3JjcDSDU7kz5j/TKppeAamEQurI/tgFAAAAAElFTkSuQmCC")
script.update()

script.config:=ini(script.configfile)

OutputDebug, % script.config.Count()
if !script.config.Count() { 
    script.config:={"Config":{version:1.3.2},"LastRun":{Names:"",PlantsPerGroup:""}}
    OnMessage(0x44, "MsgBoxCallback")
    MsgBox 0x40, % script.name " - Initialisation",% "Initialised settings-file. `nThis will keep track of the last data you provided.`n`nThis config-file is located at`n`n'" A_ScriptDir "\res\" A_ScriptName ".ini'`n`nYou can now continue."
    OnMessage(0x44, "")
}
script.version:=script.config.Config.Version
;; setup the GUI.
yP:=A_ScreenHeight-500
xP:=A_ScreenWidth-440
gui, GFAR: new, +AlwaysOnTop -SysMenu -ToolWindow -caption +Border  +hwndGFAGui
gui, Font, s10
gui, add, text,,% "Please drag and drop the folder you want to use on this window.`n`nChosen folder:"
gui, add, Edit, w400 h110 vFolder disabled, % script.config.LastRun.Folder
gui, add, text,, % "Enter Group names, delimited by a comma ','."
gui, add, edit, vNames w200, % script.config.LastRun.Names
gui, add, text,, % "Please set the number of pots/plants per group.`nValue must be an integer."
gui, add, edit, vPlantsPerGroup w200 Number, % script.config.LastRun.PlantsPerGroup
;gui, add, text,vvUsedStick, % "used Stick: " (device_name!=""? "'" device_name "'": "Device '" script.config.config.USB_Stick_Name "' could not be found.") 
gui, add, Button, vSubmitButton disabled gGFARSubmit, &Submit
gui, add, Button, yp xp+64 gGFARHelp, &Help
gui, add, Button, yp xp+51 gGFARAbout, &About
onOpenConfig:=Func("GFARopenConfig").Bind(script.configfile)
gui, add, button,  hwndOpenConfig yp xp+58, &Config
GuiControl, +g,%OpenConfig%, % onOpenConfig
if !(A_IsCompiled) {
    gui, add, button, hwndSetTestset yp xp+60, % "Set Testset"
    onSetTestset:=Func("setTestset").Bind(A_ScriptDir "\assets\Image Test Files",script.config.Testset.Names,script.config.Testset.PlantsPerGroup)
    guicontrol, +g, %SetTestset%, % onSetTestset
}
gui, font, s7
gui, add, text,yp+20 x350,% "v." script.version " by ~Gw"
gui, GFAR: show, w430  x%xP%  y%yP%  ,% "Drop folder with images on this window"
return
#if Winactive("ahk_id " GFAGui) ;; make the following hotkey only trigger when the specific GUI has keyboard-focus.
Esc::GFAREscape()
#if Winactive("ahk_id " GFAR_ExcludeGui) ;; make the following hotkey only trigger when the specific GUI has keyboard-focus.
Esc::GFAR_ExcludeEscape()
#if ;; end the hotkey-conditions

;; Set the settings for the test-set files in the program's own directory.

;; receive the GuiDropFiles_message
GFARGuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) { 
    Count:=0
    for i, file in FileArray {
        guicontrol,, Folder, % file
        if CountFilesR(file,i) {
            guicontrol,GFAR: enable, SubmitButton
        }
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
GFARopenConfig(configfile) {
    static
    gui, Submit, NoHide
    RunWait, % configfile,,,PID
    WinWaitClose, % "ahk_PID" PID
    Gui +OwnDialogs
    OnMessage(0x44, "GFARopenConfig_OnMsgBox")
    MsgBox 0x40044, %  script.name " > " A_ThisFunc "()", You modified the configuration for this script.`nReload?
    OnMessage(0x44, "")
    IfMsgBox Yes, {
        reload
    } Else IfMsgBox No, {
        
    }
    return
}
GFARopenConfig_OnMsgBox() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        ControlSetText Button1, Reload
        ControlSetText Button2, Continue
    }
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
    ImagePaths:=[]
    
    opt:=(bTestSet?"FR":"F")
    
    Loop, Files, % Folder "\*." script.config.Config.filetype, % opt
    {
        ImageF:=A_LoopFileFullPath
        TrueNumberOfFiles++
        ImagePaths.Push(A_LoopFileFullPath)
        if (A_Index=1) {
            TEST_FOLDERPATH:=A_LoopFileDir
        }
    }
    str:="Number of Images that would be renamed given the settings provided: "  Arr.Count() "`nFound number of images: " TrueNumberOfFiles "`n"
    Files:=str



    gui, GFAR_Exclude: new, +AlwaysOnTop  -SysMenu -ToolWindow -caption +Border  +hwndGFAR_ExcludeGui
    gui, GFAR_Exclude: +OwnerGFAR
    gui, GFAR: +disabled
    gui, Font, s10
    gui, add, text,,% "Please UNTICK any name you do not have an image for (at that position).`nNotes:`n - Files are not actually skipped. Instead, by unticking a row you prevent the name of a pot that you don't have an image`nof from being applied to the 'next-in-line' image.)`n - Double-click an entry in this list to view the image"
    gui, add, Listview, gGFAR_ExcludeInspectSelection Checked vvLV_SelectedEntries w700 R30 +ReadOnly , Name | Expected Filepath
    f_UpdateLV(Arr,ImagePaths)
    ;Arr2:=ForceOrder(Arr)
    ImagePaths2:=ForceOrder(ImagePaths)
    gui, add, text,, % "Images/Names: (" ImagePaths.Count() "/" Arr.Count() ")"
    gui, add, Button, gGFAR_DuplicatetoShiftFrame vvGFAR_DuplicatetoShiftFrame disabled, &Duplicate to shift frame
    gui, add, Button,yp xp+170 vvGFAR_ExcludeSubmitButton gGFAR_ExcludeSubmit, &Continue
    GFAR_LastImage:=Func("GFAR_ExcludeOpenPath").Bind(ImageF)
    gui, add, Button, yp xp+80 hwndGFAR_ExcludeOpenLastImage,Open &Last image
    GuiControl, +g, %GFAR_ExcludeOpenLastImage%, % GFAR_LastImage
    
    GFAR_OpenFolder:=Func("GFAR_ExcludeOpenPath").Bind(Folder)
    gui, add, Button, yp xp+130 hwndGFAR_ExcludeOpenFolder,Open &Folder
    GuiControl, +g, %GFAR_ExcludeOpenFolder%, % GFAR_OpenFolder
    ;gui, add, Button, yp xp+80 gGFAR_ExcludeAbort
    if (ImagePaths.Count()<Arr.Count()) {
        guicontrol, GFAR_Exclude: Disable,vGFAR_ExcludeSubmitButton
        guicontrol, GFAR_Exclude: Enable,vGFAR_DuplicatetoShiftFrame
    } else {
        guicontrol, GFAR_Exclude: Enable,vGFAR_ExcludeSubmitButton
        guicontrol, GFAR_Exclude: Disable,vGFAR_DuplicatetoShiftFrame
    }
    gui, GFAR_Exclude: show, AutoSize,% "Exclude Names"
    WinWaitClose, % "Exclude Names"
    return
}

GFAR_DuplicatetoShiftFrame() {
    global
    static SourceImagesToDelete:=[]

    sel:=f_GetSelectedLVEntries()
    sel2:=strsplit(sel[1],"||")
    Delim:=(SubStr(Folder, -1 )!="\"?"\":"")
    if (TEST_FOLDERPATH!="") {
        InspectedImage:=TEST_FOLDERPATH  Delim  sel2[3] "." script.config.Config.filetype
        Padding_Name:=TEST_FOLDERPATH Delim sel2[3] " (padding)." script.config.Config.filetype
    } else {
        InspectedImage:=Folder  Delim  sel2[3] "." script.config.Config.filetype
        Padding_Name:=Folder  Delim sel2[3] " (padding)." script.config.Config.filetype
    }
    FileCopy, % InspectedImage,% Padding_Name, 0
    
    ;; Arr
    ;; ImagePaths
    Position_Original:=HasVal(ImagePaths,InspectedImage)
    Position_Duplicate:=Position_Original
    LV_Insert(Position_Duplicate, "Check", sel2[2] " (blank)", sel2[3] " (padding)")
    SourceImagesToDelete.push(Position_Duplicate) ; todo:: this does not work for mapping which files are padded and which are not. (just delete all files containing '(padding)' instead?)
    if (ImagePaths.Count()=Arr.Count()) {
        guicontrol, GFAR_Exclude: enable,vGFAR_ExcludeSubmitButton
    } else {
        GFAR_ExcludeEscape()
        sleep, 200
        GFARSubmit()
    }
    return SourceImagesToDelete
}

f_UpdateLV(Array,Array2) { 
    ; updates the selected LV. LV MUST BE SELECTED BEFORE.
    LV_Delete()
    for k,v in Array {
        SplitPath, % Array2[k], ,,, OutNameNoExt
        LV_Add("Check",v,OutNameNoExt)
    }
    LV_ModifyCol(1,"auto")
    return
}
GFAR_ExcludeOpenPath(Path) {
    gui, GFAR_Exclude: -AlwaysOnTop

    Run, % Path, , , vPID
    gui, GFAR_Exclude: +AlwaysOnTop
    
    return
}
GFAR_ExcludeInspectSelection() {
    global
    
    sel:=f_GetSelectedLVEntries()
    sel2:=strsplit(sel[1],"||")
    Delim:=(SubStr(Folder, -1 )!="\"?"\":"")
    if (TEST_FOLDERPATH!="") {
        InspectedImage:=TEST_FOLDERPATH  Delim  sel2[3] "." script.config.Config.filetype
    } else {
    InspectedImage:=Folder  Delim sel2[3] "." script.config.Config.filetype
    run, % InspectedImage
    return
}
f_GetSelectedLVEntries() {
    vRowNum:=0
    sel:=[]
    loop
    {
        vRowNum:=LV_GetNext(vRowNum)
        if not vRowNum  ; The above returned zero, so there are no more selected rows.
            break
        LV_GetText(sCurrText1,vRowNum,1)
        LV_GetText(sCurrText2,vRowNum,2)
        LV_GetText(sCurrText3,vRowNum,3)
        sel[A_Index]:="||" sCurrText1 "||" sCurrText2 "||" sCurrText3
    }
    return sel
}
f_GetCheckedLVEntries() {
    vRowNum:=0
    sel:=[]
    loop
    {
        vRowNum:=LV_GetNext(vRowNum,"C")
        if not vRowNum  ; The above returned zero, so there are no more checked rows.
            break
        LV_GetText(sCurrText1,vRowNum,1)
        LV_GetText(sCurrText2,vRowNum,2)
        LV_GetText(sCurrText3,vRowNum,3)
        sel[A_Index]:="||" sCurrText1 "||" sCurrText2 "||" sCurrText3
    }
    return sel
}
GFAR_ExcludeEscape() {
    gui, GFAR: -disabled
    gui, GFAR_Exclude: destroy
    ;MsgBox 0x40034, % script.name " - Confirm", % "No changes occured. Return to first GUI"
    return
}

GFAR_ExcludeSubmit() {
    global
    gui, GFAR: -disabled
    Sel:=f_GetCheckedLVEntries()            ;; retrieve all rows of the Listview that we have checked/not unchecked
    gui, GFAR_Exclude: Submit               ;; submit the GUI to get all data inputted into it formally.


    ;; we have deselected some files in the final GUI. Thus, we cannot  use a fileloop easily
    if (Sel.Count()<TrueNumberOfFiles) {
        Log:="Expected Number of images: " Sel_Arr.Count() "`nFound Number of images: " Sel_Arr.Count() "`n"
        FilestoCopy:=""
        for Sel_Index,Sel_String in Sel     ;; iterate over all entries that we left checked. These will be renamed based on the Entries of the Listview - the name displayed will be applied to the respectively displayed filename
        {
            if (TEST_FOLDERPATH!="") {
                Folder:=TEST_FOLDERPATH
            }
            Sel_Arr:=strsplit(Sel_String,"||")
            Delim:=(SubStr(Folder, -1 )!="\"?"\":"")
            RenamedImage:=Folder  Delim Sel_Arr[3] "." script.config.Config.filetype
            scriptWorkingDir:=renameFile(RenamedImage,Sel_Arr[2],true,Sel_Index,Sel.Count())
            Log.=RenamedImage " - " Sel_Arr[2] "`n"
            FilestoCopy.=RenamedImage "`n"
        }
        writeFile(scriptWorkingDir "\gfa_renamer_log.txt",Log, "UTF-8-RAW","w",true)    ;; ensure the log-file is written as UTF-8, in case there are unicode characters in any groupname. Just a precaution
    } else {
        Log:="Expected Number of images: " Arr.Count() "`nFound Number of images: " Arr.Count() "`n"
        Loop, Files, % Folder "\*." script.config.Config.filetype, F
            {
                scriptWorkingDir:=renameFile(A_LoopFileFullPath,Arr[A_Index],true,A_Index,TrueNumberOfFiles)
                Log.=A_LoopFileFullPath " - " Arr[A_Index] "`n"
                FilestoCopy.=A_LoopFileFullPath "`n"
            if (TEST_FOLDERPATH!="") {
                Folder:=TEST_FOLDERPATH
        }
        writeFile(scriptWorkingDir "\gfa_renamer_log.txt",Log, "UTF-8-RAW","w",true)
    }
    ttip(script.name " - Finished running")
    OnMessage(0x44, "OnMsgBox2")
    MsgBox 0x40, % script.name " -  Script finished",% "The script finished running.`nThe folder containing the renamed images will open once this message box is closed.`n`nA log mapping each image to its new name is given in the file 'gfa_renamer_log.txt' within the output directory 'GFAR_WD'. The original image files are preserved in the original folder."
    OnMessage(0x44, "")

    if (WinExist(scriptWorkingDir " ahk_exe explorer.exe")) {
        WinActivate
        return
    } 
    Else {
        run, % scriptWorkingDir
    }
    ExitApp
    return
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
MsgBoxCallback3() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        ControlSetText Button1, OK
        ControlSetText Button2, Go to Github
    }
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




#Include, <Base64PNG_to_HICON>
#include, <ini>
#Include, <CountFilesR>
    #Include, <Hash_File>
#Include, <script>
#Include, <TestDataset>
#Include, <ttip>
#Include, <AutoMoveToStick>
#Include, <ClipboardSetFiles>
#Include, <Object_HashmapHash>



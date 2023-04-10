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
creditsRaw=
(LTRIM
icons8    -  Icon - https://icons8.com/icon/Ou81cXLcsZzX/potted-plant"
Gewerd Strauss   -		 main script
anonymous1184   -       Ini.ahk, License (waiting for explicit file to be added)        -       https://gist.github.com/anonymous1184/737749e83ade98c84cf619aabf66b063,https://gist.github.com/anonymous1184/737749e83ade98c84cf619aabf66b063?permalink_comment_id=4525104#gistcomment-4525104
author2,author3   -		 snippetName1		   		  			-	URL2,URL3
Gewerd Strauss      -   partial, self-written subset of ScriptObj						    - https://github.com/Gewerd-Strauss/ScriptObj/blob/master/ScriptObj.ahk
Base64PNG_to_HICON  - SKAN, regarding licensing             -   https://www.autohotkey.com/boards/viewtopic.php?f=6&t=36636, https://www.autohotkey.com/board/topic/75906-about-my-scripts-and-snippets/
Gewerd Strauss - ttip
)


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
                    ,credits      : CreditsRaw
                    ,creditslink  : ""
                    ,email        : "csa-07@freenet.de"
                    ,crtdate      : CrtDate
                    ,moddate      : ModDate
                    ,homepagetext : ""
                    ,homepagelink : ""
                    ,ghtext 	  : "GH-Repo"
                    ,ghlink       : "https://github.com/Gewerd-Strauss/REPOSITORY_NAME"
                    ,doctext	  : ""
                    ,doclink	  : ""
                    ,forumtext	  : ""
                    ,forumlink	  : ""
                    ,donateLink	  : ""
                    ,resfolder    : A_ScriptDir "\res"
                    ,iconfile	  : ""
;					  ,reqInternet: false
                    ,rfile  	  : "https://github.com/Gewerd-Strauss/REPOSITORY_NAME/archive/refs/heads/BRANCH_NAME.zip"
                    ,vfile_raw	  : "https://raw.githubusercontent.com/Gewerd-Strauss/REPOSITORY_NAME/BRANCH_NAME/version.ini" 
                    ,vfile 		  : "https://raw.githubusercontent.com/Gewerd-Strauss/REPOSITORY_NAME/BRANCH_NAME/version.ini" 
                    ,vfile_local  : A_ScriptDir "\version.ini" 
;					,DataFolder:	A_ScriptDir ""
                    ,config:		[]
                    ,configfile   : A_ScriptDir "\INI-Files\" regexreplace(A_ScriptName, "\.\w+") ".ini"
                    ,configfolder : A_ScriptDir "\INI-Files"}
;; 


script.SetIcon("iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAYAAAA6/NlyAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAARISURBVGhD7dtLbxNXGMbxbFh2yRIpzkWQgpIUKFAVibCBknIJqCFOZNIbJg0Xp7ikkAAh4SJoCxUENiBgW6ktUldIKQURbmpAIkSiqlqg6gcAvsLLPPPKVjp5bM/xnAllMpb+K4/PeX9yjj1epGKmPpqcBmdAcLqPwcrKSol6cCo3BkczOJUbg6MZnMqNwdEMTuXG4GgGp3JjcDSDU7kG4OzvJ+TAs3NT6p04Kd1XB6TtbJc0fbZGaupq6etNqplX666VPNflrH1QesdP0b2/evAtfb03OJVrAext7x/fS9vwNlnwXiNdp1gLljXI5jNpdw22trdQwZnRI3TTQvX/NSwth1NSVVNF15tcorpKNgylZN+fp+lahfry7jG6njc4lWsAxp8W27RU237pk7kNdXRNNLe+TtJX9tHXlmr7yEG6pjc4lWsATl3aRTf1E96JhhWLp6xZv3yh9Nw+Sl/jp87LPVPWZMGpXANw89etdFO/ZcdOyPwl9fn18M6aHhNvH/a1/WfGQsGpXAPwwlVL6aYmdV89INW11e6ZTV/ZS68xadHqZXRWb3Aq1wCMMjcP041NWru/XdYPdNDnTMqMHpVEIkHn9Aancg3BH2Q30c1Nyj46Lnsef0OfM2lVz0Y6IwtO5RqCcUOQfXCcDuC39P1dkh4r/wMQZW4e8/V1lwtO5RqC0crPm+kQfup/Oizt1zZJ8teN0v/kLL3GTys+WU1nKxScyi0DjFIXd9JBSpWZOCRtI+vdMhMD9JpS4euRzVQsOJVbJhh/2uXciKTHdubBW8d20GuKhT3LuVeHU7llghG+R/E1wwYrVOetzjy4c/Rjek2h8ANlXuPbdJZSwancAGCEd3rL5QwdkNVxvTUP7vjN/41MytkjyK8wOJUbEJwLH2S4fWTDTi55rSUPTo600GsmhzVXbm2me5oEp3ItgRHuoNbs+Uh23yv8MzKHzbX/2TC9Dms097a6a7K9TINTuRbBuRJVCVmy7n3ZMJiST3/IundEvY9OSt/fZ6aA+5yfkHgO1+BavAavxRps7XKDU7khgIvlfSfZNWEEp3JjcLi9seCXdypea2ymYsGp3BjsLzbEdMZmKhacyg0AfnGjQv4Zchqcppy9nl9/jWD073dksJDCXrl92UzFglO5ZYJznR96Kz9E2GEvNoOf4FRuQPAX7bPpcGHUlZxNZ/ATnMoNCF7UOEee3+ID2u7dd+bQGfwEp3IDgtH4j7PogDZ7+NMsurff4HS1ziMw+MI0nOMg5xfBqVwL4O6O8M8xPivY3n6DU7kWwIudc8yGtFmQ84vgVK4FMArzHGNttqdJcLpa52EFfPFIeOcYnxFsT5PgVK4lcJjnGGuzPU2CU7mWwGGe46DnF8GpXEtgNP6z/XNs4/wiOF2t87AGDuMcY022l2lwKtci+P8cnMqNwdEMTuXG4GgGp3JjcDSDU7kz5j/TKppeAamEQurI/tgFAAAAAElFTkSuQmCC")



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

; --uID:2942823315
 ; Metadata:
  ; Snippet: Base64PNG_to_HICON  ;  (v.1.0)
  ; --------------------------------------------------------------
  ; Author: SKAN
  ; License: Custom public domain/conditionless right of use for any purpose
  ; LicenseURL:  https://www.autohotkey.com/board/topic/75906-about-my-scripts-and-snippets/
  ; Source: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=36636
  ; (03.09.2017)
  ; --------------------------------------------------------------
  ; Library: Libs
  ; Section: 23 - Other
  ; Dependencies: Windows VISTA and above
  ; AHK_Version: 1.0
  ; --------------------------------------------------------------
  ; Keywords: Icon Base64

 ;; Description:
  ;; Parameters Width and Height are optional. Either omit them (to load icon in original dimensions) or specify both of them.
  ;; PNG decompression for Icons was introduced in WIN Vista
  ;; ICONs needn't be SQUARE
  ;; Passing fIcon parameter as false to CreateIconFromResourceEx() function, should create a hCursor (not tested)
  ;; Thanks to @Helgef and @just me me in ask-for-help topic: Anybody using Menu, Tray, Icon, HICON:%hIcon% ?
  ;; Thanks to @jeeswg for providing the formula to calculate Base64 data size.
  ;; Related:
  ;;     Base64 encoder/decoder for Binary data - https://autohotkey.com/boards/viewtopic.php?t=35964
  ;;     Base64ToComByteArray() :: Include image in script and display it with WIA 2.0 - https://autohotkey.com/boards/viewtopic.php?t=36124
  ;; 
  ;; 

 ;;; Example:
  ;;; #NoEnv
  ;;; #SingleInstance, Force
  ;;; 
  ;;; Base64PNG := "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAAflBMVEXOgwD///+AUQDz5NSTXQD"
  ;;; . "j3NSliWe7dwCnagDGtaPnx6Pbp2eGVQDt1rz6+PXRjSTJgADCewCycQCeZADkwJbhuIf58ur06t/qzrDesHirb"
  ;;; . "QDw3ci0nILYn1TVlj+KYSSiZwCYYQCOWgDVyby+q5acfFSTbz/u4dTc08jNv7D3Mcn0AAACq0lEQVR42uzaXW/"
  ;;; . "aMBSA4WMn4JAQyAff0A5o123//w/OkSallUblSDm4qO9759zYfo4vI0RERERERERERERERERERERERB97Kva5L"
  ;;; . "3lX6deroljKXVoWxcpvWCbv2vkP++JJdFvud8nCfFZSrlQP8bwqE/NZiyTfa82hOJqgNrkotd6YoI6FKFSa4LY"
  ;;; . "qM1huTXCljN7aGIX9dSbgW8vYJWZIopAZUgIAAADEBHCuigvwy9VRAawvbQ91NICJP8A8zZoqIkDXPIsG8K+Li"
  ;;; . "wngu1ZRAXxtXADbxgawTVwAGx0gBQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  ;;; . "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADgI8BDBQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  ;;; . "AAAAAD6AFOFHgrAKgQAAAAAAAAAADwegBuphwX4ln+KAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  ;;; . "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPA1AY5mQAsNgIUZ0O/RAQozoJkGQ"
  ;;; . "G4GNB0dQNbhE/hjNQBkF/4CT3Z8AFmutkGbv/y0OgDyvNuYgLavP6wGQGdQ5GVy+xCTyezU3V4LoDNY50lyG3/"
  ;;; . "yMpt2t1cB6EunvtOsr1u/2RuJQm9T36zv1S/7m+sD2CGJQva/AQDAnQAudkBzUWhuB3SRsXN2QJkolNkBORm9J"
  ;;; . "nwCZ1HpHP4CG1GoOlyDNm9rUao+Bw3heqhEqcplbXr7EGmaNbWoVjdZmt7GT9vMVaKf8zVZn/PVcsdq58v6Ds5"
  ;;; . "XCRERERER/W0PDgkAAAAABP1/bfQEAAAAAAAL2VmKC7LwdTIAAAAASUVORK5CYII="
  ;;; 
  ;;; Gui, Add, Picture,, % "HICON:" Base64PNG_to_HICON(Base64PNG)
  ;;; Gui, Show,, Base64PNG_to_HICON() DEMO 
  ;;; Return 
  ;;; 
  ;;; ; Copy and paste Base64PNG_to_HICON() below
  ;;; 

 Base64PNG_to_HICON(Base64PNG, W:=0, H:=0) {     ;   By SKAN on D094/D357 @ tiny.cc/t-36636
 Local BLen:=StrLen(Base64PNG), Bin:=0,     nBytes:=Floor(StrLen(RTrim(Base64PNG,"="))*3/4)                     
   Return DllCall("Crypt32.dll\CryptStringToBinary", "Str",Base64PNG, "UInt",BLen, "UInt",1
             ,"Ptr",&(Bin:=VarSetCapacity(Bin,nBytes)), "UIntP",nBytes, "UInt",0, "UInt",0)
        ? DllCall("CreateIconFromResourceEx", "Ptr",&Bin, "UInt",nBytes, "Int",True, "UInt"
                  ,0x30000, "Int",W, "Int",H, "UInt",0, "UPtr") : 0            
 }
 


 ; License:

  ; License could not be copied, please retrieve manually from 'https://www.autohotkey.com/board/topic/75906-about-my-scripts-and-snippets/'
  ; Warning: Dependency 'Windows VISTA and above' may not be included. In that case, please search for it separately, or refer to the documentation.


; --uID:2942823315

; --uID:4291014243
 ; Metadata:
  ; Snippet: Ini.ahk  ;  (v.2022.07.01.1)
  ; --------------------------------------------------------------
  ; Author: anonymous1184
  ; Source: https://gist.github.com/anonymous1184/737749e83ade98c84cf619aabf66b063
  ; 
  ; --------------------------------------------------------------
  ; Library: Personal Library
  ; Section: 23 - Other
  ; Dependencies: /
  ; AHK_Version: v1
  ; --------------------------------------------------------------
  ; Keywords: config handling

 ;; Description:
  ;; https://gist.github.com/anonymous1184/737749e83ade98c84cf619aabf66b063
  ;; https://www.reddit.com/r/AutoHotkey/comments/s1it4j/automagically_readwrite_configuration_files/

 
 ; Version: 2022.11.08.1
 ; Usages and examples: https://redd.it/s1it4j
 
 Ini(Path, Sync:=true) {
    return new Ini_File(Path, Sync)
 }

 ; Version: 2022.11.08.1
 
 class Object_Proxy {
 
     ;region Public
 
     Clone() {
         clone := new Object_Proxy()
         clone.__data := this.__data.Clone()
         return clone
     }
 
     Count() {
         return this.__data.Count()
     }
 
     Delete(Parameters*) {
         return this.__data.Delete(Parameters*)
     }
 
     GetAddress(Key) {
         return this.__data.GetAddress(Key)
     }
 
     GetCapacity(Parameters*) {
         return this.__data.GetCapacity(Parameters*)
     }
 
     HasKey(Key) {
         return this.__data.HasKey(Key)
     }
 
     Insert(Parameters*) {
         throw Exception("Deprecated.", -1, A_ThisFunc)
     }
 
     InsertAt(Parameters*) {
         this.__data.InsertAt(Parameters*)
     }
 
     Length() {
         return this.__data.Length()
     }
 
     MaxIndex() {
         return this.__data.MaxIndex()
     }
 
     MinIndex() {
         return this.__data.MinIndex()
     }
 
     Pop() {
         return this.__data.Pop()
     }
 
     Push(Parameters*) {
         return this.__data.Push(Parameters*)
     }
 
     Remove(Parameters*) {
         throw Exception("Deprecated.", -1, A_ThisFunc)
     }
 
     RemoveAt(Parameters*) {
         return this.__data.RemoveAt(Parameters*)
     }
 
     SetCapacity(Parameters*) {
         return this.__data.SetCapacity(Parameters*)
     }
     ;endregion
 
     ;region Private
 
     _NewEnum() {
         return this.__data._NewEnum()
     }
     ;endregion
 
     ;region Meta
 
     __Get(Parameters*) ; Key[, Key...]
     {
         return this.__data[Parameters*]
     }
 
     __Init() {
         ObjRawSet(this, "__data", {})
     }
 
     __Set(Parameters*) ; Key, Value[, Value...]
     {
         value := Parameters.Pop()
         this.__data[Parameters*] := value
         return value
     }
     ;endregion
 
 }


 class Ini_File extends Object_Proxy {
 
     ;region Public
 
     Persist() {
         IniRead buffer, % this.__path
         sections := {}
         for _,name in StrSplit(buffer, "`n")
             sections[name] := true
         for name in this.__data {
             this[name].Persist()
             sections.Delete(name)
         }
         for name in sections
             IniDelete % this.__path, % name
     }
 
     Sync(Set:="") {
         if (Set = "")
             return this.__sync
         for name in this
             this[name].Sync(Set)
         return this.__sync := !!Set
     }
     ;endregion
 
     ;region Overload
 
     Delete(Name) {
         if (this.__sync)
             IniDelete % this.__path, % Name
     }
     ;endregion
 
     ;region Meta
 
     __New(Path, Sync) {
         ObjRawSet(this, "__path", Path)
         ObjRawSet(this, "__sync", false)
         IniRead buffer, % Path
         for _,name in StrSplit(buffer, "`n") {
             IniRead data, % Path, % name
             this[name] := new Ini_Section(Path, name, data)
         }
         this.Sync(Sync)
     }
 
     __Set(Key, Value) {
         isObj := IsObject(Value)
         base := isObj ? ObjGetBase(Value) : false
         if (isObj && !base)
         || (base && base.__Class != "Ini_Section") {
             path := this.__path
             sync := this.__sync
             this[Key] := new Ini_Section(path, Key, Value, sync)
             return obj ; Stop, hammer time!
         }
     }
     ;endregion
 
 }
 
 class Ini_Section extends Object_Proxy {
 
     ;region Public
 
     Persist() {
         IniRead buffer, % this.__path, % this.__name
         keys := {}
         for _,key in StrSplit(buffer, "`n") {
             key := StrSplit(key, "=")[1]
             keys[key] := true
         }
         for key,value in this {
             keys.Delete(key)
             value := StrLen(value) ? " " value : ""
             IniWrite % value, % this.__path, % this.__name, % key
         }
         for key in keys
             IniDelete % this.__path, % this.__name, % key
     }
 
     Sync(Set:="") {
         if (Set = "")
             return this.__sync
         return this.__sync := !!Set
     }
     ;endregion
 
     ;region Overload
 
     Delete(Key) {
         if (this.__sync)
             IniDelete % this.__path, % this.__name, % key
     }
     ;endregion
 
     ;region Meta
 
     __New(Path, Name, Data, Sync:=false) {
         ObjRawSet(this, "__path", Path)
         ObjRawSet(this, "__name", Name)
         ObjRawSet(this, "__sync", Sync)
         if (!IsObject(Data))
             Ini_ToObject(Data)
         for key,value in Data
             this[key] := value
     }
 
     __Set(Key, Value) {
         if (this.__sync) {
             Value := StrLen(Value) ? " " Value : ""
             IniWrite % Value, % this.__path, % this.__name, % key
         }
     }
     ;endregion
 
 }
 
 ;region Auxiliary
 
 Ini_ToObject(ByRef Data) {
     info := Data, Data := {}
     for _,pair in StrSplit(info, "`n") {
         pair := StrSplit(pair, "=",, 2)
         Data[pair[1]] := pair[2]
     }
 }
 ;endregion
 ; License:

  ; MIT License
  ; 
  ; Permission is hereby granted, free of charge, to any person obtaining a copy
  ; of this software and associated documentation files (the "Software"), to deal
  ; in the Software without restriction, including without limitation the rights
  ; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  ; copies of the Software, and to permit persons to whom the Software is
  ; furnished to do so, subject to the following conditions:
  ; 
  ; The above copyright notice and this permission notice shall be included in all
  ; copies or substantial portions of the Software.
  ; 
  ; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  ; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  ; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  ; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  ; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  ; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  ; SOFTWARE.
  ; 


; --uID:4291014243

class script {
    
    About() {
        /**
        Function: About
        Shows a quick HTML Window based on the object's variable information

        Parameters:
        scriptName   (opt) - Name of the script which will be
                             shown as the title of the window and the main header
        version      (opt) - Script Version in SimVer format, a "v"
                             will be added automatically to this value
        author       (opt) - Name of the author of the script
        credits 	 (opt) - Name of credited people
        ghlink 		 (opt) - GitHubLink
        ghtext 		 (opt) - GitHubtext
        doclink 	 (opt) - DocumentationLink
        doctext 	 (opt) - Documentationtext
        forumlink    (opt) - forumlink
        forumtext    (opt) - forumtext
        homepagetext (opt) - Display text for the script website
        homepagelink (opt) - Href link to that points to the scripts
                             website (for pretty links and utm campaing codes)
        donateLink   (opt) - Link to a donation site
        email        (opt) - Developer email

        Notes:
        The function will try to infer the paramters if they are blank by checking
        the class variables if provided. This allows you to set all information once
        when instatiating the class, and the about GUI will be filled out automatically.
        */
        static doc
        scriptName := scriptName ? scriptName : this.name
        , version := version ? version : this.version
        , author := author ? author : this.author
        , credits := credits ? credits : this.credits
        , creditslink := creditslink ? creditslink : RegExReplace(this.creditslink, "http(s)?:\/\/")
        , ghtext := ghtext ? ghtext : RegExReplace(this.ghtext, "http(s)?:\/\/")
        , ghlink := ghlink ? ghlink : RegExReplace(this.ghlink, "http(s)?:\/\/")
        , doctext := doctext ? doctext : RegExReplace(this.doctext, "http(s)?:\/\/")
        , doclink := doclink ? doclink : RegExReplace(this.doclink, "http(s)?:\/\/")
        , forumtext := forumtext ? forumtext : RegExReplace(this.forumtext, "http(s)?:\/\/")
        , forumlink := forumlink ? forumlink : RegExReplace(this.forumlink, "http(s)?:\/\/")
        , homepagetext := homepagetext ? homepagetext : RegExReplace(this.homepagetext, "http(s)?:\/\/")
        , homepagelink := homepagelink ? homepagelink : RegExReplace(this.homepagelink, "http(s)?:\/\/")
        , donateLink := donateLink ? donateLink : RegExReplace(this.donateLink, "http(s)?:\/\/")
        , email := email ? email : this.email
        
         if (donateLink)
        {
            donateSection =
            (
                <div class="donate">
                    <p>If you like this tool please consider <a href="https://%donateLink%">donating</a>.</p>
                </div>
                <hr>
            )
        }

        html =
        (
            <!DOCTYPE html>
            <html lang="en" dir="ltr">
                <head>
                    <meta charset="utf-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <style media="screen">
                        .top {
                            text-align:center;
                        }
                        .top h2 {
                            color:#2274A5;
                            margin-bottom: 5px;
                        }
                        .donate {
                            color:#E83F6F;
                            text-align:center;
                            font-weight:bold;
                            font-size:small;
                            margin: 20px;
                        }
                        p {
                            margin: 0px;
                        }
                    </style>
                </head>
                <body>
                    <div class="top">
                        <h2>%scriptName%</h2>
                        <p>v%version%</p>
                        <hr>
                        <p>by %author%</p>
        )
        if ghlink and ghtext
        {
            sTmp=
            (

                        <p><a href="https://%ghlink%" target="_blank">%ghtext%</a></p>
            )
            html.=sTmp
        }
        if doclink and doctext
        {
            sTmp=
            (

                        <p><a href="https://%doclink%" target="_blank">%doctext%</a></p>
            )
            html.=sTmp
        }
        ; Clipboard:=html
        if (creditslink and credits) || IsObject(credits) || RegexMatch(credits,"(?<Author>(\w|)*)(\s*\-\s*)(?<Snippet>(\w|\|)*)\s*\-\s*(?<URL>.*)")
        {
            if RegexMatch(credits,"(?<Author>(\w|)*)(\s*\-\s*)(?<Snippet>(\w|\|)*)\s*\-\s*(?<URL>.*)")
            {
                CreditsLines:=strsplit(credits,"`n")
                Credits:={}
                for k,v in CreditsLines
                {
                    if ((InStr(v,"author1") && InStr(v,"snippetName1") && InStr(v,"URL1")) || (InStr(v,"snippetName2|snippetName3")) || (InStr(v,"author2,author3") && Instr(v, "URL2,URL3")))
                        continue
                    val:=strsplit(strreplace(v,"`t"," ")," - ")
                    Credits[Trim(val.2)]:=Trim(val.1) "|" Trim((strlen(val.3)>5?val.3:""))
                }
            }
            ; Clipboard:=html
            if IsObject(credits)  
            {
                if (1<0)
                {

                    if (credits.Count()>0)
                    {
                        CreditsAssembly:="credits for used code:`n"
                        for k,v in credits
                        {
                            if (k="")
                                continue
                            if (strsplit(v,"|").2="")
                                CreditsAssembly.="<p>" k " - " strsplit(v,"|").1 "`n"
                            else
                                CreditsAssembly.="<p><a href=" """" strsplit(v,"|").2 """" ">" k " - " strsplit(v,"|").1 "</a></p>`n"
                        }
                        html.=CreditsAssembly
                        ; Clipboard:=html
                    }
                }
                else
                {
                    if (credits.Count()>0)
                    {
                        CreditsAssembly:="credits for used code:`n"
                        for Author,v in credits
                        {
                            if (k="")
                                continue
                            if (strsplit(v,"|").2="")
                                CreditsAssembly.="<p>" Author " - " strsplit(v,"|").1 "`n"
                            else
                            {
                                Name:=strsplit(v,"|").1
                                Credit_URL:=strsplit(v,"|").2
                                if Instr(Author,",") && Instr(Credit_URL,",")
                                {
                                    tmpAuthors:=""
                                    AllCurrentAuthors:=strsplit(Author,",")
                                    for s,w in strsplit(Credit_URL,",")
                                    {
                                        currentAuthor:=AllCurrentAuthors[s]
                                        tmpAuthors.="<a href=" """" w """" ">" trim(currentAuthor) "</a>"
                                        if (s!=AllCurrentAuthors.MaxIndex())
                                            tmpAuthors.=", "
                                    }
                                    CreditsAssembly.=Name " - <p>" tmpAuthors "</p>"  "`n" ;; figure out how to force this to be on one line, instead of the mess it is right now.
                                }
                                else
                                    CreditsAssembly.="<p><a href=" """" Credit_URL """" ">" Author " - " Name "</a></p>`n"
                            }
                        }
                        html.=CreditsAssembly
                        ; Clipboard:=html
                    }
                }
            }
            else
            {
                sTmp=
                (
                            <p>credits: <a href="https://%creditslink%" target="_blank">%credits%</a></p>
                            <hr>
                )
                html.=sTmp
            }
            ; Clipboard:=html
        }
        if forumlink and forumtext
        {
            sTmp=
            (

                        <p><a href="https://%forumlink%" target="_blank">%forumtext%</a></p>
            )
            html.=sTmp
            ; Clipboard:=html
        }
        if homepagelink and homepagetext
        {
            sTmp=
            (

                        <p><a href="https://%homepagelink%" target="_blank">%homepagetext%</a></p>

            )
            html.=sTmp
            ; Clipboard:=html
        }
        sTmp=
        (

                                </div>
                    %donateSection%
                </body>
            </html>
        )
        html.=sTmp
         btnxPos := 300/2 - 75/2
        , axHight:=12
        , donateHeight := donateLink ? 6 : 0
        , forumHeight := forumlink ? 1 : 0
        , ghHeight := ghlink ? 1 : 0
        , creditsHeight := creditslink ? 1 : 0
        , creditsHeight+= (credits.Count()>0)?credits.Count()*1.5:0 ; + d:=(credits.Count()>0?2.5:0)
        , homepageHeight := homepagelink ? 1 : 0
        , docHeight := doclink ? 1 : 0
        , axHight+=donateHeight
        , axHight+=forumHeight
        , axHight+=ghHeight
        , axHight+=creditsHeight
        , axHight+=homepageHeight
        , axHight+=docHeight
        if (axHight="")
            axHight:=12
        gui aboutScript:new, +alwaysontop +toolwindow, % "About " this.name
        gui margin, 2
        gui color, white
        gui add, activex, w500 r%axHight% vdoc, htmlFile
        gui add, button, w75 x%btnxPos% gaboutClose, % "&Close"
        doc.write(html)
        gui show, AutoSize
        return

        aboutClose:
        gui aboutScript:destroy
        return
    }
    SetIcon(Param:=true)
    {

            /**
            Function: SetIcon
            TO BE DONE: Sets iconfile as tray-icon if applicable

            Parameters:
            Option - Option to execute
                    Set 'true' to set this.res "\" this.iconfile as icon
                    Set 'false' to hide tray-icon
                    Set '-1' to set icon back to ahk's default icon
                    Set 'pathToIconFile' to specify an icon from a specific path
                    Set 'dll,iconNumber' to use the icon extracted from the given dll - NOT IMPLEMENTED YET.
            
            Examples:
            ; 
            ; script.SetIcon(0) 									;; hides icon
            ; ttip("custom from script.iconfile",5)
            script.SetIcon(1)										;; custom from script.iconfile
            ; ttip("reset ahk's default",5)
            ; script.SetIcon(-1)									;; ahk's default icon
            ; ttip("set from path",5)
            ; script.SetIcon(PathToSpecificIcon)					;; sets icon specified by path as icon

            e.g. '1.0.0'

            For more information about SemVer and its specs click here: <https://semver.org/>
        */
        if (!Instr(Param,":/")) { ;; assume not a path because not a valid drive letter
            fTraySetup(Param)
        }
        else if (Param=true)
        { ;; set script.iconfile as icon, shows icon
            Menu, Tray, Icon,% this.resfolder "\" this.iconfile ;; this does not work for unknown reasons
            menu, tray, Icon
            ; menu, tray, icon, hide
            ;; menu, taskbar, icon, % this.resfolder "/" this.iconfilea
        }
        else if (Param=false)
        { ;; set icon to default ahk icon, shows icon

            ; ttip_ScriptObj("Figure out how to hide autohotkey's icon mid-run")
            menu, tray, NoIcon
        }
        else if (Param=-1)
        { ;; hide icon
            Menu, Tray, Icon, *

        }
        else ;; Param=path to custom icon, not set up as script.iconfile
        { ;; set "Param" as path to iconfile
            ;; check out GetWindowIcon & SetWindowIcon in AHK_Library
            if !FileExist(Param)
            {
                try
                    throw exception("Invalid  Icon-Path '" Param "'. Check the path provided.","script.SetIcon()","T")
                Catch, e
                    msgbox, 8240,% this.Name " > scriptObj -  Invalid ressource-path", % e.Message "`n`nPlease provide a valid path to an existing file. Resuming normal operation."
            }
                
            Menu, Tray, Icon,% Param
            menu, tray, Icon
        }
        return
    }
}

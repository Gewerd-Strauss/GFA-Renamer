lp:=generateTestDataset()
;lp:="D:\Dokumente neu\000 AAA Dokumente\000 AAA HSRW\General\AHK scripts\Projects\GFA_Renamer\Lib\Test\tmp.zip"
Unz(lp,A_ScriptDir . "\Test\")
return

generateTestDataset(URL:="https://gist.github.com/Gewerd-Strauss/d944d8abc295253ced401493edd377f2/archive/0d46c65c3993b1e8eef113776b68190e0802deb5.zip",local_path:="") {
    if (local_path="") {
        local_path:=A_ScriptDir "\Test"
    }
    if Instr(FileExist(local_path),"D") {
        FileRemoveDir, local_path
    }
    if (URL="") {
        return -1
    }
    if !Instr(FileExist(local_path),"D")
        FileCreateDir, % local_path
    OutputDebug, % URL "`n`n`n" local_path (SubStr(local_path,0,1)="\"?"":"\") "tmp.zip"
    
    UrlDownloadToFile, % URL, % out:=local_path "\tmp.zip"
    if FileExist(out) {
        return out
    } else {
        return ErrorLevel
    }
}


;; --------- 	EXAMPLE CODE	-------------------------------------
FilesToZip = D:\Projects\AHK\_Temp\Test\  ;Example of folder to compress
; FilesToZip = D:\Projects\AHK\_Temp\Test\*.ahk  ;Example of wildcards to compress
; FilesToZip := A_ScriptFullPath   ;Example of file to compress
sZip := A_ScriptDir . "\Test.zip"  ;Zip file to be created
sUnz := A_ScriptDir . "\ext\"      ;Directory to unzip files

Zip(FilesToZip,sZip)
Sleep, 500
Unz(sZip,sUnz)
;; --------- 	END EXAMPLE 	-------------------------------------



;; ----------- 	THE FUNCTIONS   -------------------------------------
Zip(FilesToZip,sZip)
{
    /* Options for zipping/unzipping
        4 Do not display a progress dialog box.
        8 Give the file being operated on a new name in a move, copy, or rename operation if a file with the target name already exists.
        16 Respond with "Yes to All" for any dialog box that is displayed.
        64 Preserve undo information, if possible.
        128 Perform the operation on files only if a wildcard file name (*.*) is specified.
        256 Display a progress dialog box but do not show the file names.
        512 Do not confirm the creation of a new directory if the operation requires one to be created.
        1024 Do not display a user interface if an error occurs.
        2048 Version 4.71. Do not copy the security attributes of the file.
        4096 Only operate in the local directory. Don't operate recursively into subdirectories.
        9182 Version 5.0. Do not move connected files as a group. Only move the specified files.
    */
    If Not FileExist(sZip)
        CreateZipFile(sZip)
    psh := ComObjCreate( "Shell.Application" )
    pzip := psh.Namespace( sZip )
    if InStr(FileExist(FilesToZip), "D")
        FilesToZip .= SubStr(FilesToZip,0)="\" ? "*.*" : "\*.*"
    loop,%FilesToZip%,1
    {
        zipped++
        ToolTip Zipping %A_LoopFileName% ..
        pzip.CopyHere( A_LoopFileLongPath, 4|16 )
        Loop
        {
            done := pzip.items().count
            if done = %zipped%
                break
        }
        done := -1
    }
    ToolTip
}

CreateZipFile(sZip)
{
	Header1 := "PK" . Chr(5) . Chr(6)
	VarSetCapacity(Header2, 18, 0)
	file := FileOpen(sZip,"w")
	file.Write(Header1)
	file.RawWrite(Header2,18)
	file.close()
}

Unz(sZip, sUnz)
{
    /* Options for zipping/unzipping
        4 Do not display a progress dialog box.
        8 Give the file being operated on a new name in a move, copy, or rename operation if a file with the target name already exists.
        16 Respond with "Yes to All" for any dialog box that is displayed.
        64 Preserve undo information, if possible.
        128 Perform the operation on files only if a wildcard file name (*.*) is specified.
        256 Display a progress dialog box but do not show the file names.
        512 Do not confirm the creation of a new directory if the operation requires one to be created.
        1024 Do not display a user interface if an error occurs.
        2048 Version 4.71. Do not copy the security attributes of the file.
        4096 Only operate in the local directory. Don't operate recursively into subdirectories.
        9182 Version 5.0. Do not move connected files as a group. Only move the specified files.
    */
    SplitPath, % sZip, , OutDir,
    fso := ComObjCreate("Scripting.FileSystemObject")
    If Not fso.FolderExists(sUnz)  ;http://www.autohotkey.com/forum/viewtopic.php?p=402574
       fso.CreateFolder(sUnz)
    psh  := ComObjCreate("Shell.Application")
    zippedItems := psh.Namespace( sZip ).items().count
    psh.Namespace( sUnz ).CopyHere( psh.Namespace( sZip ).items, 256 )
    Loop {
        sleep 50
        OutDir_noslash:=Regexreplace(OutDir,"\\$","")
        sUnz_noslash:=Regexreplace(sUnz,"\\$","")
        unzippedItems := psh.Namespace( sUnz ).items().count
        ToolTip Unzipping in progress..
        if (unzippedItems>zippedItems) && (OutDir_noslash=sUnz_noslash) ;; guard against the zip folder counting towards the total if items are extracted next to the containing folder.
            break
        if (unzippedItems=zippedItems) && (OutDir_noslash!=sUnz_noslash)
            break
    }
    ToolTip
}
;; ----------- 	END FUNCTIONS   -------------------------------------
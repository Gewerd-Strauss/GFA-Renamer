setTestset(Folder,Names:="",PlantsPerGroup:="") {
    ttip("Looking for testset data folder",5)
    sleep, 1200
    if !FileExist(A_ScriptDir "\assets\Image Test Files Source\tmp.zip") { ;; zipped source folder does not exist, download it again from the public repo.
        ttip("Validating Internet connection for download...",5)
        sleep, 1200
        if (script.requiresInternet(,true)) {
            ttip("Downloading Set of Test-Images...",5)
            lp:=downloadTestset(script.config.TestSet.URL,A_ScriptDir "\assets\Image Test Files Source\") ;; download the data
            sleep, 1200


            
            ttip("Confirming checksum")
            OldHash:=script.config.TestSet.Hash
            Clipboard:=NewHash:=Hash_File(lp,"sha512")
            bIsAuthor:=(script.computername=script.authorID)
            if (OldHash!=NewHash){
                MsgBox 0x42034,% script.name " - Test Dataset Validation failed - checksums differ" , Notice:`n`nThe file-validation failed on the downloaded zip directory containing the example files.`n`n`nThis is not necessarily wrong or bad`, but should be known. `n`nDid you change the remote file to download from (see config file -> TestSet -> URL)?`n`n`n`nIf this is intended`, press okay to confirm the new file. If not`, presss continue to use this unvalidated set without confirming it.`n`nConfirming it will check against this files' checksum when downloading the testset in the future. THerefore`, if you want to use your own testset and set it in the config file`, you should confirm this messagebox if it came up afterwards.

                IfMsgBox Yes, {
                    script.config.TestSet.Hash:=NewHash
                    script.save()
                } Else IfMsgBox No, {
                }
                
            }
            
        } else {
            Text := "No connection could be established, the application is unable to download the Testset.`n`n`nPlease try again after solving the connection issues.`nThe application will exit now."

            Result := MsgBoxEx(Text, "script.name "" - No Internet connection""", "OK", 4)

            If (Result == "OK") {
                ExitApp,
            } Else If (Result == "Cancel") {
                ExitApp,
            }



        }


        
    } else {

        lp:=A_ScriptDir "\assets\Image Test Files Source\tmp.zip"
    }

    ttip("Unpacking Testset...",5)
    ret:=Unz(strreplace(lp,"\\","\"),test_folder:=A_ScriptDir "\assets\Image Test Files") ; unpack it.
    OutputDebug, % test_folder
    Loop, Files, % test_folder "\*.md", FR ;; remove the "about-this-gist.md"-file
    {
        FileDelete, % A_LoopFileFullPath
    }

        
        
    ; }

    ;; clean up the testset.
    if (Instr(FileExist(A_ScriptDir "\assets\Image Test Files\GFAR_WD"),"D")) {
        FileRecycle, % A_ScriptDir "\assets\Image Test Files\GFAR_WD"
    }
    Loop, Files, % Folder "\*." script.config.Config.filetype, FR
    {
        if InStr(A_LoopFileFullPath,"(padding)") {
            FileRecycle, % A_LoopFileFullPath
            continue
        }
    }

    guicontrol, GFAR:, Folder, % Folder
    guicontrol, GFAR:, Names, % Names
    guicontrol, GFAR:, PlantsPerGroup, % PlantsPerGroup
    guicontrol, GFAR:, CHSNFLDR_STRING, % "Chosen Folder:" A_Tab A_Tab "(TESTMODE)"
    guicontrol, GFAR: enable,SubmitButton
    sleep, 1200
    ttip("Set test-set. Settings made in this run of the script will not be saved for next time!!")
    script.config.Config.LastRun.Sync(false)
    bTestSet:=true
    return
}
downloadTestset(URL:="https://gist.github.com/Gewerd-Strauss/d944d8abc295253ced401493edd377f2/archive/0d46c65c3993b1e8eef113776b68190e0802deb5.zip",local_path:="") {
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
    OutputDebug, % "`Downloading`n>" A_Tab URL "`n`nto`n`n>" A_Tab local_path (SubStr(local_path,0,1)="\"?"":"\") "tmp.zip"
    
    UrlDownloadToFile, % URL, % out:=local_path (SubStr(local_path,0,1)="\"?"":"\") "tmp.zip"
    EL:=ErrorLevel
    if FileExist(out) {
        return out
    } else {
        return ErrorLevel
    }
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
;#Include, <Hash_File>
;#Include, <Messageboxes>
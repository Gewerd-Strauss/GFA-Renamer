Cleanup() {
    global
    ;; Delete files:
    ;; 1. Testfiles from normal testing - just the entire test-folder. We keep the <A_ScriptDir "\assets\Image Test Files Source\tmp.zip" to save time in the end.
    ttip("Cleanup.",5)
    sleep, 1200
    GFAR_Count:=Ind1:=Ind2:=0
    if FileExist(ImageSources:=A_ScriptDir "\assets\Image Test Files") {
        LoopQuery:=ImageSources "\*." script.config.Config.filetype

        Loop, Files, % LoopQuery, FR ;; do not use recurse because the user might not have copied their testset elsewhere for inspection
        {
            if InStr(Clipboard,A_LoopFileName) {
                continue
            }
            if InStr(A_LoopFileFullPath,"GFAR_WD") { ;; last safety against removing output right now.
                GFAR_Count++
                continue
            }
            if !InStr(A_LoopFileFullPath,"Image Test Files") {
                break
            }
            FileRecycle, % A_LoopFileFullPath
            Ind1:=A_Index
        }
        LoopQuery:=scriptWorkingDir2 "\*." script.config.Config.filetype
        Loop, Files, % LoopQuery, FR ;; do not use recurse because the user might not have copied their testset elsewhere for inspection
        {
            if InStr(Clipboard,A_LoopFileName) { ;; the files are still on the clipboard - go on.
                continue
            }
            if InStr(A_LoopFileFullPath,"GFAR_WD") { ;; last safety against removing output right now.
                GFAR_Count++
                continue
            }
            if !InStr(A_LoopFileFullPath,"Image Test Files") {
                break
            }
            FileRecycle, % A_LoopFileFullPath
            Ind2:=A_Index
        }
        CleanupLoops:=0
        loop,
        {
            CleanupLoops++
            suff:=[".","..","..."]
            suff_ind += (suff_ind=3?-2:1)
            if (script.config.config.CopyFiles) { ;; if the files are copied, the GFAR_WD is never emptied, thus we cannot remove it - that's the point of copying, I suppose.
                break
            }
            ttip("Cleanup" suff[suff_ind],5)
            sleep, 1200
            FilesLeftInDownloadUnpack:=0
            FilesLeftInDownloadUnpack:=CountFilesR(A_ScriptDir "\assets\Image Test Files",A_Index)
            if (FilesLeftInDownloadUnpack<=1) { ;; because the AboutThisGist.md file is never removed, the threshold is at least 1, not 0.
                FileRecycle, % A_ScriptDir "\assets\Image Test Files" ;;TODO: change this to skip when GFAR_WD is not empty - check if there are files in there via the second continual condition in the loop above
                break
            }

        }
    }
    ttip("Cleanup normal Test Files",5)
    sleep, 1200
    ;; 2. Testfiles from running TestDataset.ahk on its own - which you shouldn't do btw, but you obviously _can_,
    if FileExist(A_ScriptDir "\Lib\Test") {
        FileDelete, % A_ScriptDir "\Lib\Test"
        ttip("Cleanup Test Files in '" A_ScriptDir "\Lib\Test'",5)
        sleep, 1200
    }
    ttip("Exiting",5)
    sleep, 200
    return
}
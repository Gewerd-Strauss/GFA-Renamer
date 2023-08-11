setupdefaultconfig() {

    DefaultConfig=
        (LTrim

            [Config]
            version= 2.1.3

            ;; set the image filetype that the script considers. Note that you cannot choose multiple filetypes at once.
            filetype=jpg

            ;; decide if you want to have the output files be put onto your clipboard when the program has finished running.
            ;; This allows you to f.e. directly paste them onto a stick so you can transfer them for analysis.
            PutFilesOnClipboard=1

            ;; If you want to copy ("Ctrl+C") the resulting files, set this to 1. If you want to cut them ("Ctrl+X"), set this to 0.
            ;; This has no effect if you set 'PutFilesOnClipboard' to 0.
            CopyFiles=1

            ;; Put the parent directory containing the resulting files on the clipboard instead
            ;; This makes it easier to copy them to a stick because you do not need to create a folder for them first
            CopyParentDirectory=1
            [TestSet]

            ; only edit this if you know what you are doing.
            ;; The URL below points to the newest version of the gist. If this may ever change in a way you do not want, you can replace it with
            ; "https://gist.github.com/Gewerd-Strauss/d944d8abc295253ced401493edd377f2/archive/0d46c65c3993b1e8eef113776b68190e0802deb5.zip"
            ; to grab the first set that was published for this.
            URL=https://gist.github.com/Gewerd-Strauss/d944d8abc295253ced401493edd377f2/archive/main.zip
            Names= G14,G21,G28,G35,G42,UU
            PlantsPerGroup= 7

            ;; do not edit this value.
            Hash= 0dea9f680788d66dae972cad2f8de224fbea4be96386bef4284b15aba84e0e43567b222c875b1f0cb877080437c994bd464239f9919b4bfddb8f38862774b629
            [LastRun]
            ;; reserved, will be autopopulated.

            [EOF]
        )
    if !FileExist(script.configfile) {
        writeFile(script.configfile,DefaultConfig,"UTF-8","w",true)
        return
    }
    MsgBox 0x2024, script.name " - Restore default config", Do you want to restore the default config supplied with this program?`n`nBe aware that all settings you altered will be reset and may have to be edited again.`n`nNo backup of your old configuration will be made`n`nRestore?

    IfMsgBox Yes, {
        writeFile(script.configfile,DefaultConfig,"UTF-8","w",true)
        reload
    } Else IfMsgBox No, {
        return
    }
}

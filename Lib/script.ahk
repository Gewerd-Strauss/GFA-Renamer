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
        html.="<hr>"
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
                        CreditsAssembly:="credits for used code:<br>`n"
                        for Author,v in credits
                        {
                            if (k="")
                                continue
                            if (strsplit(v,"|").2="")
                                CreditsAssembly.="<p>" Author " - " strsplit(v,"|").1 "`n`n"
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
                                    ;CreditsAssembly.=Name " - <p>" tmpAuthors "</p>"  "`n" ;; figure out how to force this to be on one line, instead of the mess it is right now.
                                    CreditsAssembly.="<p>" Name " - " tmpAuthors "</p>"  "`n" ;; figure out how to force this to be on one line, instead of the mess it is right now.
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
            axHight++
        gui aboutScript:new, +alwaysontop +toolwindow, % "About " this.name
        gui margin, 2
        gui color, white
        gui add, activex, w600 r%axHight% vdoc, htmlFile
        gui add, button, w75 x%btnxPos% gaboutClose, % "&Close"
        doc.write(html)
        gui show, AutoSize
        return

        aboutClose:
        gui aboutScript:destroy
        return
    }
    setIcon(Param:=true) {

        /*
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
    loadCredits(Path:="\credits.txt") {
        /*
            Function: readCredits
            helper-function to read a credits-file in supported format into the class

            Parameters:
            Path -  Path to the credits-file. 
                    If the path begins with "\", it will be relative to the script-directory (aka, it will be processed as %A_ScriptDir%\%Path%)
        */
        if (SubStr(Path,1,1)="\") {
            Path:=A_ScriptDir . Path
        }
        FileRead, text, % Path
        this.credits:=text
    }
    __Init() {

    }
    requiresInternet(URL:="https://autohotkey.com/boards/",Overwrite:=false) {                            	;-- Returns true if there is an available internet connection
        if ((this.reqInternet) || Overwrite) {
            return DllCall("Wininet.dll\InternetCheckConnection", "Str", URL,"UInt", 1, "UInt",0, "UInt")
        }
        else { ;; we don't care about internet connectivity, so we always return true
            return TRUE
            
        }
    }
}
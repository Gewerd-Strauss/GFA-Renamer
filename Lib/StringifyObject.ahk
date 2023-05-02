; --uID:3462052564
; Metadata:
; Snippet: StringifyObject  ;  (v.1.0)
; --------------------------------------------------------------
; Author: Gewerd Strauss
; License: MIT
; --------------------------------------------------------------
; Library: Personal Library
; Section: 13 - Objects
; Dependencies: /
; AHK_Version: v1
; --------------------------------------------------------------
; Keywords: Object To

;; Description:
;; Convert an Object to a string

;;; Example:
;;; associativeObj1:={A:1,value:2,C:[1,2,3]}
;;; simpleObj2:=[1,2,3,4]
;;; msgbox, % StringifyObject(associativeObj1)
;;; msgbox, % StringifyObject(simpleObj2)

StringifyObject(Obj, FullPath := 1, BottomBlank := 0) {
    static String, Blank
    if (FullPath = 1)
        String := FullPath := Blank := ""
    if (IsObject(Obj)) {
        for key, value in Obj {
            if (IsObject(value))
                StringifyObject(value, FullPath "." key, BottomBlank)
            else {
                if (BottomBlank = 0)
                    String .= FullPath "." key " = " value "`n"
                else if (value != "")
                    String .= FullPath "." key " = " value "`n"
                else
                    Blank .= FullPath "." key " =`n"
            }
        }
    }
    return String Blank
}


; --uID:3462052564

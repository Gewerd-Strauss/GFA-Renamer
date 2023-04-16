; --uID:273026601
 ; Metadata:
  ; Snippet: StdErr_Write()
  ; --------------------------------------------------------------
  ; Author: Lexikos, Holle
  ; Source: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=978| http://www.autohotkey.com/board/topic/50306-can-a-script-write-to-stderr/?hl=errorstdout#entry314658
  ; (12.12.2013)
  ; --------------------------------------------------------------
  ; Library: AHK-Rare
  ; Section: 23 - Other
  ; Dependencies: StdErr_Write_
  ; AHK_Version: AHK_L
  ; --------------------------------------------------------------
  ; Keywords: stderr, debug

 ;; Description:
  ;; write directly to stderr for custom error messages, formatted like normal error messages.

 ;;; Example:
   StdErr_Write(A_LineNumber,"This function needs pairs of parameter.","odd number")
      month<1 || month>12 ? StdErr_Write(A_LineNumber,"The variable month must have a value between 1 and 12.","month := " month)
   

  StdErr_Write(LineNumber, text, spec = "") {
    text := A_ScriptFullPath " (" LineNumber ") : ==>  " . text
    text .= spec?"`n     Specifically: " spec "`n":
    if A_IsUnicode
        return StdErr_Write_("astr", text, StrLen(text))
    return StdErr_Write_("uint", &text, StrLen(text))
  }
  StdErr_Write_(type, data, size) {
      static STD_ERROR_HANDLE := -12
      if (hstderr := DllCall("GetStdHandle", "uint", STD_ERROR_HANDLE)) = -1
          return false
      return DllCall("WriteFile", "uint", hstderr, type, data, "uint", size, "uint", 0, "uint", 0)
  }


; --uID:273026601
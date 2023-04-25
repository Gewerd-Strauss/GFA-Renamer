; #region:Hash_File (538748992)
; #region:Metadata:
; Snippet: Hash_File;  (v.1.1)
; --------------------------------------------------------------
; Author: u/anonymous1184
; License: MIT
; LicenseURL: https://gist.githubusercontent.com/anonymous1184/07e30be81ee0cd2e8c9fd75c7806c8a0/raw/5490959c8d6e4780a1598b4ea72241e306cc574a/LICENSE.txt
; Source: https://www.reddit.com/r/AutoHotkey/comments/m0kzdy/quick_file_hashing/|https://gist.github.com/anonymous1184/07e30be81ee0cd2e8c9fd75c7806c8a0#file-hashfile-ahk
; (24 April 2023)
; --------------------------------------------------------------
; Library: Personal Library
; Section: 23 - Other
; Dependencies: /
; AHK_Version: v1
; --------------------------------------------------------------
; Keywords: Hashing
; #endregion:Metadata

; #region:Description:
; File-Hashing function
; #endregion:Description

; #region:Code
Hash_File(Path, AlgId)
{
    fileObj := FileOpen(Path, 0x0)
    if (!fileObj || fileObj.Length > 0x7FFFFFFF) ; Skip files over 2gb
        return
    VarSetCapacity(data, fileObj.Length, 0)
    fileObj.Position := 0
    fileObj.RawRead(&data, fileObj.Length)
    return Hash_Addr(&data, fileObj.Length, AlgId)
}

Hash_Addr(Address, Size, AlgId, ByRef Hash := 0, ByRef HashLen := 0)
{
    out := "ERROR"
        , PROV_RSA_AES := 24
        , CRYPT_VERIFYCONTEXT := 0xF0000000
        , MD2	 := 0x00008001 ; CALG_MD2
        , MD4	 := 0x00008002 ; CALG_MD4
        , MD5	 := 0x00008003 ; CALG_MD5
        , SHA1 := SHA_1 := 0x00008004 ; CALG_SHA1
        , SHA256 := SHA_256 := 0x0000800C ; CALG_SHA_256
        , SHA384 := SHA_384 := 0x0000800D ; CALG_SHA_384
        , SHA512 := SHA_512 := 0x0000800E ; CALG_SHA_512
        , map := StrSplit("0123456789abcdef")
    try {
        if (!DllCall("Advapi32\CryptAcquireContext", "Ptr*",hProv:=0, "Ptr",0, "Ptr",0, "UInt",PROV_RSA_AES, "UInt",CRYPT_VERIFYCONTEXT))
            throw
        if (!DllCall("Advapi32\CryptCreateHash", "Ptr",hProv, "UInt",%AlgId%, "UInt",0, "UInt",0, "Ptr*",hHash:=0))
            throw
        if (!DllCall("Advapi32\CryptHashData", "Ptr",hHash, "Ptr",Address, "UInt",Size, "UInt",0))
            throw
        if (!DllCall("Advapi32\CryptGetHashParam", "Ptr",hHash, "UInt",2, "Ptr",0, "UInt*",HashLen, "UInt",0))
            throw
        VarSetCapacity(Hash, HashLen)
        if (!DllCall("Advapi32\CryptGetHashParam", "Ptr",hHash, "UInt",2, "Ptr",&Hash, "UInt*",HashLen, "UInt",0))
            throw
        out := ""
        loop % HashLen {
            val := NumGet(Hash, A_Index - 1, "UChar")
            out .= map[(val >> 0x4) + 1] map[(val & 0xF) + 1]
        }
    }
    if (hHash)
        DllCall("Advapi32\CryptDestroyHash", "Ptr",hHash)
    if (hProv)
        DllCall("Advapi32\CryPtReleaseContext", "Ptr",hProv, "UInt",0)
    return out
}

; #endregion:Code

; #region:License
; MIT License
;
; Copyright (c) 2020 anonymous1184
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
; #endregion:License

; #endregion:Hash_File (538748992)
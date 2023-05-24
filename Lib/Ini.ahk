; #region:Ini.ahk (4291014243)

; #region:Metadata:
; Snippet: Ini.ahk;  (v.2022.07.01.1)
; --------------------------------------------------------------
; Author: u/anonymous1184
; License: MIT
; LicenseURL: https://gist.githubusercontent.com/anonymous1184/737749e83ade98c84cf619aabf66b063/raw/3a1abdd5c655705ee4557fff7c26fb4ca46ce650/LICENSE.txt
; Source: https://gist.github.com/anonymous1184/737749e83ade98c84cf619aabf66b063
; (24 Mai 2023)
; --------------------------------------------------------------
; Library: Personal Library
; Section: 23 - Other
; Dependencies: /
; AHK_Version: v1
; --------------------------------------------------------------
; Keywords: config handling
; #endregion:Metadata


; #region:Description:
; https://gist.github.com/anonymous1184/737749e83ade98c84cf619aabf66b063
; https://www.reddit.com/r/AutoHotkey/comments/s1it4j/automagically_readwrite_configuration_files/
; #endregion:Description

; #region:Code

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

; #endregion:Ini.ahk (4291014243)

Object_HashmapHash(Key)
{		;; thank you to u/anonymous1184 for writing this for me for an old project, certainly helped a lot here.
    if FileExist(Key) {
        FileRead, Key, % Key
    }
	if !StrLen(Key)
		throw Exception("No key provided", -2)
	if IsObject(Key)
		return key
	if Key is integer
		Key:=Format("{:d}", Key)
	else if Key is float
		Key:=Format("{:f}", Key)
	return DllCall("Ntdll\RtlComputeCrc32"
		, "Ptr",0
		, "WStr",Key
		, "Int",StrLen(Key) * 2
		, "UInt")
}
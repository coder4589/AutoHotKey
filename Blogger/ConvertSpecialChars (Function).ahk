
String := ""
. "##R## = [#R#] `r`n"
. "##N## = [#N#] `r`n"
. "##A## = [#A#] `r`n"
. "##T## = [#T#] `r`n"
. "##S## = [#S#] `r`n"
. "{.#R#. - .#N#. - .#A#. - .#T#. - .#S#.} `r`n"
. "##R## - ##N## - ##A## - ##T## - ##S## `r`n"
. "#### #R##N#1#R##N#2#R##N#3 ####"

gui, add, edit, w300 h200 +HwndControlId,		;"+Hwnd" stores the control hwnd id number in "ControlId" variable

ControlSetText, , % ConvertSpecialChars(String), % "ahk_id" ControlId	;ControlSetText, no "`n" is translated to "`r`n" \ "ahk_id" search controls by their Hwnd id number

gui, show
return

guiclose:	;____________ Gui Close _____________
exitapp


ConvertSpecialChars(Text)	;_____________ Convert Special Chars (Function) ______________
{
	;"#" is a special character ("##" represents a literal "#" character - The First "#" escapes the second "#") 
	;#R#, #N#, #A#, #T#, #S# are special strings! (#R# = `r, #N# = `n, #A# = `a, #T# = Tab, #S# = Space)
	;##R## = #R# | ##N## = #N# | ##A## = #A# | ##T## = #T# | ##S## = #S#

Text := RegExReplace(Text, "s)#R#|#.*?#(*SKIP)(*F)", "`r")	;skip any "# 0 or more characters #", but, any "#R#" shall be replaced with "carriage return" character (`r)
Text := RegExReplace(Text, "s)#N#|#.*?#(*SKIP)(*F)", "`n")	;skip any "# 0 or more characters #", but, any "#N#" shall be replaced with "linefeed" character (`n)
Text := RegExReplace(Text, "s)#A#|#.*?#(*SKIP)(*F)", "`a")	;skip any "# 0 or more characters #", but, any "#A#" shall be replaced with "Bell" character (`a = ) Unicode char 7
Text := RegExReplace(Text, "s)#T#|#.*?#(*SKIP)(*F)", A_Tab)	;skip any "# 0 or more characters #", but, any "#T#" shall be replaced with "Tab" character (A_Tab)
Text := RegExReplace(Text, "s)#S#|#.*?#(*SKIP)(*F)", A_Space)	;skip any "# 0 or more characters #", but, any "#S#" shall be replaced with "Space" character (A_Space)

	;"s)" option allows "." to match "`r`n" newlines too \ "?", prevents skipping all the string at once between the first "#" and last "#" character! 

Text := RegExReplace(Text, "##", "#")	;replace any "##" with "#"
return, Text
}







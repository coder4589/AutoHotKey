

String := ""
. "_1_ {.#R. - .#N. - .#A. - .#T. - .#S.} `r`n"
. "_2_ ##R-##N-##A-##T-##S _ ##R##N##A##T##S _ ####R####N `r`n"
. "_3_ #### #R#N1#R#N2#R#N3 #### `r`n"
. "_4_ --65--66--67--68-- __ --65666768--`r`n"
. "_5_ --##65##--##66##--##67##--##68##-- __ --##65####66####67####68##--`r`n"
. "_6_ --####65####--####66####-- __ --####65########66####--`r`n"
. "_7_ --#65#--#66#--#67#--#68#-- __ --#65##66##67##68#--`r`n"
. "_8_ --#65##R#N#66##N#R#67##A#68#-- __ --#65###R##N#66###T#68#--`r`n"
. "_9_ --##65###R#N##66###N#R##67###A##68##--`r`n"
. "_10_ --##65####R##N##66####N##R##67####A##68##--`r`n"

gui, add, text, , Type or paste text below:
gui, add, edit, w450 H170 +HScroll +HwndEdit1 gUpdate WantTab 0x100, % String
gui, add, text, , OutPut:
gui, add, edit, w450 H250 +HScroll +HwndEdit2 +ReadOnly 0x100,

	;"+Hwnd" stores the control hwnd id number in "Edit1" variable
	;"+Hwnd" stores the control hwnd id number in "Edit2" variable
	;"0x100", ES_NOHIDESEL (show control selected text, even if the control is not focused)

Gosub, Update

Gui, Add, Link, x140, <a href="http://autohotkeycoder.blogspot.com/2017/06/convertspecialstrings-function.html">www.AutoHotKeyCoder.blogspot.com</a>

gui, show
return

Update:	;__________ Update ______________

ControlGetText, Edit1Text, , % "ahk_id" Edit1
ControlSetText, , % ConvertSpecialStrings(Edit1Text), % "ahk_id" Edit2

	;ControlGetText, no "`r`n" is translated to "`n" \ "ahk_id" search controls by their Hwnd Id number
	;ControlSetText, no "`n" is translated to "`r`n" \ "ahk_id" search controls by their Hwnd id number

return

guiclose:	;__________ Gui Close ______________
exitapp


ConvertSpecialStrings(Text)	;___________ ConvertSpecialStrings(Function) ________________
{
;"#" is a special character ("##" represents a literal "#" character - The First "#" escapes the second "#") 
;#R, #N, #A, #T, #S are special strings! (#R = `r, #N = `n, #A = `a, #T = `t, #S = Space)
;##R = #R | ##N = #N | ##A = #A | ##T = #T | ##S = #S
;#AnyNumber# is a special string (Example: #65# = A, #66# = B, in the other hand, ##65## = #65#, ##66## = #66#)
;#AnyNumber# is automatically converted to its correspondent unicode character!
;"#AnyNumber#" format in use instead "#AnyNumber", because, for example, "#66#6" returns "B6", but "#666" would return the unicode character correspondent to 666 number instead "B6"

StartPos := 1	;necessary for "RegExMatch" below, otherwise, "while" loop will not work

while, StartPos := RegExMatch(Text, "##(*SKIP)(*F)|#(\d+)#", Match, StartPos)
Text := RegExReplace(Text, "##(*SKIP)(*F)|" Match, Chr(Match1))

	;"while", is a loop! The loop breaks when RegExMatch does not find any more "#(\d+)#" string (on no Match, RegExMatch returns 0)
	;"StartPos", RegExMatch stores any match position in "StartPos" variable! In the next iterations, RegExMatch starts from "StartPos" position
	;"##(*SKIP)(*F)|", skip any ## string | "#(\d+)#", match any "#1 or more Digit\Number#" string 
	;"Match", RegExMatch stores "#(\d+)#" match in "Match" variable and stores "(\d+)" match in "Match1" variable 
	;"Chr(Match1)", returns the unicode character correspondent to "Match1" Number\Digit

Text := RegExReplace(Text, "##(*SKIP)(*F)|#R", "`r")	;skip anyy "##" and replace any "#R" with "Carriage return" character (`r)
Text := RegExReplace(Text, "##(*SKIP)(*F)|#N", "`n")	;skip anyy "##" and replace any "#N" with "Line feed" character (`n)
Text := RegExReplace(Text, "##(*SKIP)(*F)|#A", "`a")	;skip anyy "##" and replace any "#A" with "Bell" character (à), which is () Unicode char 7
Text := RegExReplace(Text, "##(*SKIP)(*F)|#T", "`t")	;skip anyy "##" and replace any "#T" with "Tab" character (`t)
Text := RegExReplace(Text, "##(*SKIP)(*F)|#S", " ")	;skip anyy "##" and replace any "#S" with "Space" character	

	;#AnyNumber# must be converted first than #R, #N, #A, #T, #S, otherwise, the example error below will occur:
	;"#65##T#66#" wrongly returns "A#TB" instead "A	B" which is the correct value to be returned

Text := RegExReplace(Text, "##", "#")	;replace any ## with #

return, Text
}











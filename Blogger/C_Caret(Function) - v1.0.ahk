

	;https://autohotkey.com/boards/viewtopic.php?p=179374#p179374
	;https://autohotkey.com/boards/viewtopic.php?p=178225#p178225


CoordMode, Caret, screen

text := "
(
Lorem ipsum dolor sit amet
Consectetuer ligula Aliquam Curabitur Nullam
Rutrum eu est congue dui
Interdum Phasellus sed Quisque Donec
Et semper adipiscing id Sed
Non ut Quisque Pellentesque lorem
Est at urna justo sem
Proin consequat gravida nibh adipiscing
)"

gui, add, edit, w260 h150, % "(With border) `n" text
gui, add, edit, x+5 w260 h150 -E0x200, % "(Without border) `n" text	;"-E0x200" remove border
gui, add, text, xm, - Text - 
gui, add, text, x+5 +border, - Text - 
gui, add, button, x+5, Button
gui, add, button, x+5 +Border, Button

gui, show
return

~Lbutton up::	;"~" keeps the button original function

MouseGetPos, , , WinId, ControlId, 2	;"2" Stores the control's HWND in "ControlId" variable rather than the control's ClassNN.

~Up::
~Right::
~Left::
~Down::

sleep, 50

WinGetPos, CtrlX, CtrlY, , , % "ahk_id" ControlId	;"WinGetPos" can be used to get controls xy pos relative to screen upper-left corner

VarSetCapacity(WINDOWINFO, 60, 0)
DllCall("GetWindowInfo", Ptr, ControlId, Ptr, &WINDOWINFO)
CtrlClientX := NumGet(WINDOWINFO, 20, "Int")
CtrlClientY := NumGet(WINDOWINFO, 24, "Int")

;Get start and End Pos of the selected string - Get Caret pos if no string is selected
;https://autohotkey.com/boards/viewtopic.php?p=27979#p27979
;EM_GETSEL = 0x00B0 -> msdn.microsoft.com/en-us/library/bb761598(v=vs.85).aspx
DllCall("User32.dll\SendMessage", "Ptr", ControlId, "UInt", 0x00B0, "UIntP", Start, "UIntP", End, "Ptr")
start++, end++	;force "1" instead "0" to be recognised as the beginning of the string!

tooltip % ""
. "XY pos relative to screen upper-left corner: `n"
. "Control XY Pos: " CtrlX "," CtrlY "`n"
. "Control Client Area XY pos: " CtrlClientX "," CtrlClientY "`n"
. "A_CaretX \ A_CaretY: " A_CaretX "," A_Carety "`n"
. "`n"
. "Caret String Pos: " . C_Caret(ControlId) . C_Caret("S") . " \ Caret Line: " . C_Caret("L") .  "`n"
. "Selected String (Start\End): " . Start "\" End "`n"
. "Caret XY pos from control Client Area: " . C_Caret("x") "," C_Caret("y") "`n"
. "`n"
. "WinId: " . WinId . " \ ControlId: " . ControlId .  "`n"

return

guiclose:	;____________ gui close ___________
exitapp


C_Caret(ControlId)	;_________ C_Caret(Function) - v1.0 __________ 
{
;This function returns the Caret info relative to the specified Control's client area!
;if "ControlId = a Control Hwnd Id" the function will get the Caret S,L,X,Y positions!
;if "ControlId = S" the function returns the Caret String Position
;if "ControlId = L" the function returns the Caret Line Position
;if "ControlId = X" the function returns the Caret x Position
;if "ControlId = Y" the function returns the Caret Y Position

Static S,L,X,Y		;remember values between function calls

if (ControlId = "S")
return, S
else if (ControlId = "L")
return, L
else if (ControlId = "X")
return, X
else if (ControlId = "Y")
return, Y

T_CoordModeCaret := A_CoordModeCaret	;necessary to restore thread default option before function return
CoordMode, Caret, screen
sleep, 1				;prevents A_CaretX\A_Carety from returning incorrect values

VarSetCapacity(WINDOWINFO, 60, 0)
DllCall("GetWindowInfo", Ptr, ControlId, Ptr, &WINDOWINFO)

X := A_CaretX - NumGet(WINDOWINFO, 20, "Int")	;"20" returns the control client area x pos relative to screen upper-left corner
Y := A_Carety - NumGet(WINDOWINFO, 24, "Int")	;"24" returns the control client area y pos relative to screen upper-left corner

;EM_CHARFROMPOS = 0x00D7 -> msdn.microsoft.com/en-us/library/bb761566(v=vs.85).aspx
Char := DllCall("User32.dll\SendMessage", "Ptr", ControlId, "UInt", 0x00D7, "Ptr", 0, "UInt", (Y << 16) | X, "Ptr")

S := (Char & 0xFFFF) + 1	;"+1" force 1 instead 0 to be recognised as first character
L := (Char >> 16) + 1

CoordMode, Caret, % T_CoordModeCaret	;restore thread default option before function return
sleep, 1				;prevents A_CaretX\A_Carety from returning incorrect values
}

































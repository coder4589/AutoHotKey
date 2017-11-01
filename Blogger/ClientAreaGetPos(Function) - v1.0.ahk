

	;https://autohotkey.com/boards/viewtopic.php?f=5&t=39129


gui, add, edit, w300 h200,

gui, show
return

~Lbutton up::	;"~" keeps the button original function

MouseGetPos, , , WinId, ControlId, 2	;"2" Stores the control's HWND in "ControlId" variable rather than the control's ClassNN.

WinGetPos, WinX, WinY, , , % "ahk_id" WinId
WinGetPos, CtrlX, CtrlY, , , % "ahk_id" ControlId

ToolTip, % ""
. "XY pos relative to screen upper-left corner: `n"
. "`n"
. "Win Pos: " WinX "," WinY "`n"
. "Win ClientArea Pos: " . ClientAreaGetPos(WinId) . ClientAreaGetPos("x") . "," . ClientAreaGetPos("y") . "`n"
. "`n"
. "Control Pos: " CtrlX "," CtrlY "`n"
. "Control ClientArea Pos: " . ClientAreaGetPos(ControlId) . ClientAreaGetPos("x") . "," . ClientAreaGetPos("y") . "`n"
. "`n"
.  "WinId: " WinId " \ ControlId: " ControlId "`n"


return

guiclose:	;_______ gui close ________
exitapp


ClientAreaGetPos(Hwnd)	;___________ ClientAreaGetPos(Function) - v1.0 ______________
{
;This function returns the window or control client area xy pos relative to screen upper-left corner!
;if "Hwnd = a win or control hwnd id", the function will get the xy pos
;if "Hwnd = x" the function returns the x value
;if "Hwnd = y" the function returns the y value

Static x,y	;remember values between function calls

if (Hwnd = "x")
return, x
else if (Hwnd = "y")
return, y

VarSetCapacity(WINDOWINFO, 60, 0)
DllCall("GetWindowInfo", Ptr, Hwnd, Ptr, &WINDOWINFO)

X := NumGet(WINDOWINFO, 20, "Int")	;"20" returns the Win\control client area x pos relative to screen upper-left corner
Y := NumGet(WINDOWINFO, 24, "Int")	;"24" returns the Win\control client area y pos relative to screen upper-left corner

}









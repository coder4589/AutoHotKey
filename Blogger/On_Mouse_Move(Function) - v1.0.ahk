
	;Credit to "RHCP" forum user!
	;https://www.autohotkey.com/boards/viewtopic.php?t=14733

	;https://msdn.microsoft.com/en-us/library/windows/desktop/ms644990(v=vs.85).aspx
	;https://msdn.microsoft.com/en-us/library/windows/desktop/ms644986(v=vs.85).aspx
	;https://msdn.microsoft.com/en-us/library/windows/desktop/ms644970(v=vs.85).aspx


gui, add, text, , Move Mouse Anywhere (Inside or Outside This Window!)

gui, show, h200

return 

guiclose:		;__________________________________
exitapp 


On_Mouse_Move(nCode, wParam, lParam)	;____________________ v1.0 ____________________
{

Static Hook_Id := DllCall("SetWindowsHookEx", "int", 14, "Ptr", RegisterCallback("On_Mouse_Move"), "Ptr", DllCall("GetModuleHandle", "Ptr", 0, "Ptr"), "UInt", 0)

	; WH_MOUSE_LL := 14 
	;Storing "Hook_Id" is optional (Can be used later to unhook on script exit)
	;You dont really have to unhook it, as it will be removed anyway when the program closes\exits .... but its good practice.

	;msgbox, % Hook_Id

Static Run_At_Script_Execution := OnExit(Func("On_Mouse_Move").Bind("Unhook"))

	if (nCode = "Unhook")
	{
	DllCall("UnhookWindowsHookEx", "Ptr", Hook_Id)
	;You dont really have to unhook it, as it will be removed anyway when the program closes\exits .... but its good practice.

		;msgbox, Unhooked (Just for Testing)

	return
	}

	if (wParam = 512)	;"512" is for mouse movement
	{


		;Paste your code here (the below code is just for testing, it can be removed!)


	Static Count := 0
	MouseGetPos, x, y
	tooltip, % ""
	. nCode " - " wParam " - " lParam    "`r`n"
	. "x" x " / y" y                     "`r`n"
	. "Test Count: " count++             "`r`n"


	}
}



















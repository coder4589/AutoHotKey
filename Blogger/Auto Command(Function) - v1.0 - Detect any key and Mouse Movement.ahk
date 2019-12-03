
gui,  +AlwaysOnTop

gui, add, edit, w650 r2
gui, add, edit,  w650 h300 WantTab +HScroll vOutPut, 

gui, add, text, ,
(join`r`n
In this example:

Key "A" sends "B", and "A" is blocked!

Key "Z" sends "X", and "Z" is not blocked!
)

gui, add, button, x+5 gHistory_On, History (On)
History_On()	;_______________________________
{
Auto_Command("VarSet", "History", "On")
}

gui, add, button, x+5 gHistory_Off, History (Off)
History_Off()	;________________________________
{
Auto_Command("VarSet", "History", "Off")
}

gui, show
return

guiclose()		;________________________________
{
exitapp
}

Auto_Command(P_, P2_ := "", P3_ := "")		;__________________________ v1.0 ________________________
{
Static History

	if (P_ = "VarSet")		;__
	{
	%P2_% := P3_
	return
	}

	if (History != "Off")		;__
	{
	if (StrLen(History) > 10100)
	History := SubStr(History, 1, 2100)

	History := P_.Detected "	| " P_.State "	| x" P_.x "	| y" P_.y "	| vk" P_.vk " = " P_.vk_Name "	| sc" P_.sc " = " P_.sc_Name "	| " P_.nCode "_" P_.wParam "_" P_.lParam "_" A_TickCount "`r`n" History

	guicontrol, , output, % History
	}

	if (P_.Detected = "a") and (P_.State = "Down")
	{return "Block", SetTimer("Task_1", -1)			;-1, Call once (return "Block", "a" is Blocked\Intercepted!)
	Task_1:
	send b
	return
	}

	if (P_.Detected = "z") and (P_.State = "Down")
	{return, SetTimer("Task_2", -1)				;-1, Call once (return, "z" is not Blocked\Intercepted!)
	Task_2:
	send x
	return
	}
}

SetTimer(Label, Period, Priority := "")		;____________________________________
{
SetTimer, % Label, % Period, % Priority 
}

Detect_Keyboard_Mouse(nCode, wParam, lParam)		;__________________________________________________
{
Static Run_At_Script_Execution := OnExit(Func("Detect_Keyboard_Mouse").Bind("Unhook"))

	;WH_KEYBOARD_LL = 13 / WH_MOUSE_LL = 14

Static hHookKeybd := DllCall("SetWindowsHookEx", "int", 13, "Uint", RegisterCallback("Detect_Keyboard_Mouse", "Fast"), "Uint", DllCall("GetModuleHandle", "Uint", 0), "Uint", 0)
Static hHookMouse := DllCall("SetWindowsHookEx", "int", 14, "Uint", RegisterCallback("Detect_Keyboard_Mouse", "Fast"), "Uint", DllCall("GetModuleHandle", "Uint", 0), "Uint", 0)

Critical

	if (nCode = "Unhook")
	{
	DllCall("UnhookWindowsHookEx", "Uint", hHookKeybd)
	DllCall("UnhookWindowsHookEx", "Uint", hHookMouse)
	return
	}

P_ := []

	if (wParam = 256) or (wParam = 257) or (wParam = 260)		;256\260 = keyboard key down / 257 keyboard key up
	{
	if (wParam = 256) or (wParam = 260)				;256 is for all keyboard key down / 260 is for "LAlt" and "RAlt" down!
	P_.State := "Down"
	else
	P_.State := "Up"

	P_.vk := NumGet(lParam+0, 0)

		;"sc" is useful for some keys, for example, "Enter" and "NumPadEnter" have the same "vk" codes but different "sc" codes!
		;"sc" is not useful for some keys, for example, "NumPad1" and "NumPadEnd" have the same "sc" codes but different "vk" codes!

	Extended := NumGet(lParam+0, 8) & 1
	sc := (Extended<<8)|NumGet(lParam+0, 4)
	P_.sc := sc = 0x136 ? 0x36 : sc

		;"GetKeyName()" only works with hex numbers, so "Format()" must be used to convert decimal to Hex!

	P_.Detected := P_.vk_Name := GetKeyName("vk" Format("{:x}", P_.vk))
	
	P_.sc_Name := GetKeyName("sc" Format("{:x}", P_.sc))
	}
	else if (wParam = 512)		;512 = Mouse Move
	{
	P_.Detected := "Mouse_Move", P_.x:= NumGet(lParam+0, 0, "int"), P_.y := NumGet(lParam+0, 4, "int")
	}
	else if (wParam = 513)	or (wParam = 514)		;513 = Mouse Left Button Down / 514 = Mouse Left Button Up
	{
	P_.Detected := "LButton", P_.State := (wParam = 513 ? "Down" : "Up")
	}
	else if (wParam = 516)	or (wParam = 517)		;516 = Mouse Right Button Down / 517 = Mouse Right Button Up
	{
	P_.Detected := "RButton", P_.State := (wParam = 516 ? "Down" : "Up")
	}	
	else if (wParam = 519)	or (wParam = 520)		;519 = Mouse Middle Button Down / 520 = Mouse Middle Button Up
	{
	P_.Detected := "MButton", P_.State := (wParam = 519 ? "Down" : "Up")
	}

P_.nCode := nCode, P_.wParam := wParam, P_.lParam := lParam

Return_Value := Auto_Command(P_)

Return, (Return_Value = "Block" ? 1 : DllCall("CallNextHookEx", "Uint", 0, "int", nCode, "Uint", wParam, "Uint", lParam))
}




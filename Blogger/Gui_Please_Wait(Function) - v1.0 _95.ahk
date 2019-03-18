

	;(Obs) Never use "Labels"! (use "Functions" instead!)

	;(Obs) Never, Never and Never declare "Global" variables! (Especially when writing "Functions" or "Classes"!)
	;(Obs) Use "ScriptGet()" function instead that allows others Functions\Classes to get values of Local Variables from the Main Script!
	;(obs) "ScriptGet()" can only "Read" Local variables from Main Script! ("Global" variables allows "Read" and "Write" in which causes a lot of problems!)
	;(obs) "ScriptGet()": https://autohotkeycoder.blogspot.com/2019/03/scriptget-function.html


loop, 3
{
gui, % a_index ":Default"

gui, +LabelTest_Windows

	gui, add, button, gExecute, Execute
	Execute() ;_________________________
	{
	Gui_Please_Wait(a_gui " Executing ...!")	;since "Owner_Gui" parameter is not specified, "a_gui" will be used automatically! 

	sleep, 5000

	Gui_Please_Wait(["Destroy"])			;since "Owner_Gui" parameter is not specified, "a_gui" will be used automatically!
	}

	gui, add, button, gExecuteAll, Execute All
	ExecuteAll() ;_____________________________
	{
	Gui_Please_Wait("1 Executing ...!", 1)		;"Owner_Gui" parameter is 1
	Gui_Please_Wait("2 Executing ...!", 2)		;"Owner_Gui" parameter is 2
	Gui_Please_Wait("3 Executing ...!", 3)		;"Owner_Gui" parameter is 3

	sleep, 5000

	Gui_Please_Wait(["Destroy"], 1)		;"Owner_Gui" parameter is 1
	Gui_Please_Wait(["Destroy"], 2)		;"Owner_Gui" parameter is 2
	Gui_Please_Wait(["Destroy"], 3)		;"Owner_Gui" parameter is 3
	}

if (a_index = 1)
x := "x" a_screenwidth / 2 - 240
else if (a_index = 2)
x := ""
else if (a_index = 3)
x := "x" a_screenwidth / 2 + 85

gui, show, % x " w150 h200", % a_index
}

return

Test_WindowsClose()	;________________________________
{
exitapp
}


Gui_Please_Wait(Title := "", Owner_Gui := "")	;_____________________ v1.0 _______________________
{

	;Tested in AHK 1.1.23.05


	;Local		;Force "Local" mode (AHK 1.1.27+ Only)

T_DefaultGui := A_DefaultGui 

if (Owner_Gui == "")
Owner_Gui := a_gui

gui, % "Please_Wait" Owner_Gui ":Default"

	if (Title[1] = "Destroy")
	{
	Gui, % Owner_Gui ":-Disabled"
	;Makes the "Owner_Gui" windows usable again
	;re-enable the "Owner_Gui" window before cancel/destroying "Please_Wait" gui window in order to make it automatically Activated Window.

	Gui, destroy
	}
	else
	{
	gui, % "+Owner" Owner_Gui	;Make "Please_Wait" gui window owned by "Owner_Gui" window

	Gui, % Owner_Gui ":+Disabled"	;prevents the user from interacting with the "Owner_Gui" window

	gui, -Sysmenu
	gui, add, Text, w200 h50 y+30 center, Please Wait!!!
	gui, show, , % Title
	}

gui, % T_DefaultGui ":Default"		;Sets back the default gui
}
























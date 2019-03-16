

	;(Obs) Never, or at least, avoid using "Labels" whenever possible! (use "Functions" instead!)

	;(Obs) Never, Never and Never declare "Global" variables! (Especially when writing "Functions" or "Classes"!)
	;(Obs) Use "ScriptGet()" function instead that allows others Functions\Classes to get values of Local Variables from the Main Script!
	;(obs) "ScriptGet()" can only "Read" Local variables from Main Script! ("Global" variables allows "Read" and "Write" in which causes a lot of problems!)
	;(obs) "ScriptGet()": https://autohotkeycoder.blogspot.com/2019/03/scriptget-function.html

gui, add, edit, w300 vText gExecute,

gui, show

return

Execute()	;_____________________
{

	loop
	{
	sleep_Time := 1000

	sleep, % sleep_Time

	if (A_TimeIdle > sleep_Time/2)
	break
	}

guicontrolget, text

msgbox, % text
}

guiclose()	;_____________________
{
exitapp
}













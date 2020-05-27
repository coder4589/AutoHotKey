msgbox, % ""
. A_AhkPath              "`r`n`r`n"		;"A_AhkPath" is not recommended for compiled scripts (it returns the location where AHK is installed, or blank\empty if AHK is not installed at all)
. A_DetectHiddenWindows  "`r`n`r`n"
. EXE_Path("Name")       "`r`n`r`n"
. EXE_Path("Dir")        "`r`n`r`n"
. EXE_Path()             "`r`n`r`n"



EXE_Path(Options := "")		;______________ (v1.0) ________________
{
Static RunAtScriptExecution := EXE_Path("Create_EXE_Name_Dir_Path")

Static EXE_Name, EXE_Dir, EXE_Path

	if (Options = "Create_EXE_Name_Dir_Path")
	{
		;when a compiled script is directly executed, "A_ScriptName = compiled EXE name" and "A_ScriptFullPath = Compiled EXE full path"
		;when a compiled script is executed from a file, "A_ScriptName = File name" and "A_ScriptFullPath = File full path"

		;in the other hand, "Winget, ProcessPath" always returns the "Compiled EXE full path".

	T_DetectHiddenWindows := A_DetectHiddenWindows
	DetectHiddenWindows, on

	WinGet, EXE_Path, ProcessPath, % "ahk_id" A_ScriptHWnd		;"A_ScriptHWnd" The unique ID (HWND/handle) of the script's hidden main window.

	DetectHiddenWindows, % T_DetectHiddenWindows

		;msgbox, % "Run At Execution (Test) `r`n`r`n" T_DetectHiddenWindows

	RegExMatch(EXE_Path, "(.*)\\(.*)", Matched)

	EXE_Dir  := Matched1

	EXE_Name := Matched2

	return
	}

if (Options = "Name")
return, EXE_Name

if (Options = "Dir")
return, EXE_Dir

return, EXE_Path
}

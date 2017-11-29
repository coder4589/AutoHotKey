

	;Tested in AutoHotKey 1.1.23.05 (32bit Unicode) - Windows 7 Professional (64bit)


#SingleInstance, OFF	;The word OFF allows multiple instances of the script to run concurrently.
			;The word FORCE skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.
			;The word IGNORE skips the dialog box and leaves the old instance running. In other words, attempts to launch an already-running script are ignored.

#MaxMem 4095		;Allow 4095 MB per variable! A value larger than 4095 is considered to be 4095. A value less than 1 is considered to be 1.
SetBatchLines -1	;run script at maximum speed!


Text =
(
Tested in AutoHotKey 1.1.23.05 (32bit Unicode) - Windows 7 Professional (64bit)

If "Options" edit control contains "-CaseSense" string, Case-Sensitivity is turned Off!
(Example: "A" is treated as "a", the otherwise is valid too)!

If "Options" edit control contains "RegEx" or "RegEx()" string, RegExMatch() function is used instead InStr() function!
RegEx(Initial Options) can be used in "Options"! Example: RegEx(i) or RegEx(m) or RegEx(im) or RegEx(i m)!
(This is the only way to specify regex initial options in this function!)

If "Options" contains "SubP" or "SubP()" string, regex subpattern search is enabled! (RegEx option must be enabled!)
SubP, SubP() or SubP(1) is for the first subpattern, SubP(0) all pattern, SubP(2) second subpattern, SubP(year) for subpattern which name is year!

In the edit control between "Previous" and "Next" buttons,
you can type any number and the function will search the specified string Occurrence!
(If 1, the function will search the First Occurrence, if 2, the second Occurrence, if L, the last Occurrence!)
________________________________________________________________________________________________
`n
)
loop, 10
Text .= "Tested in AutoHotKey 1.1.23.05 (32bit Unicode) - Windows 7 Professional (64bit) -" a_index "- "
Text .= "`n________________________________________________________________________________________________`n`n"

IText := Text
loop, 4
IText .= "<" a_index ">" Text 

;"+Hwnd" stores the control hwnd id number in "TextControlId" variable
gui, add, edit, w600 h300 0x100 +HScroll WantTab vTextControl +HwndTextControlId, % IText	;"0x100", ES_NOHIDESEL (show control selected text, even if the control is not focused)
gui, add, text, Section,									;"section", xs\ys now contains the x\y coord of this control

gui, add, text, ym, Examples:
loop, 9
gui, add, radio, gShowExample, % "Basic " a_index
loop, 11
gui, add, radio, gShowExample, % "RegEx " a_index
guicontrol, , Basic 1, 1	;pre-select the specified radiobox

gui, add, text, xm ys section, Search:	;"section", xs\ys now contains the x\y coord of this control
gui, add, edit, w400 h100 WantTab +HScroll gSearch1 vSearch1Control +HwndSearch1ControlId, % "AutoHotKey"
gui, add, text, x+5 ys, Options:
gui, add, edit, w195 h82 +HScroll gSearch1 WantTab vOption1Control +HwndOption1ControlId,	;"+Hwnd" stores the control hwnd id number in "Option1ControlId" variable
gui, add, text, xp+60 y+m, Notes:								;"xp" is the x coord of the previous control (in this case, the x coord of "Options" edit control!)
gui, add, edit, xp-175 y+5 w390 h80 vNoteControl +HScroll WantTab,	;"xp" is the x coord of the previous control (in this case, the x coord of "Notes" text control!)
gui, add, text, xm yp w285 vStatus1, Status				;"yp" is the y coord of the previous control (in this case, the y coord of edit "NoteControl")
gui, add, button,  w70 gPrevious1, Previous
gui, add, edit, x+5 w40 center gOccurrence1 vOccurrence1 +HwndOccurrence1ControlId,
gui, add, button, x+5 w70 gNext1, Next
gui, add, checkbox, xm y+7 vSearchFirstLast, Search First\Last occurrence if Next\Previous not found!
Gui, Add, Link, x60 y+5, <a href="http://autohotkeycoder.blogspot.com/2017/11/stringsearch-function.html">www.AutoHotKeyCoder.blogspot.com</a>

gui, show
gosub, Search1
return


Search1: ;___________ Search 1 _______________

SearchDirection := "Fixed"	;search the closest string while typing!

goto, SearchNow1

	;guicontrol, , Occurrence1, 1	;this line will automatically execute "Occurrence1" label, then "SearchNow1" label

return

SearchNow1:	;_________________ SearchNow1 ___________________

ControlGetText, Search1Text, , % "ahk_id" Search1ControlId	;no "`r`n" is translated to "`n" \ "ahk_id" search controls by their Hwnd Id number
ControlGetText, Option1Text, , % "ahk_id" Option1ControlId	;no "`r`n" is translated to "`n" \ "ahk_id" search controls by their Hwnd Id number

StringSearch(TextControlId, Search1Text, Occurrence1, Option1Text " " SearchDirection)

guicontrolget, SearchFirstLast
if (SearchFirstLast = 1)
{
	if (StringSearch("FoundPos") = "0")	;if "0", string not found
	{
		if (SearchDirection = "Fixed" or SearchDirection = "Next")
		{
		guicontrol, , Occurrence1, % 1		;search first occurrence (this line will automatically execute "Occurrence1" label, then "SearchNow1" label)
		return
		}
		else if (SearchDirection = "Previous")
		{
		guicontrol, , Occurrence1, % "L"	;search Last occurrence (this line will automatically execute "Occurrence1" label, then "SearchNow1" label)
		return
		}
	}
}

if (StringSearch("FoundPos") = "")		;if "blank", probably RegEx Error (if "RegEx Error: 0" shows up, it is a false positive error, because "0" by default means no error found!)
{						;if "RegEx Error: " shows up, it is a false positive error because it means that regex option is not even enabled!
guicontrol, +cRed, Status1
guicontrol, , Status1, % "RegEx Error: " . StringSearch("RegExError")
}
else if (StringSearch("FoundPos") = "0")	;if "0", string not found (or regex subpattern being searched was not specified in overall pattern!)
{
guicontrol, +cRed, Status1
guicontrol, , Status1, Not Found! (or regex subpattern not specified in pattern!)
}
else if (StringSearch("FoundPos") = "-1")	;if "-1", Searching empty string! (or empty regex pattern and\or subpattern!)
{
guicontrol, +cBlack, Status1
guicontrol, , Status1, % "Searching empty string! (or empty regex pattern\subpattern!)"
}
else
{
guicontrol, +cGreen, Status1
guicontrol, , Status1, % "Found at string position " . StringSearch("FoundPos") . " ! (String Lengh = " . StringSearch("StringLengh") . ")!"
}

guicontrol, -g, Occurrence1
guicontrol, , Occurrence1, % StringSearch("FoundOccurrence")
SendMessage, 0xB1, -2, -1, , % "ahk_id" Occurrence1ControlId	;"0xB1", EM_SETSEL (Deselect all text and move caret to the end of the line!)
guicontrol, +gOccurrence1, Occurrence1

return

Next1:	;___________ Next 1 _____________

SearchDirection := "Next"

goto, SearchNow1

	;guicontrol, , Occurrence1, % Occurrence1	;this line will automatically execute "Occurrence1" label, then "SearchNow1" label

return

Previous1:	;___________ Previous 1 _____________

SearchDirection := "Previous"

goto, SearchNow1

	;guicontrol, , Occurrence1, % Occurrence1	;this line will automatically execute "Occurrence1" label, then "SearchNow1" label

return

Occurrence1:	;___________ Occurrence 1 _____________

	;msgbox, Occu

SearchDirection := ""	;if blank, Search String by Occurrence

guicontrolget, Occurrence1

if (Occurrence1 = "")
{
SendMessage, 0xB1, -1, 0, , % "ahk_id" TextControlId	;"0xB1", EM_SETSEL, Deselect any string and keep caret at its current pos!
guicontrol, +cBlack, Status1
guicontrol, , Status1, % "Type Occurrence ...!"
return
}

goto, SearchNow1

return

ShowExample:	;__________ Show Example __________

ExampleText := ExampleString := ExampleOption := ExampleNote := ""

if (A_GuiControl = "Basic 1")
{
ExampleText := IText, ExampleString := "AutoHotKey", ExampleOption := "", ExampleNote := ""
}
else if (A_GuiControl = "Basic 2")
{
ExampleText := IText, ExampleString := "autohotkey", ExampleOption := "-CaseSense"
ExampleNote := "In this case, ""-CaseSense"" option`nallows a,h,k to match A,H,K, otherwise, no match would be found!" 
}
else if (A_GuiControl = "Basic 3")
{
ExampleText := IText, ExampleString := "autohotkey", ExampleOption := ""
ExampleNote := "In this case, there is no ""-CaseSense"" option, so`na,h,k will not match A,H,K! (no match will be found!)"
}
else if (A_GuiControl = "Basic 4")
{
loop, 10
ExampleText .= "`n" a_index "`nABCD`nEFGH`n`nabcd`nefgh`n`n", ExampleString := "abcd`nefgh", ExampleOption := "", ExampleNote := ""
}
else if (A_GuiControl = "Basic 5")
{
loop, 10
ExampleText .= "`n" a_index "`nABCD`nEFGH`n`nabcd`nefgh`n`n", ExampleString := "abcd`nefgh", ExampleOption := "-CaseSense", ExampleNote := ""
}
else if (A_GuiControl = "Basic 6")
{
ExampleText := IText, ExampleOption := "", ExampleNote := "" 
ExampleString =
(
Tested in AutoHotKey 1.1.23.05 (32bit Unicode) - Windows 7 Professional (64bit)

If "Options" edit control contains "-CaseSense" string, Case-Sensitivity is turned Off!
(Example: "A" is treated as "a", the otherwise is valid too)!
)
}
else if (A_GuiControl = "RegEx 1")
{
ExampleText := IText, ExampleString := "A...H..K..", ExampleOption := "RegEx"
ExampleNote := """RegEx"" option turns on Regular Expressions! `n""."" matches any character!" 
}
else if (A_GuiControl = "RegEx 2")
{
ExampleText := IText, ExampleString := "a...h..k..", ExampleOption := "RegEx(i)"
ExampleNote := """i"" is a regex initial option that turns off regex case-sensitivity! `n""-CaseSense"" can be used in alternative to ""i""!" 
}
else if (A_GuiControl = "RegEx 3")
{
ExampleText := IText, ExampleString := "^test", ExampleOption := "RegEx(m) -CaseSense"
ExampleNote := """^"" search for lines that start by ""test"" string! `n""m"" is a regex initial option that turns on multiline search! `n""RegEx(mi)"" can be used in alternative to ""-CaseSense""!" 
}
else if (A_GuiControl = "RegEx 4")
{
ExampleText := IText, ExampleString := "occurrence!$", ExampleOption := "RegEx(mi)"
ExampleNote := """$"" search for lines that ends by ""occurrence!"" string! `nIn this example ""m"" and ""i"" regex initial options are in use! `n" 
}
else if (A_GuiControl = "RegEx 5")
{
ExampleText := IText, ExampleString := "\d+", ExampleOption := "RegEx"
ExampleNote := """\d+"" search for any sequence of numbers digits! `n" 
}
else if (A_GuiControl = "RegEx 6")
{
ExampleText := IText, ExampleString := "<.*?>|\(.*?\)", ExampleOption := "RegEx"
ExampleNote := """<.*?>"" search for any string enclosed by ""< >""! `n""\(.*?\)"" search for any string enclosed by ""( )""! `n""("" and "")"" are special chars that must be escaped by a ""\"" char!" 
}
else if (A_GuiControl = "RegEx 7")
{
loop, 10
ExampleText .= "`n`n" a_index "`n`n<`nA`nB`nC`n>`n`n(`nA`nB`nC`n)`n`n<ABC>`n`n(ABC)"
ExampleString := "<.*?>|\(.*?\)", ExampleOption := "RegEx"
ExampleNote := "Since regex ""s"" initial option is not in use, ""."" can't match new lines! `n(new lines = ``r``n = Carriage Return + Line Feed)" 
}
else if (A_GuiControl = "RegEx 8")
{
loop, 10
ExampleText .= "`n`n" a_index "`n`n<`nA`nB`nC`n>`n`n(`nA`nB`nC`n)`n`n<ABC>`n`n(ABC)"
ExampleString := "<.*?>|\(.*?\)", ExampleOption := "RegEx(s)"
ExampleNote := "Since regex ""s"" initial option is in use, ""."" can match new lines! `n(new lines = ``r``n = Carriage Return + Line Feed)" 
}
else if (A_GuiControl = "RegEx 9")
{
ExampleText := IText, ExampleString := "A...(H..K)..", ExampleOption := "RegEx SubP"
ExampleNote := ""
. """SubP"" enables regex subpattern search! (""RegEx"" option must be enabled!) `n"
. """SubP, SubP() or SubP(1)"" is for the first subpattern! ""SubP(0)"" all pattern! `n"
. "- In this case, ""(H..K)"" is the first subpattern!"
}
else if (A_GuiControl = "RegEx 10")
{
ExampleText := IText, ExampleString := "(A...)(H..)(K..)", ExampleOption := "RegEx SubP(3)"
ExampleNote := ""
. """SubP(3)"" is for the third subpattern which in this case is ""(K..)"" `n"
. """(A...)"" is the first subpattern! ""(H..)"" is the second subpattern! `n"
. " - ""SubP(4)"" would not be found because the fourth subpattern is not `nspecified in the overall pattern! -"
}
else if (A_GuiControl = "RegEx 11")
{
ExampleText := IText, ExampleString := "(A)(.)(.)(.)(H)(.)(.)(K)(.)(?P<Test>.)", ExampleOption := "RegEx SubP(Test)"
ExampleNote := ""
. """SubP(Test)"" is for the subpattern which name is ""Test"" `n"
. """(A)"" is the first subpattern! In this example we have 10 subpatterns!`n"
. """(?P<Test>.)"" is the tenth subpattern and it is named as ""Test""! `n"
. "- In this case ""SubP(Test)"" is the same as ""SubP(10)""! - `n"
}

;for some reason, GuiControl does not execute g-labels of multilines edit controls!
;GuiControl only execute g-labels of 1 line edit controls!
guicontrol, , TextControl, % ExampleText
guicontrol, , Search1Control, % ExampleString
guicontrol, , Option1Control, % ExampleOption
guicontrol, , NoteControl, % ExampleNote

goto, Search1	;necessary because GuiControl does not execute g-labels of multilines edit controls! (It only execute g-labels of 1 line edit controls!)

return

guiclose:	;__________ Gui close ___________
exitapp


StringSearch(ControlId, String := "", Occurrence := "", Options := "")	;_________________ StringSearch - v1.1 (Function) __________________
{
;If "Options" contains "Fixed" string, the function will search the closest string while typing!
;If "Options" contains "Next" string, the function will search the next string!
;If "Options" contains "Previous" string, the function will search the Previous string!
;If "Options" does not contain none of the above strings, the function will search for the specified "Occurrence"!
;If "Occurrence = 1", the function will search the First Occurrence, if 2, the second Occurrence, if L, the last Occurrence!
;If "Options" contains "-CaseSense" string, Case-Sensitivity is turned Off (Example: "A" is treated as "a", the otherwise is valid too)!
;If "Options" contains "RegEx" or "RegEx()" string, RegExMatch() function is used instead InStr() function!
;RegEx(Initial Options) can be used in "Options"! Example: RegEx(i) or RegEx(m) or RegEx(im) or RegEx(i m)! (This is the only way to specify regex initial options in this function!)
;If "Options" contains "SubP" or "SubP()" string, regex subpattern search is enabled! (RegEx option must be enabled!)
;"SubP, SubP() or SubP(1)" is for the first subpattern, "SubP(0)" all pattern, "SubP(2)" second subpattern, "SubP(year)" for subpattern which name is "year"!
;If "ControlId = A Control Hwnd Id Number", the function will search for the specified "String" in the specified control!
;If "ControlId = FoundPos", the function returns the found string position from the last search! (see return values below!)
;">=1" Found, "0" not Found or regex subpattern being searched was not specified in the overall pattern, "Empty" is probably RegEx Error, "-1" Searching Empty string or empty regex pattern and\or subpattern!)
;If "ControlId = StringLengh, FoundOccurrence or RegExError", the function returns their respective values from the last search!

Static FoundPos, StringLengh, FoundOccurrence, RegExError, OPos, OLen, StartPos, EndPos		;remember values between function calls 

if (ControlId = "FoundPos" or ControlId = "FoundOccurrence" or ControlId = "StringLengh" or ControlId = "RegExError")
return, (%ControlId%)

T_StringCaseSense := A_StringCaseSense	;necessary to restore the thread original CaseSense option before function return
StringCaseSense, Off

if InStr(Options, "-CaseSense")		;if "Options" contains "-CaseSense" String | If the parameter CaseSensitive is omitted or false, the search is not case sensitive (the method of insensitivity depends on StringCaseSense); otherwise, the case must match exactly.
IOptions := "i"				;Disable RegexMatch() case-sensitivity
else
InStrCaseSense := 1		;"1 = true", Enable InStr() case-sensitivity

	if InStr(Options, "RegEx")	;if "Options" contains "RegEx" String | If the parameter CaseSensitive is omitted or false, the search is not case sensitive (the method of insensitivity depends on StringCaseSense); otherwise, the case must match exactly.
	{
	RegEx := 1

	RegExMatch(Options, "is)RegEx\((.*?)\)", Matched)	;All the match is stored in "Matched" variable, match in the first ( ) is stored in "Matched1" variable, match in the second ( ) is stored in "Matched2" variable, and so on ...!
								;"(.*?)" match is stored in "Matched1" variable | ".*" match 0 or more characters | "\" treats "(" and ")" as literal characters
								;"i)", turns on RegEx case-insensitive option (Case-Sense Off) | "s)" option allows "." to match "`r`n" newlines too

	IOptions .= " " Matched1 " "	;add "Matched1" value in "IOptions" Variable (to be used below in RegEx Inicial Options) | (" ") represents a "space" character

		if InStr(Options, "SubP")	;for RegEx subpatterns match
		{
		SubP := 1

		RegExMatch(Options, "is)SubP\((.*?)\)", n)
		n := n1

		if (n = "")
		n := 1

		;EM_GETSEL = 0x00B0, Get start and End Pos of the selected string - Get Caret pos if no string is selected
		DllCall("User32.dll\SendMessage", "Ptr", ControlId, "UInt", 0x00B0, "UIntP", SelStart, "UIntP", SelEnd, "Ptr")

		;Select last saved pattern occurrence in order to allow subpattern "Previous" search to work properly!
		if (SelStart = StartPos and SelEnd = EndPos)	;if the last selected subpattern is still selected, the last saved pattern will be selected!
		SendMessage, 0xB1, % OPos - 1, % OPos - 1 + OLen, , % "ahk_id" ControlId	;"0xB1", EM_SETSEL (select text from position x to y)
		}
	}

if InStr(Options, "Fixed")
Direction := "Fixed"
else if InStr(Options, "Next")
Direction := "Next"
else if InStr(Options, "Previous")
Direction := "Previous"

ControlGetText, ControlText, , % "ahk_id" ControlId	;no "`r`n" is translated to "`n" \ "ahk_id" search controls by their Hwnd Id number

FoundPos := 1, StringLengh := 0		;necessary to start search from string position 1, otherwise, will not work!

LastFoundPos := 0	;prevents "RegEx error (FoundPos = blank)" return value when no string is found while searching "Previous" or "Last" occurrence!

RegExError := ""	;Always blank if regex option is not enabled

;Get start and End Pos of the selected string - Get Caret pos if no string is selected
;https://autohotkey.com/boards/viewtopic.php?p=27979#p27979
;EM_GETSEL = 0x00B0 -> msdn.microsoft.com/en-us/library/bb761598(v=vs.85).aspx
DllCall("User32.dll\SendMessage", "Ptr", ControlId, "UInt", 0x00B0, "UIntP", SelStart, "UIntP", SelEnd, "Ptr")
SelStart++, SelEnd++	;force "1" instead "0" to be recognised as the beginning of the string!

	loop
	{
	FoundOccurrence := A_Index

		if (RegEx != 1)
		{
		FoundPos := InStr(ControlText, String, InStrCaseSense, FoundPos + StringLengh)

		if (a_index = 1)
		StringLengh := StrLen(String)
		}
		else
		{
		FoundPos := RegExMatch(ControlText, IOptions "O)" String, Match, FoundPos + StringLengh)
		;Capital "O" a match object is stored in "Match" variable! This object can be used to retrieve the position, length and value of the overall match and of each captured subpattern, if present.

		RegExError := ErrorLevel	;"0" means no error occurred (https://autohotkey.com/docs/commands/RegExMatch.htm#ErrorLevel)

		StringLengh := Match.Len(0)	;"zero" for the regex overall pattern match lengh.

		if (SubP = 1)
		SubPPos := Match.Pos(n), SubPLen := Match.Len(n)	;stores the specified "n" subpattern Pos\lengh values into their respective variables!
		}

		if (Direction = "Fixed")	;___ Search next occurrence while Typing ___
		{
		if (FoundPos >= SelStart)
		break
		}
		else if (Direction = "Next")	;___ Search next occurrence ___
		{
		if (FoundPos >= SelEnd)
		break
		}
		else if (Direction = "Previous")	;___ Search Previous occurrence ___
		{
			if (FoundPos >= SelStart or FoundPos = "0")
			{
			FoundPos := LastFoundPos, StringLengh := LastStringLengh, FoundOccurrence--

			if (SubP = 1)
			SubPPos := LastSubPPos, SubPLen := LastSubPLen

			break
			}

		LastFoundPos := FoundPos, LastStringLengh := StringLengh

		if (SubP = 1)
		LastSubPPos := SubPPos, LastSubPLen := SubPLen
		}
		else
		{
			if (Occurrence = "L")
			{
				if (FoundPos = 0)
				{
				FoundPos := LastFoundPos, StringLengh := LastStringLengh, FoundOccurrence--

				if (SubP = 1)
				SubPPos := LastSubPPos, SubPLen := LastSubPLen

				break
				}

			LastFoundPos := FoundPos, LastStringLengh := StringLengh

			if (SubP = 1)
			LastSubPPos := SubPPos, LastSubPLen := SubPLen
			}
			else
			{
			if (a_index = Occurrence)
			break
			}
		}

	if (FoundPos = "0" or FoundPos = "" or StringLengh = "0")	;if "FoundPos" is 0 or blank ("0" String not found | "blank" regex error such as syntax errors)
	break
	}

	if (FoundPos = "0" or FoundPos = "" or StringLengh = "0")	;if "FoundPos" is 0 or blank ("0" String not found | "blank" regex error such as syntax errors)
	{
	if (Direction = "Next")
	SetCaret := SelEnd - 1
	else
	SetCaret := SelStart - 1

	SendMessage, 0xB1, % SetCaret, % SetCaret, , % "ahk_id" ControlId	; 0xB1 = em_setsel | "-1, 0" deselect all | "0, -1" select all | "ahk_id" search control by their hwnd id number
	}
	else
	{
	StartPos := foundpos -1, EndPos := foundpos -1 + StringLengh

		if (SubP = 1)
		{
		OPos := foundpos, OLen := StringLengh	;stores the overall pattern matched Occurrence pos\lengh values in the respective static variables

		if (SubPPos != "")
		foundpos := SubPPos, StringLengh := SubPLen, StartPos := foundpos -1, EndPos := foundpos -1 + StringLengh
		else
		foundpos := 0, StringLengh := "", StartPos := EndPos := SelStart - 1
		;When "SubPPos" is blank, it means that the subpattern being searched was not specified in the overall pattern!
		}

	SendMessage, 0xB1, % EndPos, % StartPos, , % "ahk_id" ControlId	;"0xB1", EM_SETSEL (select text from position x to y - if x < y select from left to right - if x > y select from right to left)
	SendMessage, 0xB7, 0, 0, , % "ahk_id" ControlId			;"0xB7", EM_SCROLLCARET (Scroll control to the Cursor position)
									;"ahk_id" search control by their hwnd id number

	if (SubP != 1 or SubPPos = "")	;prevents the function from selecting the last saved pattern occurrence while enabling subpattern search!
	StartPos := EndPos := ""	;prevents the function from selecting the last saved pattern occurrence when the subpattern being searched is not specified in the overall Pattern! 
	}

if (StringLengh = 0)	;Searching empty string! (or empty regex pattern and\or subpattern!)
FoundPos := -1

StringCaseSense, % T_StringCaseSense	;restore the thread original CaseSense option

	;return, FoundPos	;if "0" string not found | if "blank" probably RegEx error such as syntax errors
}










































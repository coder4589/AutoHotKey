

	;"RegExMatch" can't count Characters\String
	;"RegExReplace" can! ("StringReplace" too, but I think "StringCaseSense" option is not reliable as "RegEx" is)


x := chr(55296) chr(55296) chr(55296) " - 3 Unicode 55296 Surrogate characters! `r`n`r`nAAAaa - BBBB `r`n`r`nD-DDDD `r`nd-dddd `r`nd-dddd `r`n`r`nºº - ºTº - ºYYº - ºUUUº `r`n`r`nº`r`n10 invisibles ``r between >`r`r`r`r`r`r`r`r`r`r< (use keyboard arrows to detect them!) `r`n2 invisibles ``n between >`n`n< (use keyboard arrows to detect them!) `r`nº"

gui, add, edit, w360 h250 +HScroll +HwndEditBox1Id +WantTab,	;"+Hwnd" stores the control id number in "EditBox1Id" variable

ControlSetText, , % x, % "ahk_id" EditBox1Id		;instead "Gui" commands, "ControlSetText" does not translate "`n" to "`r`n" (EOL off - End of Line translation)
					;"ahk_id" search controls by their Hwnd id numbers

gui, show, % "x" A_ScreenWidth/2 - 450, Text

gui, Found: add, edit, ,% ""
. """StrReplace( )"" is faster and can handle Unicode surrogate characters! `r`n"
. """RegExReplace( )"" is slower and can't handle Unicode surrogate characters! `r`n`r`n"

. StringCount(x, chr(55296)) . " occurrences of ""Unicode 55296 Surrogate character"" Found! - ""StrReplace( )"" in use (Correct) `r`n"
. StringCount(x, chr(55296), "RegEx") . " occurrences of ""Unicode 55296 Surrogate character"" Found! - ""RegExReplace( )"" in use (Wrong) `r`n`r`n"

. StringCount(x, "A") . " occurrences of ""A"" Found! `r`n"
. StringCount(x, "a") . " occurrences of ""a"" Found! `r`n"
. StringCount(x, "A", "-CaseSense") . " occurrences of ""A"" Found! (""-CaseSense"" Option in use!) `r`n"
. StringCount(x, "a", "-CaseSense") . " occurrences of ""a"" Found! (""-CaseSense"" Option in use!) `r`n"
. StringCount(x, "B") . " occurrences of ""B"" Found! `r`n"
. StringCount(x, "b") . " occurrences of ""b"" Found! `r`n"
. StringCount(x, "B", "-CaseSense") . " occurrences of ""B"" Found! (""-CaseSense"" Option in use!) `r`n"
. StringCount(x, "b", "-CaseSense") . " occurrences of ""b"" Found! (""-CaseSense"" Option in use!) `r`n`r`n"

. StringCount(x, "^D", "RegEx(m)") . " occurrences of lines which first character is ""D"" (""RegEx(m)"" Option in use!) `r`n"
. StringCount(x, "^d", "RegEx(m)") . " occurrences of lines which first character is ""d"" (""RegEx(m)"" Option in use!) `r`n"
. StringCount(x, "^D", "RegEx(mi)") . " occurrences of lines which first character is ""D"" (""RegEx(mi)"" Option in use!) `r`n"
. StringCount(x, "^d", "RegEx(mi)") . " occurrences of lines which first character is ""d"" (""RegEx(mi)"" Option in use!) `r`n"
. StringCount(x, "^D", "RegEx(m) -CaseSense") . " occurrences of lines which first character is ""D"" (""RegEx(m) -CaseSense"" Option in use!) `r`n"
. StringCount(x, "^d", "RegEx(m) -CaseSense") . " occurrences of lines which first character is ""d"" (""RegEx(m) -CaseSense"" Option in use!) `r`n`r`n"

. StringCount(x, "º.*?º", "RegEx") . " occurrences of "" º 0 or more characters º "" Found (""RegEx"" Option in use!) `r`n"
. StringCount(x, "º.*?º", "RegEx(s)") . " occurrences of "" º 0 or more characters º "" Found (""RegEx(s)"" Option in use!) `r`n`r`n"

. StringCount(x, "\r\n", "RegEx") . " occurrences of ""``r``n"" Found (""RegEx"" Option in use!) `r`n"
. StringCount(x, "\r", "RegEx") . " occurrences of ""Return Carriage (``r)"" Found (""RegEx"" Option in use!) `r`n"
. StringCount(x, "\n", "RegEx") . " occurrences of ""Line Feed (``n)"" Found (""RegEx"" Option in use!) `r`n"

gui, Found: Show, % "x" A_ScreenWidth/2 - 50, Occurrences Found

return

guiclose:	;____________ Gui Close ______________
foundguiclose:
exitapp


StringCount(Text, String, Options := "")	;______________ StringCount - v1.1 (Function) __________________
{
;if "Options" contains "RegEx" string, "RegExReplace()" function will be used instead "StrReplace()" function!
;Initial RegEx options can be specified like this, "RegEx(im)", "i" for Case-Sense Off, "m" for multi line options, etc, etc - https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#Options)
;if "Options" contains "-CaseSense" string, turns Off case-sensitive (Case-Sense Off)

T_StringCaseSense := A_StringCaseSense	;necessary to restore the thread original CaseSense option before function return

StringCaseSense, Off

	if !InStr(Options, "RegEx")	;"!", if "Options" does not contain "RegEx" String | If the parameter CaseSensitive is omitted or false, the search is not case sensitive (the method of insensitivity depends on StringCaseSense); otherwise, the case must match exactly.
	{
	if !InStr(Options, "-CaseSense")	;"!", if "Options" does not contain "-CaseSense" String | If the parameter CaseSensitive is omitted or false, the search is not case sensitive (the method of insensitivity depends on StringCaseSense); otherwise, the case must match exactly.
	StringCaseSense, On

	StrReplace(Text, String, , Count)	;any "String" will be removed\deleted\replaced with "blank" string, and the number of replacements that occurred will be stored in "Count" variable!
	}
	else
	{
	RegExMatch(Options, "is)RegEx\((.*?)\)", Matched)	;All the match is stored in "Matched" variable, match in the first ( ) is stored in "Matched1" variable, match in the second ( ) is stored in "Matched2" variable, and so on ...!
								;"(.*?)" match is stored in "Matched1" variable | ".*" match 0 or more characters | "\" treats "(" and ")" as literal characters
								;"i)", turns on RegEx case-insensitive option (Case-Sense Off) | "s)" option allows "." to match "`r`n" newlines too

	IOptions .= Matched1 " "		;add "Matched1" value in "IOptions" Variable (to be used below in RegEx Inicial Options) | (" ") represents a "space" character

	if InStr(Options, "-CaseSense")		;if "Options" contains "-CaseSense" String | If the parameter CaseSensitive is omitted or false, the search is not case sensitive (the method of insensitivity depends on StringCaseSense); otherwise, the case must match exactly.
	IOptions .= "i "			;Add "i " string in "IOptions" variable

	RegExReplace(Text, IOptions ")" String, , Count)	;any "String" will be removed\deleted\replaced with "blank" string
								; The Total "String" removed\deleted\replaced will be stored in "Count" variable
								;"IOptions", may contain RegEx Inicial Options, such as, "i" for Case-insensitive on (CaseSense Off), "m" for multilines options, etc, etc (https://autohotkey.com/docs/misc/RegEx-QuickRef.htm#Options) 
								;"s" is a Initial option that allows "." to match "`r`n" newlines too
	}

StringCaseSense, % T_StringCaseSense	;restore the thread original CaseSense option

return, Count
}







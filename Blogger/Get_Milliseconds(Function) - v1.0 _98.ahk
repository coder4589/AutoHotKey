

random_value :=  564574654754

t := Get_Milliseconds(random_value)	;this is the fastest and recommended way to get multiple values (Calculations only once)

msgbox, % ""
. "year         =  " t.y          "`r`n" 
. "year integer =  " t.yi         "`r`n" 
. "year decimal =  " t.yd         "`r`n" 
. "`r`n"
. "Day         =  " t.d             "`r`n" 
. "Day integer =  " t.di          "`r`n" 
. "Day decimal =  " t.dd          "`r`n" 
. "`r`n"
. "Hour         =  " t.h          "`r`n" 
. "Hour integer =  " t.hi         "`r`n" 
. "Hour decimal =  " t.hd         "`r`n"
. "`r`n"
. "Minute         =  " t.m        "`r`n" 
. "Minute integer =  " t.mi       "`r`n" 
. "Minute decimal =  " t.md       "`r`n"
. "`r`n"
. "Second         =  " t.s        "`r`n" 
. "Second integer =  " t.si       "`r`n" 
. "Second decimal =  " t.sd       "`r`n"

	;The below way is recommended only to get single values!
	;Slowest because calculations are repeated every time the function is called!

msgbox, % ""
. "year         =  " Get_Milliseconds(random_value).y          "`r`n" 
. "year integer =  " Get_Milliseconds(random_value).yi         "`r`n" 
. "year decimal =  " Get_Milliseconds(random_value).yd         "`r`n" 
. "`r`n"
. "Day         =  " Get_Milliseconds(random_value).d             "`r`n" 
. "Day integer =  " Get_Milliseconds(random_value).di          "`r`n" 
. "Day decimal =  " Get_Milliseconds(random_value).dd          "`r`n" 
. "`r`n"
. "Hour         =  " Get_Milliseconds(random_value).h          "`r`n" 
. "Hour integer =  " Get_Milliseconds(random_value).hi         "`r`n" 
. "Hour decimal =  " Get_Milliseconds(random_value).hd         "`r`n"
. "`r`n"
. "Minute         =  " Get_Milliseconds(random_value).m        "`r`n" 
. "Minute integer =  " Get_Milliseconds(random_value).mi       "`r`n" 
. "Minute decimal =  " Get_Milliseconds(random_value).md       "`r`n"
. "`r`n"
. "Second         =  " Get_Milliseconds(random_value).s        "`r`n" 
. "Second integer =  " Get_Milliseconds(random_value).si       "`r`n" 
. "Second decimal =  " Get_Milliseconds(random_value).sd       "`r`n"


Get_Milliseconds(mscnds := "", Options := "")	;_______________ v1.0 __________________
{

	;1 Year = 365 Days = 31536000000 Milliseconds (Year = Milliseconds / 31536000000)

	;1 Day = 24 Hours = 86400000 Milliseconds (Day = Milliseconds / 86400000), (Day = Year x 365)

	;1 Hour = 60 Minutes = 3600000 Milliseconds (Hour = Milliseconds / 3600000), (Hour = Day x 24)

	;1 Minutes = 60 Seconds = 60000 Milliseconds (Minute = Milliseconds / 60000), (Minutes = Hour x 60)

	;1 Second = 1000 Milliseconds  (Second = Milliseconds / 1000), (Seconds = Minutes x 60)


static Match_Integer := ".*\."		;RegEx pattern to match integer part of float numbers 
static Match_Decimal := "\..*"		;RegEx pattern to match decimal part of float numbers 

Value := []

if mscnds is not number
mscnds := a_tickcount 		;"a_tickcount", The number of milliseconds since the computer was rebooted

	For K, V in {y:31536000000, d:86400000, h:3600000, m:60000, s:1000}
	{
	value[k]     := mscnds / V
	value[k "i"] := RegExReplace(value[k], Match_Decimal)		;matches and removes decimal part
	value[k "d"] := RegExReplace(value[k], Match_Integer, "0.")	;matches and removes integer part
	}

return, value
}
























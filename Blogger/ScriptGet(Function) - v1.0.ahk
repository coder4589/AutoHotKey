

x := "xxx Script xxx"
y := "yyy Script yyy"
z := {car:"car Script car", Skrrr: "j"}

p := "j", j := "o", o := "r", r := "s", s := "The Best"

f()


f()	;____________ f(Function) ___________
{

x := "xxx f() xxx"
y := "yyy f() yyy"
z := {car: "car f() car"}

test := ScriptGet("z")		;a clone of "z" object from the script will be stored in this function "test" var

test["car"] .= "(Cloned)f()"	;add "(Cloned)f()" string

msgbox, % ""
. x "   _   " ScriptGet("x")  "   _   " x     "`n"
. y "   _   " ScriptGet("y")  "   _   " y     "`n"
. z["car"] "   _   " ScriptGet("z", "car")  "   _   " z["car"]     "`n`n"
. ""
. test["car"]    "`n`n"
. ""
. ScriptGet("p") " - " ScriptGet("p", , 2) " - " ScriptGet("p", , 3) " - " ScriptGet("p", , 4) " - " ScriptGet("p", , 5)  "`n`n"
. ""
. ScriptGet("z", "Skrrr") " - " ScriptGet("z", "Skrrr", 2) " - " ScriptGet("z", "Skrrr", 3) " - " ScriptGet("z", "Skrrr", 4) " - " ScriptGet("z", "Skrrr", 5)   "`n`n"

}


ScriptGet(ScriptGetFunctionx, ScriptGetFunctiony := "", ScriptGetFunctionL := "1")		;_______________ ScriptGet(Function) - v1.0 ___________________
{
	;ScriptGet(x, y := ""), short parameters not in use because parameters are local by default causing the below problem:
	;ScriptGet("x"), would return the value of the function local "x" var instead the script "x" var
	;ScriptGet("y"), would return the value of the function local "y" var instead the script "y" var
	;etc, etc, etc (The same kind of problem happens with Objects)!

	;by using long parameters, the above problem is solved because it is highly improbable that an user will use something like:
	;ScriptGet("ScriptGetFunctionx") or ScriptGet("ScriptGetFunctiony"), etc, etc, etc
	;The same goes for Objects

Global	;Assume Global Mode (All variables are made Global, except the paremeters)

	if (ScriptGetFunctiony == "")		;"==" is always case-sensitive
	{
		if IsObject(%ScriptGetFunctionx%)	;if object
		{
			;A variable never contains an object, it only contains the reference of an object already created
			;the "Clone()" bellow creates a shallow copy of the referenced object
			;the newly created\cloned object's reference will be stored in "ScriptGetFunctiony" var
			;the function then returns the newly created\cloned object's reference
			;since "ScriptGetFunctiony" is a local var, this function will no longer have any reference to the newly created\cloned object after return!

		ScriptGetFunctiony := %ScriptGetFunctionx%.clone()
		return, ScriptGetFunctiony
		}

	loop, % ScriptGetFunctionL
	ScriptGetFunctionx := %ScriptGetFunctionx%

	return, ScriptGetFunctionx
	}
	else
	{
	ScriptGetFunctionx := %ScriptGetFunctionx%[ScriptGetFunctiony]

	loop, % ScriptGetFunctionL - 1
	ScriptGetFunctionx := %ScriptGetFunctionx%

	return, ScriptGetFunctionx
	}
}























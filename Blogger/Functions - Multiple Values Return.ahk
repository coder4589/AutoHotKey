

	;https://autohotkey.com/docs/Functions.htm#return
	;https://autohotkey.com/boards/viewtopic.php?f=5&t=39291
	;I like the "C()" function method the most! (Recommend!)


B(Bam, Boom, Bang)
msgbox, % Bam " \ " Boom " \ " Bang

Array := D()
msgbox, % Array.1 " \ " Array.2 " \ " Array.3

Test := A()
msgbox, % Test.Id " \ " Test.Val " \ " Test.String

msgbox, % A().Id " \ " A().Val " \ " A().String
;in the example above, the function is called 3 times 
;x and y variables are unnecessarily defined for 3 times (I don't recommend)
;below is a better way to use the above method in order to get previous values without redifining the x,y variables!

Msgbox, % A() . A("GetValues").Id " \ " A("GetValues").Val " \ " A("GetValues").String "`n"
;when only "A()" is called, the x,y variables are redefined!
;When A("GetValues").Id is called, the function returns "Id" value, but x,y are not redefined! 
;When A("GetValues").Val is called, the function returns "Val" value, but x,y are not redefined! 
;and so on ...!
;This method does not store any values in the main script variables
;I like the "C()" function method the most! (Recommend!)

msgbox, % C() . C("t") . " \ " . C("u") . " \ " . C("v")
;the function is called 4 times, but t,u,v variables are defined only once through "C()" call!
;I like this method the most because no values are stored in the main script variables!


A(Options := "")
{
static x,y,ReturnValues

if (Options = "GetValues")
return, ReturnValues

msgbox, % "A(Function) Defining x,y"

x++
y--

ReturnValues := {Id: x, Val: y, String: "Function_A"}

return, ReturnValues
}


D()
{
msgbox, % "D(Function) Defining m,n"

m := 7
n := 8

return, [m, n, "Function_D"]
}


B(ByRef w, ByRef z, ByRef o)
{
msgbox, % "B(Function) Defining w,z,o"

w := 3
z := 4
o := "Function_B"
}


C(Options := "")
{
static t,u,v

if (Options = "t" or Options = "u" or Options = "v")
return, (%Options%)

msgbox, % "C(Function) Defining t,u,v"

t := 5
u := 6
v := "Function_C"

	;return, {Id: t, Val: u, String: v, Func: "Alternative"}
	;the return method above can be used simultaneously, K := C(), msgbox % K.Id "\" K.Val "\" K.String "\" K.Func
}








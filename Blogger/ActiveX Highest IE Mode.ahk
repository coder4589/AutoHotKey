	;Tested in windows 7, Internet Explorer 9 installed
	;"ActiveX" WebBrowser control operates in IE7-compatibility mode by default
	;"<meta http-equiv='X-UA-Compatible' content='IE=edge'>" can be used to force the highest IE mode
	;The below self-explanatory code shows how to force the highest IE mode
	;better alternatives are always welcome

JS_Products_Oject = 
(join`r`n
{
"grogu":{"price":50,"Iva":10},

"strela":{"price":100,"Iva":15},

"zzz":"End"}
)

JS_CODE=
(join`r`n

eval(JSON);		//IE8+ only

Products = %JS_Products_Oject%;

Products_Keys = Object.keys(Products).join("|");		//Object.keys(), IE9+ only

alert(JSON + "\r\n\r\n" + Products_Keys + " _ javasript alert from 'js_code' _ (will probably work)");
)

html_Code =
(join`r`n

<!DOCTYPE html>

<meta http-equiv='X-UA-Compatible' content='IE=edge'>

123 <input type="button" value="js alert(Products_Keys)" onclick='alert(Products_Keys)'><br>

<script>

eval(JSON);		//IE8+ only

Products = %JS_Products_Oject%;

Products_Keys = Object.keys(Products).join("|");		//Object.keys(), IE9+ only

alert(JSON + "\r\n\r\n" + Products_Keys + " _ javasript alert from 'html_code' _ (will probably not work)");

</script>

<style> 
#rcorners1 {
  border-radius: 25px;
  background: #73AD21;
  padding: 20px; 
  width: 200px;
  height: 150px;  
}

#rcorners2 {
  border-radius: 25px;
  border: 2px solid #73AD21;
  padding: 20px; 
  width: 200px;
  height: 150px;  
}

#rcorners3 {
  border-radius: 25px;
  background-image: url(https://s3.amazonaws.com/impressivewebs/2014-02/w3schools-logo.jpg);
  background-position: left top;
  background-repeat: repeat;
  padding: 20px; 
  width: 200px;
  height: 150px;  
}
</style>
<p>Rounded corners (IE9+ only) for an element with a specified background color:</p>
<p id="rcorners1">Rounded corners! (IE9+ only)</p>
<p>Rounded corners for an element with a border:</p>
<p id="rcorners2">Rounded corners! (IE9+ only)</p>
<p>Rounded corners for an element with a background image:</p>
<p id="rcorners3">Rounded corners! (IE9+ only)</p>


)

	;msgbox, % JS_Products_Oject

gui, add, edit, w600,

gui, add, listbox, w600 r5, blue|red|yellow|green|white grogu|blue|red|yellow|green|black grogu|

	;_________________

	;"about:" html_Code, enables the highest IE mode, but
	;unfortunately, "about:" html_Code, removes any `r, `n or `r`n from the "html_code" in which causes many issues, such as:
	;JavaScript codes after the first "//comment_line" will not be executed!
	;buttons "on_click" probably will not work
	;in some cases, the "html_code" can't even be rendered (Error message: page can't be loaded)
	;etc

	;gui, add, ActiveX, w600 h400 vIE_ActiveX_Output, % "about:" html_Code
	;IE_ActiveX_Output.silent := true			;ignores javascrit msgboxes errors

	;gui, add, ActiveX, w600 h400 vIE_ActiveX_Output, Shell.Explorer
	;IE_ActiveX_Output.silent := true			;ignores javascrit msgboxes errors
	;IE_ActiveX_Output.Navigate("about:" html_Code)

	;_________________

	;gui, add, ActiveX, w600 h400 vIE_ActiveX_Output, % "about:<meta http-equiv='X-UA-Compatible' content='IE=edge'>"
	;IE_ActiveX_Output.silent := true			;ignores javascrit msgboxes errors
	;IE_ActiveX_Output.document.write(html_Code)		;unfortunately, "document.write()" enables IE8 instead the highest IE mode!

	;gui, add, ActiveX, w600 h400 vIE_ActiveX_Output, HTMLFile
	;IE_ActiveX_Output.silent := true			;ignores javascrit msgboxes errors
	;ComObjError(false)					;disables notification of COM errors [mainly for "eval()" function]
	;IE_ActiveX_Output.open()
	;IE_ActiveX_Output.write(html_Code)		;unfortunately, "write()" enables IE8 instead the highest IE mode!
	;IE_ActiveX_Output.close()

	;_________________

	;in order to use the highest IE mode, "about:" + "innerHTML" + "eval()" should be used separately.

gui, add, ActiveX, w600 h400 vIE_ActiveX_Output, % "about:<!DOCTYPE html><meta http-equiv='X-UA-Compatible' content='IE=edge'><div id='html_code'></div>"
	;IE_ActiveX_Output.silent := true		;ignores javascrit msgboxes errors
	;ComObjError(false)				;disables notification of COM errors [mainly for "eval()" function]
sleep, 250						;necessary in order to "innerHTML" and "eval()" below to work
IE_ActiveX_Output.document.getElementById("html_code").innerHtML := html_code
sleep, 250						;ensures the "html_code" above is completely written in the document
IE_ActiveX_Output.document.parentWindow.eval(js_code)

	;_________________

gui, show

sleep, 200		;necessary to "eval()" below to work

msgbox, % ""
. IE_ActiveX_Output.document.parentWindow.eval("window.JSON + '\r\n\r\n' + window.Object + '\r\n\r\n' + window.Object.keys")      "`r`n`r`n"

	;msgbox, % IE_ActiveX_Output.document.parentWindow.eval("test_test")      "`r`n`r`n"

return

guiclose(){
exitapp
}

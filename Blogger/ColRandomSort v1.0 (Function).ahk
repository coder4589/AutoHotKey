
loop, 15
ListCols .= "Test " a_index "|"

gui, add, listview, w700 h250, % ListCols

loop, 10
LV_Add(, a_index "_ " Chr(a_index + 64), a_index "_ " Chr(a_index + 74), a_index "_ " Chr(a_index + 84), a_index "_ " Chr(a_index + 94), a_index "_ " Chr(a_index + 104), a_index "_ " Chr(a_index + 114), a_index "_ " Chr(a_index + 124),  a_index "_ " Chr(a_index + 134), a_index "_ " Chr(a_index + 144), a_index "_ " Chr(a_index + 154), a_index "_ " Chr(a_index + 164), a_index "_ " Chr(a_index + 174), a_index "_ " Chr(a_index + 184), a_index "_ " Chr(a_index + 194), a_index "_ " Chr(a_index + 204))

gui, add, button, gSort, Sort 1
gui, add, button, x+5 gSort, Sort 1,2
gui, add, button, x+5 gSort, Sort 1,3
gui, add, button, x+5 gSort, Sort 1,4
gui, add, button, x+5 gSort, Sort 1,2,3,4
gui, add, button, x+5 gSort, Sort 15,1
gui, add, button, x+5 gSort, Sort 14,15
gui, add, button, x+5 gSort, Sort 15

gui, add, button, xm gSort, Sort 2,3
gui, add, button, x+5 gSort, Sort 12
gui, add, button, x+5 gSort, Sort 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

gui, show
return

Sort:	;___________ Sort ____________

if (a_guicontrol = "Sort 1")
ColRandomSort("1")

else if (a_guicontrol = "Sort 1,2")
ColRandomSort("1,2")

else if (a_guicontrol = "Sort 1,3")
ColRandomSort("1,3")

else if (a_guicontrol = "Sort 1,4")
ColRandomSort("1,4")

else if (a_guicontrol = "Sort 15,1")
ColRandomSort("15,1")

else if (a_guicontrol = "Sort 14,15")
ColRandomSort("14,15")

else if (a_guicontrol = "Sort 15")
ColRandomSort("15")

else if (a_guicontrol = "Sort 1,2,3,4")
ColRandomSort("1,2,3,4")

else if (a_guicontrol = "Sort 2,3")
ColRandomSort("2,3")

else if (a_guicontrol = "Sort 12")
ColRandomSort("12")

else if (a_guicontrol = "Sort 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15")
ColRandomSort("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15")

return

guiclose:	;__________ Gui close ____________
exitapp


ColRandomSort(Cols)	;______________ ColRandomSort(Function) v1.0 ________________
{
;"Cols", specify the cols number to be random sorted separated by comma! Example: ColRandomSort("3,10,6,1,2")

TotalRows := LV_GetCount( )	;"LV_GetCount( )",  returns the total number of rows in the listview control

	loop, % TotalRows
	{
	Random, Rdm1, 1, TotalRows	;"1" is the smallest number and  "TotalRows" is the largest number that can be generated
	Random, Rdm2, 1, TotalRows	;"Rdm1" and "Rdm2", the variables where to store the random generated numbers

	StartPos := 1	;necessary, otherwise, the function will not work as intended
	
		while, StartPos := RegExMatch(Cols,"\d+", Match, StartPos + StrLen(Match))
		{
		;"while" is a loop! The loop breaks when no more "\d+" match is found by RegExMatch (when 0 is returned)
		;"StartPos", is the variable where RegExMatch stores the "\d+" match position (if no match is found, 0 is stored)
		;"\d+", match 1 or more Digit\Numbers | "Match" is where the "\d+" match is stored (if no match is found, the variable is made blank)	
		;"StartPos + StrLen(Match)", is the start position for RegExMatch for each loop iteration
		;"StrLen(Match)", returns the number of characters that "Match" variable contains

		LV_GetText(Text1, Rdm1, Match)		;"Match" is col, "Rdm1" is row,  store in "Text1" variable
		LV_GetText(Text2, Rdm2, Match)		;"Match" is col, "Rdm2" is row,  store in "Text2" variable

		LV_Modify(Rdm1, "col" Match, Text2)	;set "Text2" value in "Rdm1" row from "Match" col
		LV_Modify(Rdm2, "col" Match, Text1)	;set "Text1" value in "Rdm2" row from "Match" col
		}
	}
}





var $cr : Text:=Char:C90(Carriage return:K15:38)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		COMPONENT LIST:C1001($components)
		
		$n:=Find in array:C230($components; "4D Embedding Studio")
		If ($n>0)
			$n:=Find in array:C230($components; "4D AIKit")
		End if 
		
		If ($n=-1)
			OBJECT SET VISIBLE:C603(*; "Text"; True:C214)
		End if 
		
		InitInfo
		PopulateStudents
		
		OBJECT SET ENTERABLE:C238(*; "listboxUpdateRecord"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "listboxSearch"; False:C215)
		
		Form:C1466.trace:=False:C215
		
		Form:C1466.allStudents:=ds:C1482.Students.all()
		Form:C1466.students:=ds:C1482.Students.all()
		
		Form:C1466.configText2:="<span><span style=\"font-weight:bold\">2. Configure the vector</span>"
		Form:C1466.configText2+="<br/>Once the field exists, you configure it by defining its phrase (the text sent to the model) and its model alias. Open the Embedding Studio from the Design menu and configure the vector, as shown below."
		Form:C1466.configText2+="<br/>The current embedding definition for the `student_vector` vector is:</span>"
		
		Form:C1466.forceRecompute:=False:C215
		Form:C1466.generateResults:=""
		Form:C1466.queryText:=""
		Form:C1466.searchResults:=""
		Form:C1466.includeInvalidateVectors:=True:C214
		
		
	: (Form event code:C388=On Page Change:K2:54)
		
		If (FORM Get current page:C276=4)
			Form:C1466.allStudents:=ds:C1482.Students.all()
		End if 
		
	: (Form event code:C388=On Close Box:K2:21)
		If (Is Windows:C1573 && Application info:C1599().SDIMode)
			QUIT 4D:C291
		Else 
			CANCEL:C270
		End if 
		
End case 


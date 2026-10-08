ARRAY TEXT:C222($components; 0)
var $n : Integer

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
		
		Form:C1466.generateResults:=""
		Form:C1466.queryText:=""
		Form:C1466.searchResults:=""
		Form:C1466.includeDirtyVectors:=True:C214
		Form:C1466.threshold:=0.5  // depends on the model: e.g. 0.5 with OpenAI, 0.2 with Ollama embeddinggemma
		
	: (Form event code:C388=On Page Change:K2:54)
		
		// Page 5 (Update Records): reload students so dirty flags reflect the latest Generate
		If (FORM Get current page:C276=5)
			Form:C1466.allStudents:=ds:C1482.Students.all()
		End if 
		
	: (Form event code:C388=On Close Box:K2:21)
		If (Is Windows:C1573 && Application info:C1599().SDIMode)
			QUIT 4D:C291
		Else 
			CANCEL:C270
		End if 
		
End case 


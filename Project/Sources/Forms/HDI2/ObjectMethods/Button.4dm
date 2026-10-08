var $status : Object

If (Form event code:C388=On Clicked:K2:4)
	
	If (Form:C1466.currentStudent=Null:C1517)
		ALERT:C41("Please select a student in the list first.")
		return 
	End if 
	
	$status:=Form:C1466.currentStudent.save()
	If (Not:C34($status.success))
		ALERT:C41("The student could not be saved: "+String:C10($status.statusText))
	End if 
	
End if 

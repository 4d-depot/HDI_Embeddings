//%attributes = {}
// Method: 00_Start
// Description: Main entry point for HDI (How Do I) example
// Checks 4D version compatibility and launches the HDI interface

var $ps; $win : Integer
var $options : Object
var $cr : Text

Case of 
	: (Count parameters:C259=0)
		
		// This is for DOT NOTATION only. Do NOT change 16R5 !!! See below for more info
		// Modify $option variable (below) for minimal version
		If (Application version:C493<"1650")  // 16R5
			ALERT:C41("Sorry, this \"How do I\" (HDI) example must be used with a newer version of 4D (v16 R6 and above)"; "Quit")
			QUIT 4D:C291
		Else 
			// Launch in new process
			$ps:=New process:C317(Current method name:C684; 0; Current method name:C684; 0)
		End if 
		
	Else 
		
		$cr:=Char:C90(Carriage return:K15:38)
		
		// For debug purpose only - show window with title bar if Shift key is held
		If (Shift down:C543)
			$win:=Open form window:C675("HDI"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		Else 
			$win:=Open form window:C675("HDI"; Plain form window no title:K39:19; Horizontally centered:K39:1; Vertically centered:K39:4)
		End if 
		
		// Setup HDI options and information
		$options:=New object:C1471
		
		$options.title:="Generate and use AI embedding vectors"+$cr+"with the 4D Embedding Studio component"
		
		$options.blog:="blog.4d.com"
		$options.info:="AI Embedding feature"
		
		$options.minimumVersion:="2150"  // Format: 1660 means 16R6, 2130 means 21R3
		
		
		// $options.license:=4D View license  // Specify if any license is needed
		
		// THE BACKGROUND PICTURE IS IN THE RESOURCES: Resources/Images/HDIabout.png
		// Picture size: 724 x 364 pixels
		// These 3 commented lines can be removed when done!
		
		// Show HDI about dialog
		DIALOG:C40("HDI"; $options)
		CLOSE WINDOW:C154
		
		// Check if user chose to quit or continue to main form
		If ($options.quit=True:C214)
			QUIT 4D:C291
		Else 
			// Open the main JSON validation form (HDI2)
			$win:=Open form window:C675("HDI2"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("HDI2")
			CLOSE WINDOW:C154
			
		End if 
		
End case 


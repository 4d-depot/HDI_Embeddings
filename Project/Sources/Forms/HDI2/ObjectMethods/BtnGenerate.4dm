var $cr : Text:=Char:C90(Carriage return:K15:38)
var $settings : cs:C1710.EmbeddingStudio.Settings
var $process : cs:C1710.EmbeddingStudio.Process
var $result : cs:C1710.EmbeddingStudio.ProcessResult

If (Form:C1466.trace)
	TRACE:C157
End if 

$process:=cs:C1710.EmbeddingStudio.Process.new()
$result:=$process.process()


If ($result.success)
	Form:C1466.generateResults:=\
		"Done"+$cr+\
		"  Entities updated : "+String:C10($result.entitiesUpdated)+$cr+\
		"  Entities skipped : "+String:C10($result.entitiesSkipped)+$cr+\
		"  Tokens used      : "+String:C10($result.totalTokens)+$cr+\
		"  API calls        : "+String:C10($result.apiCalls)+$cr+\
		"  Duration         : "+String:C10($result.duration)+" ms"
Else 
	Form:C1466.generateResults:="Error"+$cr
	var $err : Object
	For each ($err; $result.errors)
		Form:C1466.generateResults:=Form:C1466.generateResults+" "+$err.message+$cr
	End for each 
End if 

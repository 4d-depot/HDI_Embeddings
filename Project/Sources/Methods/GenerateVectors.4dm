//%attributes = {"invisible":true}
// Method: GenerateVectors
// Description: Runs the Embedding Studio pipeline and returns a readable report
// $force = False -> only entities with a null or dirty vector are processed
// $force = True  -> every vector is recomputed

#DECLARE($force : Boolean)->$report : Text

var $cr : Text:=Char:C90(Carriage return:K15:38)
var $settings : cs:C1710.EmbeddingStudio.Settings
var $process : cs:C1710.EmbeddingStudio.Process
var $result : cs:C1710.EmbeddingStudio.ProcessResult
var $err : Object

$settings:=cs:C1710.EmbeddingStudio.Settings.new()
$process:=cs:C1710.EmbeddingStudio.Process.new($settings; {force: $force})
$result:=$process.process()

If ($result.success)
	$report:=\
		"Done"+$cr+\
		"  Entities updated : "+String:C10($result.entitiesUpdated)+$cr+\
		"  Entities skipped : "+String:C10($result.entitiesSkipped)+$cr+\
		"  Tokens used      : "+String:C10($result.totalTokens)+$cr+\
		"  API calls        : "+String:C10($result.apiCalls)+$cr+\
		"  Duration         : "+String:C10($result.duration)+" ms"
Else 
	$report:="Error"+$cr
	For each ($err; $result.errors)
		$report+=" "+$err.message+$cr
	End for each 
End if 

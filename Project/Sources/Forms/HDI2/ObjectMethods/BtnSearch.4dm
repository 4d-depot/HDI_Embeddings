var $cr : Text:=Char:C90(Carriage return:K15:38)
var $settings : cs:C1710.EmbeddingStudio.Settings
var $definition : cs:C1710.EmbeddingStudio.Definition
var $process : cs:C1710.EmbeddingStudio.Playground
var $result : cs:C1710.EmbeddingStudio.EmbedderResult

If (Form:C1466.queryText="")
	ALERT:C41("Please enter a search query.")
	return 
End if 

If (Form:C1466.trace)
	TRACE:C157
End if 

$settings:=cs:C1710.EmbeddingStudio.Settings.new()
$definition:=$settings.find("Students"; "student_vector")
If ($definition=Null:C1517)
	Form:C1466.searchResults:="No definition found. Check Settings/embeddings.json."
	return 
End if 

$process:=cs:C1710.EmbeddingStudio.Playground.new()
$result:=$process.embed(Form:C1466.queryText; $definition)
If ($result.vector=Null:C1517)
	Form:C1466.searchResults:="Error"
	return 
End if 

If (Form:C1466.includeInvalidateVectors=True:C214)
	Form:C1466.students:=ds:C1482.Students.query("student_vector >= :1 order by student_vector desc"; {vector: $result.vector; threshold: 0.2})
Else 
	Form:C1466.students:=ds:C1482.Students.query("student_vector > :1 and (student_vector_dirty=null or student_vector_dirty=0)"; {vector: $result.vector; threshold: 0.2})
End if 


If (Form:C1466.students.length=0)
	Form:C1466.searchResults:="No result"
End if 

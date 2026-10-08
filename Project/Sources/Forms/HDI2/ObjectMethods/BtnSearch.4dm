var $settings : cs:C1710.EmbeddingStudio.Settings
var $definition : cs:C1710.EmbeddingStudio.Definition
var $playground : cs:C1710.EmbeddingStudio.Playground
var $result : cs:C1710.EmbeddingStudio.EmbedderResult
var $query : Text

Form:C1466.searchResults:=""

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

// Embed the query text with the same model as the stored vectors
// (the embedder throws on API errors, e.g. provider unreachable or invalid key)
$playground:=cs:C1710.EmbeddingStudio.Playground.new()
Try
	$result:=$playground.embed(Form:C1466.queryText; $definition)
Catch
	Form:C1466.searchResults:="Error: "+Last errors:C1799[0].message
	return 
End try

If ($result.vector=Null:C1517)
	Form:C1466.searchResults:="Error: no vector returned for the query."
	return 
End if 

// Similarity query: keep students above the threshold, best match first
$query:="student_vector > :1"
If (Not:C34(Form:C1466.includeDirtyVectors))
	$query+=" and student_vector_dirty = false"
End if 
$query+=" order by student_vector desc"

Form:C1466.students:=ds:C1482.Students.query($query; {vector: $result.vector; threshold: Form:C1466.threshold})

If (Form:C1466.students.length=0)
	Form:C1466.searchResults:="No result"
End if 

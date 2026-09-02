//%attributes = {"invisible":true}
var Infos : Collection
var objTabs : Object

// Populate INFO records if the table is empty
If (ds:C1482.INFO.all().length=0)
	
	var $r1 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r1.PageNumber:=1
	$r1.TabTitle:="Overview"
	$r1.Description:="<span>This example shows how to use the 4D Embedding Studio component to generate and store AI embedding vectors directly on your 4D entities.<br/><br/>What are embeddings? <br/>An embedding is a numerical vector representation of a piece of text. Texts with similar meaning produce vectors that are close to each other in the vector space, which enables powerful semantic search. <br/><br/>What this HDI demonstrates:<br/>    • Step 1 – Configure your AI provider and API key in 4D Settings &gt; AI<br/>    • Step 2 – Configure your embeddings in Design &gt; Embedding Studio<br/>    • Step 3 – Generate embedding vectors for all Students records using the configured model and phrase template<br/>    • Step 4 – Search students semantically with a plain-text query <br/><br/>Requirement: 4D 21 R5 or later with an API key for a provider supporting embedding models (e.g. OpenAI text-embedding-3-small).</span>"
	$r1.save()
	
	var $r2 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r2.PageNumber:=2
	$r2.TabTitle:="Configure AI settings"
	$r2.Description:="<span>Before generating embeddings, you need to configure:<br/>   • Your AI provider (e.g. OpenAI)<br/>   • Your API key<br/>   • Your model for the &quot;embed&quot; model alias <br/><br/>Click the Open AI Settings button to open the settings dialog. Once your provider and API key are saved, return to this window.</span>"
	$r2.save()

	var $r3 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r3.PageNumber:=3
	$r3.TabTitle:="Configure Embeddings"
	$r3.Description:="<span>A field 'student_vector_1' has been added to the Students table and defined as class '4D.vector' to store the embeddings.<br/><br/>You can open the Embeddings Studio from the Design menu to configure the vector field, set the phrase template, and choose the model alias.<br/><br/>The current embedding definition for the Students dataclass is:</span>
	$r3.save()
	
	var $r4 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r4.PageNumber:=4
	$r4.TabTitle:="Generate Embeddings"
	$r4.Description:="Click Generate Vectors to embed all Students records. The pipeline:"+Char:C90(13)+"  1. Renders a text phrase for each entity using the configured template"+Char:C90(13)+"  2. Sends the text to the embeddings API (in batches)"+Char:C90(13)+"  3. Stores the resulting 4D.Vector on the student_vector_1 field"+Char:C90(13)+Char:C90(13)+"Enable Force recompute to regenerate all vectors even if they already exist. Without it, only entities with a null vector are processed."+Char:C90(13)+Char:C90(13)+"The result area shows how many entities were updated, tokens consumed, and any errors."
	$r4.save()
	
	var $r5 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r5.PageNumber:=5
	$r5.TabTitle:="Search Embeddings"
	$r5.Description:="Type any text in the query field and click Search. The component:"+Char:C90(13)+"  1. Embeds your query text using the same model"+Char:C90(13)+"  2. Computes the cosine distance between the query vector and each student's vector"+Char:C90(13)+"  3. Returns the 5 most similar students, best match first"+Char:C90(13)+Char:C90(13)+"Because the search is semantic rather than keyword-based, you can use natural language, topics, or descriptions – not just exact field values. Try for example: \"AI research\", \"network security\", or \"loves databases\"."
	$r5.save()
	
End if 

// Load all INFO records ordered by page number
Infos:=ds:C1482.INFO.all().orderBy("PageNumber").toCollection()

// Create tabs object with extracted titles
objTabs:=New object:C1471("values"; Infos.extract("TabTitle"); "index"; 0)
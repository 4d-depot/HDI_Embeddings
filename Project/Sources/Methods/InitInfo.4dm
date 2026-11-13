//%attributes = {"invisible":true}

//ds.INFO.all().drop()
//SET DATABASE PARAMETER([INFO]; Table sequence number; 0)

// Populate INFO records if the table is empty
If (ds:C1482.INFO.all().length=0)
	
	var $r1 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r1.PageNumber:=1
	$r1.TabTitle:="Overview"
	$r1.Description:="<span>This example shows how to generate AI embedding vectors on your 4D entities and use them for semantic search.<br/><br/>"
	$r1.Description+="<span style=\"font-weight:bold\">What are embeddings?</span><br/>An embedding is a vector of numbers that represents the meaning of a text: texts with similar meaning produce close vectors.<br/>"
	$r1.Description+="For example, searching for &quot;apps that are easy to use&quot; finds Grace, whose biography talks about intuitive interfaces and usability tests, although no word matches.<br/><br/>"
	$r1.Description+="<span style=\"font-weight:bold\">Who does what?</span><br/>    • <span style=\"font-weight:bold\">4D</span> natively stores vectors (4D.Vector class) and runs vector similarity queries with query().<br/>"
	$r1.Description+="    • <span style=\"font-weight:bold\">4D AIKit</span> calls the AI provider through the model aliases defined in 4D Settings &gt; AI.<br/>"
	$r1.Description+="    • <span style=\"font-weight:bold\">4D Embedding Studio</span> does the rest: it builds the text sent to the model from your fields, computes vectors in batch, "
	$r1.Description+="and flags them as dirty when the data changes.<br/><br/>"+"<span style=\"font-weight:bold\">What does this HDI demonstrate?</span><br/>Each step has its own tab:<br/>"
	$r1.Description+="    1. <span style=\"font-weight:bold\">Configure AI settings</span> – configure your AI provider and the model alias in 4D Settings &gt; AI<br/>"
	$r1.Description+="    2. <span style=\"font-weight:bold\">Configure Embeddings</span> – define the vector field, its phrase template and its model alias in the Embedding Studio<br/>"
	$r1.Description+="    3. <span style=\"font-weight:bold\">Generate Embeddings</span> – compute the vectors of the Students records, all of them or only the missing and dirty ones<br/>"
	$r1.Description+="    4. <span style=\"font-weight:bold\">Update Records</span> – edit a student and see its vector flagged as dirty, ready to be recomputed<br/>"
	$r1.Description+="    5. <span style=\"font-weight:bold\">Search Embeddings</span> – find students semantically with a plain-text query<br/><br/>"
	$r1.Description+="<span style=\"font-weight:bold\">What do I need?</span><br/>4D 21 R5 or later and an AI provider supporting embedding models.<br/>"
	$r1.Description+="This project is preconfigured for OpenAI with the text-embedding-3-small model: you only need to enter your API key on the <span style=\"font-weight:bold\">Configure AI settings</span> tab.<br/>"
	$r1.Description+="You can also use another provider, such as a local Ollama server with an embedding model (e.g. embeddinggemma).<br/><br/>"
	$r1.Description+="No vector is shipped with this demo: compute them on the <span style=\"font-weight:bold\">Generate Embeddings</span> tab before searching.</span>"
	$r1.save()
	
	var $r2 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r2.PageNumber:=2
	$r2.TabTitle:="Configure AI settings"
	$r2.Description:="<span><span style=\"font-weight:bold\">Set up your AI provider</span><br/>This project is preconfigured for OpenAI: the provider is declared and the &quot;Embed&quot; model alias uses text-embedding-3-small. "
	$r2.Description+="You only need to add your API key:<br/>    1. Click <span style=\"font-weight:bold\">Open 4D AI Settings</span> below.<br/>"
	$r2.Description+="    2. On the <span style=\"font-weight:bold\">Providers</span> tab, enter your <span style=\"font-weight:bold\">API Key</span>, then click <span style=\"font-weight:bold\">Test connection</span>.<br/>"
	$r2.Description+="    3. Click <span style=\"font-weight:bold\">OK</span> to save, then return to this window.<br/><br/>"
	$r2.Description+="<span style=\"font-weight:bold\">Using another provider?</span> Change the <span style=\"font-weight:bold\">Base URL</span> on the Providers tab (no API key is needed for a local Ollama server), "
	$r2.Description+="then select an embedding model for the Embed alias on the <span style=\"font-weight:bold\">Model Aliases</span> tab. "
	$r2.Description+="Then click <span style=\"font-weight:bold\">Generate all vectors</span> on the <span style=\"font-weight:bold\">Generate Embeddings</span> tab: vectors computed with different models cannot be compared.</span>"
	$r2.save()
	
	var $r3 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r3.PageNumber:=3
	$r3.TabTitle:="Configure Embeddings"
	$r3.Description:="<span><span style=\"font-weight:bold\">1. Create the vector field</span><br/>"
	$r3.Description+="In this demo, the Students table already has a <span style=\"font-weight:bold\">student_vector</span> field (Object type, 4D.Vector class) to store the embeddings.<br/><br/>"
	$r3.Description+="It also has a Boolean <span style=\"font-weight:bold\">student_vector_dirty</span> field (vector name + _dirty). "
	$r3.Description+="When a student changes, the component uses it to flag the vector as out of date instead of clearing it, so the student can still be found until the vector is recomputed."
	$r3.Description+="</span>"
	$r3.Description+="<br/><br/><br/>"
	$r3.Description+="<span><span style=\"font-weight:bold\">2. Configure the vector</span><br/>"
	$r3.Description+="In <span style=\"font-weight:bold\">Design &gt; Embedding Studio</span>, select the student_vector line and define:<br/>"
	$r3.Description+="    • <span style=\"font-weight:bold\">Descriptive Phrase</span>: the text sent to the model. Fields between braces are replaced by their values, e.g.:<br/>"
	$r3.Description+="        <span style=\"font-style:italic\">Student {firstName} {lastName}, studying {program}. {bio}</span><br/>"
	$r3.Description+="    • <span style=\"font-weight:bold\">Model</span>: the model alias defined on the <span style=\"font-weight:bold\">Configure AI settings</span> tab (Embed).<br/>"
	$r3.Description+="    • <span style=\"font-weight:bold\">Auto-invalidate on save</span>: flags the vector as dirty when a student is saved (see the <span style=\"font-weight:bold\">Update Records</span> tab).<br/><br/>"
	$r3.Description+="The definition is saved in Settings/embeddings.json.</span>"
	$r3.save()
	
	var $r4 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r4.PageNumber:=4
	$r4.TabTitle:="Generate Embeddings"
	$r4.Description:="<span><span style=\"font-weight:bold\">Which button should I use?</span><br/>"
	$r4.Description+="    • <span style=\"font-weight:bold\">Generate all vectors</span> – recomputes the vector of every student. Use it whenever you change the model or the phrase template: vectors computed with different models cannot be compared.<br/>"
	$r4.Description+="    • <span style=\"font-weight:bold\">Generate invalid vectors</span> – only processes students whose vector is missing or flagged as dirty (see the Update Records page). This is the one to use day to day: the AI provider is only called for what"
	$r4.Description+=" actually changed.<br/><br/>The first time you run this demo, no vector exists yet: both buttons compute all of them.<br/>"
	$r4.Description+="<br/><span style=\"font-weight:bold\">What happens behind the scenes</span><br/>For each student to process, the component:<br/>    1. Renders a text phrase using the configured template<br/>"
	$r4.Description+="    2. Sends the text to the embeddings API (in batches)<br/>    3. Stores the resulting 4D.Vector in the student_vector field<br/><br/>"
	$r4.Description+="The result area shows how many entities were updated, tokens consumed, and any errors. Some local providers such as Ollama do not report token usage, so this counter may stay at 0.</span>"
	$r4.save()
	
	var $r5 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r5.PageNumber:=5
	$r5.TabTitle:="Update Records"
	$r5.Description:="<span><span style=\"font-weight:bold\">Try it:</span><br/>"
	$r5.Description+="    1. Select a student in the list and change a field used in the phrase (e.g. the biography).<br/>"
	$r5.Description+="    2. Click <span style=\"font-weight:bold\">Save</span>: the row turns red and the Dirty column shows Yes.<br/>"
	$r5.Description+="    3. Go back to the <span style=\"font-weight:bold\">Generate Embeddings</span> tab and click <span style=\"font-weight:bold\">Generate invalid vectors</span>: only this student is recomputed.<br/>"
	$r5.Description+="    4. Come back here: the row is no longer red.<br/><br/>"
	$r5.Description+="<span style=\"font-weight:bold\">Why?</span> The embedding definition has <span style=\"font-weight:bold\">Auto-invalidate on save</span> enabled and the Students table has a student_vector_dirty field. Saving the entity does not call the AI"
	$r5.Description+=" provider: the component only flags the vector as dirty, so the vector is recomputed later, in batch.<br/>"
	$r5.Description+="<br/>On the <span style=\"font-weight:bold\">Search Embeddings</span> tab, uncheck <span style=\"font-weight:bold\">Include dirty vectors</span> to exclude students whose vector is out of date.</span>"
	$r5.save()
	
	var $r6 : cs:C1710.INFOEntity:=ds:C1482.INFO.new()
	$r6.PageNumber:=6
	$r6.TabTitle:="Search Embeddings"
	$r6.Description:="<span><span style=\"font-weight:bold\">Try it:</span><br/>"
	$r6.Description+="    1. Type a text in the <span style=\"font-weight:bold\">Search</span> field, for example &quot;AI research&quot;, &quot;network security&quot; or &quot;loves databases&quot;.<br/>"
	$r6.Description+="    2. Click <span style=\"font-weight:bold\">Search</span>: the most similar students are listed, best match first.<br/>"
	$r6.Description+="    3. Uncheck <span style=\"font-weight:bold\">Include dirty vectors</span> and search again to exclude students whose vector is out of date (Dirty column = Yes).<br/>"
	$r6.Description+="    4. Change the <span style=\"font-weight:bold\">Threshold</span> and search again: a higher value keeps only the closest students, a lower value returns more results. "
	$r6.Description+="The right value depends on the model.<br/>"
	$r6.Description+="    5. Click <span style=\"font-weight:bold\">Clear search</span> to list all students again.<br/><br/>"
	$r6.Description+="<span style=\"font-weight:bold\">What happens behind the scenes</span><br/>"
	$r6.Description+="    1. The Embedding Studio component embeds your query text with the same model alias as the stored vectors.<br/>"
	$r6.Description+="    2. 4D runs a native vector similarity query on the student_vector field, using the cosine similarity.<br/>"
	$r6.Description+="    3. Only students whose similarity is above the threshold are kept, best match first.<br/><br/>"
	$r6.Description+="Because the search is semantic rather than keyword-based, you can use natural language, topics or descriptions, not just exact field values.</span>"
	$r6.save()
	
End if 

// Load all INFO records ordered by page number
Form:C1466.Infos:=ds:C1482.INFO.all().orderBy("PageNumber").toCollection()

// Create tabs object with extracted titles
Form:C1466.objTabs:=New object:C1471("values"; Form:C1466.Infos.extract("TabTitle"); "index"; 0)

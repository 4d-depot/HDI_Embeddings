//%attributes = {"invisible":true}
// Method: PopulateStudents
// Description: Creates sample student records if the Students table is empty

If (ds:C1482.Students.all().length=0)
	
	var $data : Collection:=[\
		New object:C1471("firstName"; "Alice"; "lastName"; "Martin"; "program"; "Computer Science"; "bio"; "Alice specializes in machine learning and deep neural networks. She is passionate about AI research and natural language processing."); \
		New object:C1471("firstName"; "Bob"; "lastName"; "Johnson"; "program"; "Data Science"; "bio"; "Bob focuses on statistical analysis, data visualization, and predictive modeling. He enjoys working with large datasets and building dashboards."); \
		New object:C1471("firstName"; "Clara"; "lastName"; "Dubois"; "program"; "Software Engineering"; "bio"; "Clara is an expert in distributed systems and cloud architecture. She has contributed to several open-source projects."); \
		New object:C1471("firstName"; "David"; "lastName"; "Kim"; "program"; "Cybersecurity"; "bio"; "David studies network security, encryption, and ethical hacking. He has competed in multiple CTF (Capture the Flag) competitions."); \
		New object:C1471("firstName"; "Emma"; "lastName"; "Patel"; "program"; "Artificial Intelligence"; "bio"; "Emma works on computer vision and reinforcement learning. Her research focuses on making AI systems more explainable and fair."); \
		New object:C1471("firstName"; "Felix"; "lastName"; "Müller"; "program"; "Database Systems"; "bio"; "Felix is interested in query optimization, distributed databases, and vector search. He loves benchmarking and performance tuning."); \
		New object:C1471("firstName"; "Grace"; "lastName"; "Nguyen"; "program"; "Human-Computer Interaction"; "bio"; "Grace designs intuitive interfaces and studies how people interact with technology. She runs regular usability tests."); \
		New object:C1471("firstName"; "Hugo"; "lastName"; "Silva"; "program"; "Computer Science"; "bio"; "Hugo specializes in algorithms, graph theory, and competitive programming. He has won several national coding contests.")\
		]
	
	var $item : Object
	For each ($item; $data)
		var $s : cs:C1710.StudentsEntity:=ds:C1482.Students.new()
		$s.firstName:=$item.firstName
		$s.lastName:=$item.lastName
		$s.program:=$item.program
		$s.bio:=$item.bio
		$s.save()
	End for each 
	
End if 

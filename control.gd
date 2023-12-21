extends Control

#@onready var DisplayText = $DisplayText
#@onready var ListItem = $ItemList
#@onready var RestardButton = $RestardBtn

var rng = RandomNumberGenerator.new()
var seed = 0
var quizData = " "
var randomGeneratedIndex = 0

#VARIABLES QUIZ
var question = " "
var answer1 = " "
var answer2 = " "
var answer3 = " "
var answer4 = " "
var correctAnswer = 0


func _ready():
	get_data_from_json("res://data/quiz_data.json")
	randomize()
	seed = randi_range(0, 999999999999)
	$TextEdit.text = str(seed)
	rng.seed = seed
	#reset_color_answer()
	
func _process(delta):
	pass

func _on_restard_btn_pressed():
	randomGeneratedIndex = rng.randi_range(1, 543)
	pick_question(randomGeneratedIndex)
	reset_color_answer()
	refresh_ui()	

func _on_init_button_pressed():
	seed = int($TextEdit.text)
	rng.seed = seed
	
func get_data_from_json(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	quizData = json.parse_string(content)

func pick_question(random_index):
	if (quizData.size() >= random_index):
		question = quizData[random_index].get("Question")
		answer1 = quizData[random_index].get("Reponse1")
		answer2 = quizData[random_index].get("Reponse2")
		answer3 = quizData[random_index].get("Reponse3")
		answer4 = quizData[random_index].get("Reponse4")
		correctAnswer = quizData[random_index].get("BonneReponse")
		
		print("get data from index:", random_index)
	else:
		print("Data at index", random_index, "not found")
		return null
		
func refresh_ui():
	$DisplayText.text = str(question)
	$BoxContainer/VBoxContainer/btnAnswer1.text = str(answer1)
	$BoxContainer/VBoxContainer2/btnAnswer2.text = str(answer2)
	$BoxContainer/VBoxContainer/btnAnswer3.text = str(answer3)
	$BoxContainer/VBoxContainer2/btnAnswer4.text = str(answer4)
	
func display_correct_answer(greenButton):
	$BoxContainer/VBoxContainer/btnAnswer1.add_theme_color_override("font_color", Color("FF0000"))
	$BoxContainer/VBoxContainer2/btnAnswer2.add_theme_color_override("font_color", Color("FF0000"))
	$BoxContainer/VBoxContainer/btnAnswer3.add_theme_color_override("font_color", Color("FF0000"))
	$BoxContainer/VBoxContainer2/btnAnswer4.add_theme_color_override("font_color", Color("FF0000"))
	match int(greenButton):
		1:
			$BoxContainer/VBoxContainer/btnAnswer1.add_theme_color_override("font_color", Color("008000"))
		2:
			$BoxContainer/VBoxContainer2/btnAnswer2.add_theme_color_override("font_color", Color("008000"))
		3:
			$BoxContainer/VBoxContainer/btnAnswer3.add_theme_color_override("font_color", Color("008000"))
		4:
			$BoxContainer/VBoxContainer2/btnAnswer4.add_theme_color_override("font_color", Color("008000"))

func reset_color_answer():
	$BoxContainer/VBoxContainer/btnAnswer1.add_theme_color_override("font_color", Color("FFFFFF"))
	$BoxContainer/VBoxContainer2/btnAnswer2.add_theme_color_override("font_color", Color("FFFFFF"))
	$BoxContainer/VBoxContainer/btnAnswer3.add_theme_color_override("font_color", Color("FFFFFF"))
	$BoxContainer/VBoxContainer2/btnAnswer4.add_theme_color_override("font_color", Color("FFFFFF"))	
	
	
func _on_btn_answer_1_pressed():
	display_correct_answer(correctAnswer)

func _on_btn_answer_2_pressed():
	display_correct_answer(correctAnswer)

func _on_btn_answer_3_pressed():
	display_correct_answer(correctAnswer)

func _on_btn_answer_4_pressed():
	display_correct_answer(correctAnswer)

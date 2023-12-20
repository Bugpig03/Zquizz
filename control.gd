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
	rng.seed = seed
	#$DisplayText.text = question
	
func _process(delta):
	pass

func _on_restard_btn_pressed():
	randomGeneratedIndex = rng.randi_range(1, 500)
	pick_question(randomGeneratedIndex)
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


func _on_btn_show_correct_answer_pressed():
	$LabelCorrectAnswer.text = str(correctAnswer)

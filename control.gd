extends Control

# Variables declarations (Process)
var rng_with_seed = RandomNumberGenerator.new()
var quiz_data = " "
var correctAnswer = 0

# Variables for game
var custom_seed = 0
var score = 0
var max_question = 20
var current_question = 0

# Variables for data
var question = " "
var answers = []
var answer1 = " "
var answer2 = " "
var answer3 = " "
var answer4 = " "


func init():
	get_data_from_json("res://data/quiz_data.json") # get data from json
	randomize() # randomize number for random
	define_seed(randi_range(0, 999999999999)) # set seed for the game

func define_seed(int_seed):
	custom_seed = int_seed
	$TextEdit.text = str(custom_seed)
	rng_with_seed.seed = custom_seed
	
func _ready():
	init()
	#random_answer()
	
func _process(delta):
	pass
	
func _on_restard_btn_pressed():
	pick_question(rng_with_seed.randi_range(1, 543))
	reset_color_answer()
	random_answer()
	refresh_ui()	



func get_data_from_json(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	quiz_data = json.parse_string(content)

func pick_question(random_index):
	if (quiz_data.size() >= random_index):
		question = quiz_data[random_index].get("question")
		answers = [quiz_data[random_index].get("right_answer"), quiz_data[random_index].get("fake_answer1"), quiz_data[random_index].get("fake_answer2"), quiz_data[random_index].get("fake_answer3")]
		
		print("get data from index:", random_index)
	else:
		print("Data at index", random_index, "not found")
		return null
		
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
	answer_is_correct(1)
	display_correct_answer(correctAnswer)

func _on_btn_answer_2_pressed():
	answer_is_correct(2)
	display_correct_answer(correctAnswer)

func _on_btn_answer_3_pressed():
	answer_is_correct(3)
	display_correct_answer(correctAnswer)

func _on_btn_answer_4_pressed():
	answer_is_correct(4)
	display_correct_answer(correctAnswer)
	
func _on_check_btn_music_pressed():
	if $HBoxContainer/checkBtnMusic.button_pressed:
		$AudioStreamPlayer_BGM.volume_db = -20
	else:
		$AudioStreamPlayer_BGM.volume_db = -200

func answer_is_correct(player_answer):
	if player_answer == correctAnswer:
		score += 1
		$HBoxContainer2/label_score.text = str(score)
		$AudioStreamPlayer_sound_effect.stream = load("res://audio/sound/SFX_Positive.wav")
		print("correct!")
	else:
		print("fail")
		$AudioStreamPlayer_sound_effect.stream = load("res://audio/sound/SFX_Fail.wav")
	$AudioStreamPlayer_sound_effect.play()


func _on_btn_new_game_pressed():
	define_seed(int($TextEdit.text))
	

func random_answer():
	var save_right_answer = answers[0]
	print(save_right_answer)
	randomize()
	answers.shuffle()
	for i in range(4):
		if (str(save_right_answer) == str(answers[i])):
			print(answers[i])
			correctAnswer = i+1
	
func refresh_ui():
	$DisplayText.text = str(question)
	$BoxContainer/VBoxContainer/btnAnswer1.text = str(answers[0])
	$BoxContainer/VBoxContainer2/btnAnswer2.text = str(answers[1])
	$BoxContainer/VBoxContainer/btnAnswer3.text = str(answers[2])
	$BoxContainer/VBoxContainer2/btnAnswer4.text = str(answers[3])

extends Control

@onready var DisplayText = $DisplayText
@onready var ListItem = $ItemList
@onready var RestardButton = $RestardBtn

var question01 = "Generation d'un chiffre random avec une seed (entre 0 et 100)"
var rng = RandomNumberGenerator.new()
var seed = 0


func _ready():
	randomize()
	rng.seed = seed
	$DisplayText.text = question01
	
func _process(delta):
	pass

func _on_restard_btn_pressed():
	var random_integer = rng.randi_range(0, 100)
	$DisplayText.text = str(random_integer)

func _on_init_button_pressed():
	seed = int($TextEdit.text)
	rng.seed = seed

extends Control

@export var characters: ButtonGroup;

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in characters.get_buttons():
		button.pressed.connect(_on_character_selection);


func _on_character_selection():
	var pressedButtonName = characters.get_pressed_button().name;
	match pressedButtonName:
		"FCharacter":
			GlobalSettings.playerGender = GlobalSettings.Gender.FEMALE;
		_:
			GlobalSettings.playerGender = GlobalSettings.Gender.MALE;

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Root.tscn") # Replace with function body.

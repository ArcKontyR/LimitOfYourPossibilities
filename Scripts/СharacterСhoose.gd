extends Control

@export var characters: ButtonGroup;

func _ready():
	for button in characters.get_buttons():
		button.pressed.connect(_on_character_selection);

func _on_character_selection():
	var pressedButtonName = characters.get_pressed_button().name;
	match pressedButtonName:
		"FCharacter":
			GlobalSettings.save.player.gender = GenderEnum.Gender.FEMALE;
		_:
			GlobalSettings.save.player.gender =  GenderEnum.Gender.MALE;
	GlobalSettings.save.write_savegame();
	
func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Room1.tscn")

extends Control

func _on_start_pressed():
	_create_or_load_save();
		
	


func _on_settings_pressed():
	print("Здесь могла быть ваша реклама");


func _on_exit_pressed():
	get_tree().quit();

func _create_or_load_save() -> void:
	print("on creation");
	if SaveGame.save_exists():
		print("save exists, loading");
		GlobalSettings.save = SaveGame.load_savegame();
		print("loading scene");
		get_tree().change_scene_to_file("res://Scenes/Levels/%s.tscn" % GlobalSettings.save.player.currentMap);
	else:
		print("new save, creating");
		GlobalSettings.save = SaveGame.new();

		GlobalSettings.save.player.currentMap = "Room1";
		GlobalSettings.save.player.position = Vector2.ZERO;

		GlobalSettings.save.write_savegame();
		print("choosing character");
		get_tree().change_scene_to_file("res://Scenes/СharacterСhoose.tscn");

extends Control

func _on_start_pressed():
	_create_or_load_save();

func _on_settings_pressed():
	print("Здесь могла быть ваша реклама");

func _on_exit_pressed():
	GlobalSettings._notification(NOTIFICATION_WM_CLOSE_REQUEST);

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
		GlobalSettings.save.map.pickedItems[GlobalSettings.save.player.currentMap] = [];

		GlobalSettings.save.write_savegame();
		print("choosing character");
		get_tree().change_scene_to_file("res://Scenes/Other/СharacterСhoose.tscn");

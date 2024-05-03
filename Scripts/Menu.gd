extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/СharacterСhoose.tscn");


func _on_settings_pressed():
	print("Здесь могла быть ваша реклама");


func _on_exit_pressed():
	get_tree().quit();

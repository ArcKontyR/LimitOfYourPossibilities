extends Node

@export var save: SaveGame;

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if (save.save_exists()):
			print_rich("[color=green]saving on quit[/color]");
			save.write_savegame();
		get_tree().quit(); # default behavior

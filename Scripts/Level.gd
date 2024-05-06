extends Node2D
@onready var _player = $Player
@onready var _ui_inventory = $UI/Inventory
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_ui_save_panel.reload_requested.connect(_create_or_load_save)
	#_ui_save_panel.save_requested.connect(_save_game)
	if (GlobalSettings.save.map.pickedItems.get(name) == null):
		print("Map items is not saved")
		GlobalSettings.save.map.pickedItems[name] = [];
	# And the start of the game or when pressing the load button, we call this
	# function. It loads the save data if it exists, otherwise, it creates a 
	# new save file.
	_load_save();
	
func _input(event):
	if (Input.is_action_pressed("back")):
		_saveGame();
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _load_save():
	print("current saved map - %s" % GlobalSettings.save.player.currentMap);
	print("this map - %s" % name);
		
	if (GlobalSettings.save.player.position == Vector2.ZERO):
		print_rich("saved position is null = [color=orange]%s[/color]" % [GlobalSettings.save.player.position == Vector2.ZERO]);
		print_rich("saved map is not current = [color=orange]%s[/color]" % [GlobalSettings.save.player.currentMap != name]);
		print("saved position - %s" % GlobalSettings.save.player.position);
		print("saving position - %s" % _player.position);
		GlobalSettings.save.player.position = _player.position;
		#GlobalSettings.save.write_savegame();
	if (GlobalSettings.save.player.previousMap != name):
		var prevMapPos = GlobalSettings.save.player.lastMapPositions.get(name);
		print_rich("[color=lightblue]%s[/color] position loading from [color=green]%s[/color] map" % [prevMapPos, name])
		GlobalSettings.save.player.position = prevMapPos if prevMapPos != null else _player.position;
	
	
		
	_player.set_position(GlobalSettings.save.player.position);
	_ui_inventory.inventory = GlobalSettings.save.inventory;
	_player.stats = GlobalSettings.save.player;

func _saveGame() -> void:
	GlobalSettings.save.player.currentMap = name;
	GlobalSettings.save.player.position = _player.position;
	GlobalSettings.save.player.lastMapPositions[name] = _player.position;
	GlobalSettings.save.write_savegame();

class_name Level
extends Node2D
@onready var _player = $Player
@onready var _ui_inventory = $UI/Inventory
@onready var _animationPlayer = $AnimationPlayer as AnimationPlayer;

func _ready() -> void:
	if (GlobalSettings.save.map.pickedItems.get(name) == null):
		print("Map items is not saved")
		GlobalSettings.save.map.pickedItems[name] = [];
	_load_save();
	_animationPlayer.play("StartScene");
	
func _unhandled_input(event):
	if (event.is_action_pressed("back")):
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
	print("saved %s" % GlobalSettings.save.player.gender);
	print("player gender %s" % _player.stats.gender);

func _saveGame() -> void:
	GlobalSettings.save.player.currentMap = name;
	GlobalSettings.save.player.position = _player.position;
	GlobalSettings.save.player.lastMapPositions[name] = _player.position;
	GlobalSettings.save.write_savegame();

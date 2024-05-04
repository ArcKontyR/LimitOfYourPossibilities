extends Node2D
@onready var _player = $Player
@onready var _ui_inventory = $UI/Inventory
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_ui_save_panel.reload_requested.connect(_create_or_load_save)
	#_ui_save_panel.save_requested.connect(_save_game)
	
	# And the start of the game or when pressing the load button, we call this
	# function. It loads the save data if it exists, otherwise, it creates a 
	# new save file.
	_load_save();
	
func _input(event):
	if (Input.is_action_pressed("back")):
		_save_game();
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _load_save():
	# After creating or loading a save resource, we need to dispatch its data
	# to the various nodes that need it.
	if (GlobalSettings.save.player.position != Vector2.ZERO):
		_player.set_position(GlobalSettings.save.player.position);
	_ui_inventory.inventory = GlobalSettings.save.inventory;
	_player.stats = GlobalSettings.save.player;


func _save_game() -> void:
	print("saved position - %s" % GlobalSettings.save.player.position);
	print("saving position - %s" % _player.position);
	GlobalSettings.save.player.position = _player.position;
	GlobalSettings.save.write_savegame()

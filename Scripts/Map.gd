class_name Map extends Node2D

var emptyItem;
var iconNames =["sausage", "Bomb"];

# Called when the node enters the scene tree for the first time.
func _ready():
	emptyItem = preload("res://Scenes/Item.tscn")
	for i in range(4):
		randomize();
		var itemInstance = emptyItem.instantiate();
		var j = randf_range(0,2);
		itemInstance.createItem(iconNames[j]);
		itemInstance.position = Vector2(int(randf_range(0,400)), int(randf_range(50,450)));
		$Items.add_child(itemInstance);
	pass # Replace with function body.

	
func toggleLevel():
	visible = !visible
	process_mode = PROCESS_MODE_DISABLED if (process_mode == PROCESS_MODE_INHERIT) else PROCESS_MODE_INHERIT;
	pass;

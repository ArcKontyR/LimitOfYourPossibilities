class_name UIItem extends Area2D

@onready var texture_rect = $TextureRect
@export var item: Item = Item.new();
@export var picked: bool = false;
@onready var currentMapName = get_parent().get_parent().name;

func _ready():
	$TextureRect.texture = item.texture;
	#print("this item has %s unique id" % item.uniqueId);
	print_rich("item exists in inventory - [color=orange]%s[/color]" % ["true" if GlobalSettings.save.inventory.items.get(item.uniqueId) != null else "false"]);
	print(GlobalSettings.save.map.pickedItems);
	if (GlobalSettings.save.map.pickedItems[currentMapName].find(name) != -1):
		print_rich("[color=orange]disabling %s...[/color], " % item.uniqueId);
		#print("items holded: %s" % [GlobalSettings.save.inventory.items]);
		
		disable();

func disable():
	queue_free();

func _on_body_entered(body):
	if (body.name == "Player"):
		#print("Player on area");
		body.set_meta("collidesWith", self)


func _on_body_exited(body):
	if (body.name == "Player" && 
		body.has_meta("collidesWith") && 
		body.get_meta("collidesWith") == self):
		#print("Player not in area");
		body.set_meta("collidesWith", null)

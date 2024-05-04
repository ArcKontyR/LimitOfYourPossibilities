class_name UIItem extends Area2D

@onready var texture_rect = $TextureRect
@export var item: Item = Item.new();

func _ready():
	$TextureRect.texture = item.texture;
	#print("this item has %s unique id" % item.uniqueId);
	if (GlobalSettings.save.inventory.items.find(item.uniqueId) != -1):
		print_rich("item exists in inventory - %s, [color=orange]disabling...[/color]" % item.uniqueId);
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

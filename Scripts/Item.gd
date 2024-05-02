class_name Item extends Node2D

@export var _itemName: String = "";
@export var _description: String = "";
@export var _texture: Texture2D;

func _ready():
	if _texture != null:
		$TextureRect.texture = _texture;

func getName():
	return _itemName;

func getTexture():
	return $TextureRect.texture;
	
	
func getDescription():
	return _description;
	
func disable():
	visible = false;
	$CollisionShape2D.disabled = true;
	if is_connected("body_entered", _on_body_entered):
		disconnect("body_entered", _on_body_entered)

func createItem(_name: String, _desc: String = ""):
	_itemName = _name;
	_description = _desc;
	$TextureRect.texture = load("res://Sprites/UI/%s.png" % _name);
	

func _on_body_entered(body):
	if (body.name == "Player"):
		#print("Player on area");
		body.set_meta("collidesWith", self)
	pass # Replace with function body.


func _on_body_exited(body):
	if (body.name == "Player" && 
		body.has_meta("collidesWith") && 
		body.get_meta("collidesWith") == self):
		#print("Player on area");
		body.set_meta("collidesWith", null)

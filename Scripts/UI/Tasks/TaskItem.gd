class_name TaskItem extends Node2D

var _compareCode: int;

func getCode():
	return _compareCode;

func getTexture():
	return $TextureRect.texture;

func setItem(_code: int, imagePath: String = ""):
	_compareCode = _code;
	$TextureRect.texture = load(imagePath);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

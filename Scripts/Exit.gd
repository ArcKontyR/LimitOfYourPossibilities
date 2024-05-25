extends Level

@onready var _background = $Background;

var rotateSpeed: float = 0.2;
# Called when the node enters the scene tree for the first time.
func _ready():
	super();
	print("on exit level");
	_player.disableProcess();
	pass # Replace with function body.

func _physics_process(delta):
	_player.rotate(delta * rotateSpeed); 
	_background.rotation_degrees += -delta * rotateSpeed * 4;

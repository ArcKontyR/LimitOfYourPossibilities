extends PathFollow2D

@onready var teacher = $Teacher as CharacterBody2D;
var direction = 1;
var threshold = 0.002;
@onready var _scale = teacher.scale;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (progress_ratio == 1):
		teacher.scale = Vector2(-_scale.x, _scale.y);
		direction = -1;
		#print("redirecting to right")
	else:
		if (progress_ratio == 0):
			teacher.scale = Vector2(_scale.x, _scale.y);
			#print("redirecting to left")
			direction = 1;
	
	#print(progress_ratio);
	if (!teacher.alerted):
		progress_ratio += threshold * direction;
	pass

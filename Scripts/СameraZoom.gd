extends Camera2D

var factor = 1;
const speed = 100;
const step = 0.03;
const factorStep = 0.01;

var _canZoom = true;

@export var minFactor = 0.8;
@export var maxFactor = 1.2;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zoom.x = clamp(lerp(zoom.x, factor * zoom.x, speed * delta), minFactor, maxFactor);
	zoom.y = clamp(lerp(zoom.y, factor * zoom.y, speed * delta), minFactor, maxFactor);
	
	factor += factorStep if (factor < 1) else -factorStep if (factor > 1) else 0;
	pass
	
func _input(event):
	if event.is_action_pressed("inventory"): _canZoom = !_canZoom;
	if (_canZoom):
		factor -= step * Input.get_axis("zoomUp", "zoomDown")

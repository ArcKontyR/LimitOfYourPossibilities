extends Node

@onready var texture = $TextureRect;
@onready var task = get_parent().get_parent().get_parent().get_node("UI/TaskContainer");

var alerted = false;

signal alertion_changed(alerted: bool);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_body_entered(body):
	#print_rich("[color=yellow]%s[/color] entered an enemy area" % body.name);


func _on_hitbox_body_entered(body):
	if (body is Player):
		print_rich("[color=yellow]%s[/color] entered an enemy area" % body.name);


func _on_view_body_entered(body):
	if (body is Player):
		print_rich("[color=yellow]%s[/color] is alerted!" % name);
		alerted = true;
		alertion_changed.emit(alerted);


func _on_view_body_exited(body):
	if (body is Player):
		print_rich("[color=yellow]%s[/color] isn't alerted anymore" % name);
		alerted = false;
		alertion_changed.emit(alerted);

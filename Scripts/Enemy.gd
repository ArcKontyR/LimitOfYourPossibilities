extends Node

@onready var texture = $TextureRect;
@onready var task = get_parent().get_parent().get_parent().get_node("UI/TaskSwitcher") as TaskSwitcher;

var alerted = false;
var taskCompleted = false;

signal alertion_changed(alerted: bool);

# Called when the node enters the scene tree for the first time.
func _ready():
	taskCompleted = GlobalSettings.save.map.exams.get(name);
	task.checkSuccessful.connect(task_complete);
	pass # Replace with function body.

func _on_hitbox_body_entered(body):
	if (body is Player):
		print_rich("[color=yellow]%s[/color] entered an enemy area" % body.name);
		if (!taskCompleted):
			task.startExam("hard");

func task_complete():
	taskCompleted = true;
	GlobalSettings.save.map.exams[name] = taskCompleted;
	print("task completed");

func _on_view_body_entered(body):
	if (body is Player && !taskCompleted):
		print_rich("[color=yellow]%s[/color] is alerted!" % name);
		alerted = true;
		alertion_changed.emit(alerted);

func _on_view_body_exited(body):
	if (body is Player && alerted):
		print_rich("[color=yellow]%s[/color] isn't alerted anymore" % name);
		alerted = false;
		alertion_changed.emit(alerted);

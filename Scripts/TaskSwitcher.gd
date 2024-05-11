class_name TaskSwitcher
extends Control

signal checkSuccessful;
signal checkFailed;

@onready var hard_task = $HardTask as TaskContainer;
@onready var normal_task = $NormalTask as TaskContainer;

func _ready():
	if visible:
		toggleVisibility();

func startExam(difficulty: String):
	if !visible:
		toggleVisibility();
	match difficulty:
		"hard":
			hard_task.startExam(difficulty);
			hard_task.checkSuccessful.connect(_examCompleted);
			hard_task.checkFailed.connect(_examFailed);
		"normal":
			normal_task.startExam(difficulty);
			normal_task.checkSuccessful.connect(_examCompleted);
			normal_task.checkFailed.connect(_examFailed);
		

func _examCompleted():
	if (hard_task.checkSuccessful.is_connected(_examCompleted)):
		hard_task.checkSuccessful.disconnect(_examCompleted);
	if (normal_task.checkSuccessful.is_connected(_examCompleted)):
		normal_task.checkSuccessful.disconnect(_examCompleted);
	checkSuccessful.emit();
	if visible:
		toggleVisibility();

func _examFailed():
	if (hard_task.checkFailed.is_connected(_examCompleted)):
		hard_task.checkFailed.disconnect(_examCompleted);
	if (normal_task.checkFailed.is_connected(_examCompleted)):
		normal_task.checkFailed.disconnect(_examCompleted);
	checkFailed.emit();
	if visible:
		toggleVisibility();
	
func toggleVisibility():
	visible = !visible;

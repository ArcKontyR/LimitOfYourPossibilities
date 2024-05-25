class_name TaskSwitcher
extends Control

signal checkSuccessful;
signal checkFailed;

@onready var hard_task = $HardTask as TaskContainer;
@onready var normal_task = $NormalTask as TaskContainer;

func _ready():
	if visible:
		toggleVisibility();

func startExam(difficulty: TaskDifficulty.TaskDifficulty):
	if !visible:
		toggleVisibility();
	print(difficulty);
	match difficulty:
		TaskDifficulty.TaskDifficulty.HARD:
			hard_task.startExam(difficulty);
			hard_task.checkSuccessful.connect(_examCompleted);
			hard_task.checkFailed.connect(_examFailed);
		TaskDifficulty.TaskDifficulty.HARDER:
			hard_task.startExam(difficulty);
			hard_task.checkSuccessful.connect(_examCompleted);
			hard_task.checkFailed.connect(_examFailed);
		TaskDifficulty.TaskDifficulty.NORMAL:
			normal_task.startExam(difficulty);
			normal_task.checkSuccessful.connect(_examCompleted);
			normal_task.checkFailed.connect(_examFailed);
		

func _examCompleted():
	_disconnectSignals();
	checkSuccessful.emit();
	if visible:
		toggleVisibility();

func _examFailed():
	_disconnectSignals();
	checkFailed.emit();
	if visible:
		toggleVisibility();
	

func _disconnectSignals():
	if (hard_task.checkFailed.is_connected(_examCompleted)):
		hard_task.checkFailed.disconnect(_examCompleted);
	if (hard_task.checkSuccessful.is_connected(_examCompleted)):
		hard_task.checkSuccessful.disconnect(_examCompleted);
	if (normal_task.checkFailed.is_connected(_examCompleted)):
		normal_task.checkFailed.disconnect(_examCompleted);
	if (normal_task.checkSuccessful.is_connected(_examCompleted)):
		normal_task.checkSuccessful.disconnect(_examCompleted);

func toggleVisibility():
	visible = !visible;

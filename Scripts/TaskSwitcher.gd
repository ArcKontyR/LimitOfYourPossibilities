class_name TaskSwitcher
extends Control

signal checkSuccessful;
signal checkFailed;

@onready var hard_task = $HardTask as TaskContainer;
@onready var normal_task = $NormalTask as TaskContainer;

func _ready():
	if visible:
		toggleVisibility();

func startExam(difficulty: TaskDifficultyEnum.TaskDifficulty):
	if !visible:
		toggleVisibility();
	match difficulty:
		TaskDifficultyEnum.TaskDifficulty.HARD, TaskDifficultyEnum.TaskDifficulty.HARDER:
			hard_task.startExam(difficulty);
			hard_task.checkSuccessful.connect(_examCompleted);
			hard_task.checkButton.checkTryExceeded.connect(_examFailed);
		TaskDifficultyEnum.TaskDifficulty.NORMAL:
			normal_task.startExam(difficulty);
			normal_task.checkSuccessful.connect(_examCompleted);
			normal_task.checkButton.checkTryExceeded.connect(_examFailed);
		

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
	if (hard_task.checkButton.checkTryExceeded.is_connected(_examFailed)):
		hard_task.checkButton.checkTryExceeded.disconnect(_examFailed);
	if (hard_task.checkSuccessful.is_connected(_examCompleted)):
		hard_task.checkSuccessful.disconnect(_examCompleted);
	if (normal_task.checkButton.checkTryExceeded.is_connected(_examFailed)):
		normal_task.checkButton.checkTryExceeded.disconnect(_examFailed);
	if (normal_task.checkSuccessful.is_connected(_examCompleted)):
		normal_task.checkSuccessful.disconnect(_examCompleted);

func toggleVisibility():
	visible = !visible;

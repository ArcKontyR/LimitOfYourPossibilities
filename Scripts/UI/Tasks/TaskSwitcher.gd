class_name TaskSwitcher
extends Control

signal checkSuccessful;
signal checkFailed;

@onready var hard_task = $HardTask as TaskContainer;
@onready var normal_task = $NormalTask as TaskContainer;


func _ready():
	if visible:
		toggleVisibility();

func startExam(difficulty: TaskDifficultyEnum.TaskDifficulty, examCount: int = 1):
	if !visible:
		toggleVisibility();
	match difficulty:
		TaskDifficultyEnum.TaskDifficulty.HARD, TaskDifficultyEnum.TaskDifficulty.HARDER:
			examInitiate(hard_task, difficulty, 1, examCount);
		TaskDifficultyEnum.TaskDifficulty.NORMAL:
			examInitiate(normal_task, difficulty, 1, examCount);
		
func examSuccessful(task: TaskContainer, diff: TaskDifficultyEnum.TaskDifficulty, iteration: int, examCount: int):
	_disconnectSignals(task);
	examInitiate(task, diff, iteration + 1, examCount);
	
func examInitiate(task: TaskContainer, diff: TaskDifficultyEnum.TaskDifficulty, iteration: int, examCount: int):
	print("%s iteration, %s max count" % [iteration, examCount]);
	task.startExam(diff);
	#task.checkSuccessful.connect(_examCompleted);
	if iteration < examCount:
		task.checkSuccessful.connect(examSuccessful.bind(task, diff, iteration, examCount));
		task.checkButton.checkTryExceeded.connect(_examFailed.bind(task));
	else:
		task.checkSuccessful.connect(_examCompleted.bind(task));
		task.checkButton.checkTryExceeded.connect(_examFailed.bind(task));

func _examCompleted(task: TaskContainer):
	_disconnectSignals(task);
	checkSuccessful.emit();
	if visible:
		toggleVisibility();

func _examFailed(task: TaskContainer):
	_disconnectSignals(task);
	checkFailed.emit();
	if visible:
		toggleVisibility();
	

func _disconnectSignals(task: TaskContainer):
	if (task.checkButton.checkTryExceeded.is_connected(_examFailed)):
		task.checkButton.checkTryExceeded.disconnect(_examFailed);
	if (task.checkSuccessful.is_connected(_examCompleted)):
		task.checkSuccessful.disconnect(_examCompleted);
	if (task.checkSuccessful.is_connected(examSuccessful)):
		task.checkSuccessful.disconnect(examSuccessful);

func toggleVisibility():
	visible = !visible;

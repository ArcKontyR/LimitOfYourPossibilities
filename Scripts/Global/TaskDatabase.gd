extends Node

# Maps unique IDs of items to ItemData instances.
var TASKS = {}
var HARD_TASKS = {}
var HARDER_TASKS = {}

func _ready() -> void:
	initializeTasks();

func initializeTasks():
	var items = _load_items();
	var i = 0;
	var hi = 0;
	var hri = 0;
	for item: String in items:
		if (item.contains("harder")):
			print("adding harder task");
			hri+=1;
			HARDER_TASKS[hri] = item;
		elif (item.contains("hard")):
			print("adding hard task");
			hi+=1;
			HARD_TASKS[hi] = item;
		else:
			print("adding normal task");
			i+=1;
			TASKS[i] = item;

func get_task_path(index: int, difficulty: TaskDifficultyEnum.TaskDifficulty = TaskDifficultyEnum.TaskDifficulty.NORMAL) -> String:
	match difficulty:
		TaskDifficultyEnum.TaskDifficulty.HARD: 
			return _get_hard_task_path(index);
		TaskDifficultyEnum.TaskDifficulty.HARDER: 
			return _get_harder_task_path(index);
		_:
			return _get_normal_task_path(index);

func _get_hard_task_path(index:int) -> String:
	if not index in HARD_TASKS:
		printerr("Trying to get nonexistent item %s in items database" % index)
		return "";
	
	return HARD_TASKS[index];
	
func _get_harder_task_path(index:int) -> String:
	if not index in HARDER_TASKS:
		printerr("Trying to get nonexistent item %s in items database" % index)
		return "";
	
	return HARDER_TASKS[index];
	
func _get_normal_task_path(index: int) -> String:
	if not index in TASKS:
		printerr("Trying to get nonexistent item %s in items database" % index)
		return "";
	
	return TASKS[index];

static func _load_items() -> Array:
	var item_files = [];
	var items_folder = "res://Tasks/Definitions";

	var directory = DirAccess.open(items_folder);
	if not directory:
		print_debug('Could not open directory "%s"' % [items_folder])
		return item_files

	directory.list_dir_begin()
	var file_name := directory.get_next()
	while file_name != "":
		if file_name.get_extension() == "json":
			item_files.append("%s/%s" % [items_folder, file_name])
		file_name = directory.get_next()

	var item_resources = []
	for path in item_files:
		item_resources.append(path)

	return item_resources

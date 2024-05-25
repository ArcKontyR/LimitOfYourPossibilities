class_name TaskContainer extends Control

signal checkSuccessful;
signal checkFailed;
signal taskCleared;

@onready var defaultItem = preload("res://Scenes/UI/TaskItem.tscn");

@onready var UI = find_parent("UI");
@onready var answerSlots = $TaskAnswers;
@onready var checkButton = $CheckButton as ExamCheckButton;
@onready var limitSlots = $Task;
@onready var answer_box = self.get_node_or_null("AnswerBox") as TextEdit;

var currentLimitLoaded = {};

func _ready():
	if visible: 
		toggleVisibility();
	checkSuccessful.connect(toggleVisibility);
	
	var slots = answerSlots.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
		
	slots = limitSlots.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
		
	
func loadLimitAsJSON(filePath):
	print(filePath);
	currentLimitLoaded = JsonParser.LoadData(filePath);
	print("%s loaded" % currentLimitLoaded["Name"])
	_initialize();

func _initialize():
	var usedSlotIndexes: Array = [];
	for item in currentLimitLoaded["Parts"]:
		randomize();
		print(item);
		var randomSlotIndex = randi_range(0,answerSlots.get_child_count()-1);
		print("pre while new index - %s" % randomSlotIndex);
		while usedSlotIndexes.find(randomSlotIndex) != -1: 
			randomSlotIndex = randi_range(0,answerSlots.get_child_count()-1);
			print("in while new index - %s" % randomSlotIndex);
			print("binary search index - %s" % usedSlotIndexes.bsearch(randomSlotIndex,true));
		usedSlotIndexes.append(randomSlotIndex);
		print(usedSlotIndexes);
		var answerSlot = answerSlots.get_child(randomSlotIndex);
		var taskItem: TaskItem = defaultItem.instantiate();
		taskItem.setItem(item["CompareCode"], "Tasks/%s" % currentLimitLoaded["Path"]+item["PictureName"]);
		answerSlot.setItem(taskItem);
		print("loaded %s element" % item["CompareCode"]);


func slot_gui_input(event: InputEvent, slot: TaskSlot):
	#print("event happened on slot");
	#print(slot)
	#print(slot.item);
	if event is InputEventMouseButton:
		#print("event is mouse event")
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			#print("event is clicked with left click")
			if UI.holdingItem != null:
				#print("nothing to hold")
				if !slot.item:
					#print("slot empty")
					left_click_empty_slot(slot)
				else:
					#print("slot contains something")
					left_click_different_item(event, slot)
			elif slot.item:
				#print("getting item")
				left_click_not_holding(slot)
				
func _input(event):
	if UI.holdingItem:
		UI.holdingItem.global_position = get_global_mouse_position();
		
	if event.is_action_pressed("back") and visible:
		print("disabling exam");
		toggleVisibility();

func startExam(diff: TaskDifficulty.TaskDifficulty):
	print_rich("starting [color=yellow]%s[/color] difficulty" % diff);
	toggleVisibility();
	if (visible):
		match diff:
			TaskDifficulty.TaskDifficulty.NORMAL:
				_load_tasks(TaskDatabase.TASKS, diff);
			TaskDifficulty.TaskDifficulty.HARD:
				#print("loading hards");
				_load_tasks(TaskDatabase.HARD_TASKS, diff);
			TaskDifficulty.TaskDifficulty.HARDER:
				_load_tasks(TaskDatabase.HARDER_TASKS, diff);
			_:
				printerr("why are we still here");
		
func _load_tasks(tasks: Dictionary, tier: int = 1):
	#print("load tasks with params: needHard - %s, tasks - %s" % [needHard,tasks]);
	randomize();
	var limitNumber: int = randi_range(1, tasks.size());
	loadLimitAsJSON(TaskDatabase.get_task_path(limitNumber, tier));
	
func left_click_empty_slot(slot: TaskSlot):
		slot.setItem(UI.holdingItem)
		UI.holdingItem = null
	
func left_click_different_item(event: InputEvent, slot: TaskSlot):
		var temp_item = slot.getItem()
		temp_item.global_position = event.global_position
		slot.setItem(UI.holdingItem)
		UI.holdingItem = temp_item

func left_click_not_holding(slot: TaskSlot):
	#PlayerInventory.remove_item(slot)
	print("holding");
	UI.holdingItem = slot.getItem()
	UI.holdingItem.global_position = get_global_mouse_position()

func _clearTask():
	var slots = answerSlots.get_children();
	for i in range(slots.size()):
		if (slots[i].item): slots[i].clearItem();
	slots = limitSlots.get_children();
	for i in range(slots.size()):
		if (slots[i].item): slots[i].clearItem();
	taskCleared.emit();

func toggleVisibility():
	visible = !visible;
	#set_process(visible);
	print("exam is visible - %s" % visible);
	if visible == false:
		_clearTask();

func _on_check_button_button_down():
	var slots = limitSlots.get_children();
	for i in range(slots.size()):
		var itemInSlot = slots[i].item;
		if itemInSlot == null:
			print("%s item is empty" % i); 
			checkFailed.emit();
			return;
		var itemInDictionary = currentLimitLoaded["Parts"][i];
		if (itemInSlot.getCode() != itemInDictionary["CompareCode"]):
			print("%s item is wrong, codes does not match" % i);
			checkFailed.emit();
			return;
		if (answer_box != null):
			if (answer_box.text != currentLimitLoaded["Answer"]):
				checkFailed.emit();
				return;
	checkSuccessful.emit();

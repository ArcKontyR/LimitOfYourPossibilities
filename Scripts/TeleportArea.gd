class_name Teleport extends Area2D

@export var shouldExam: bool = false;
var taskComplete: bool = false;

@export var teleportFrom: String;
@export var teleportTo: String;
@export var teleportName: String;

@onready var player = get_parent().get_node("Player");
@onready var task = get_parent().get_node("UI/TaskSwitcher") as TaskSwitcher;
@onready var levelAnimPlayer = get_parent().get_node("AnimationPlayer") as AnimationPlayer;
@onready var hintLabel = $Hint as RichTextLabel;

func _ready():
	var tComplete = GlobalSettings.save.map.exams.get(teleportFrom);
	taskComplete = false if tComplete == null else tComplete;
	task.checkSuccessful.connect(examFinished.bind(true));
	task.checkFailed.connect(examFinished.bind(false));
	
	var actions = InputMap.action_get_events( "interact" )
	var actionEvent = actions[0] as InputEventKey;
	var key = OS.get_keycode_string( actionEvent.physical_keycode ) as String; 
	hintLabel.text = "Нажми [color=red]%s[/color] для перехода" % key;
	hintLabel.hide();
	
	
func _on_body_entered(body):
	if (not body is Player):
		return;
	print("Player on area");
	print("area should exam - %s" % shouldExam)
	if body.teleportInitiate.get_connections().size() > 0:
		print("something is connected")
		var connections: Array = body.teleportInitiate.get_connections();
		for i in connections.size():
			print("last teleport entry disconnected");
			body.teleportInitiate.disconnect(connections[i]["callable"]);
	if (body.teleportInitiate.is_connected(teleport)):
		print("teleport disconnected");
		body.teleportInitiate.disconnect(teleport);
	print("teleport connected");
	body.teleportInitiate.connect(teleport);
	body.set_meta("collidesWith", self)
	
	hintLabel.show();
	
func _on_body_exited(body):
	hintLabel.hide();
	if (body is Player && 
		body.has_meta("collidesWith") && 
		body.get_meta("collidesWith") == self):
		print("Player exited area");
		if (body.teleportInitiate.is_connected(teleport)):
			print("teleport disconnected");
			body.teleportInitiate.disconnect(teleport);
		body.set_meta("collidesWith", null)
		

func teleport(interactedItem: Teleport):
	print("teleport initiated")
	if shouldExam && !taskComplete:
		if not task.checkSuccessful.is_connected(_teleport):
			task.checkSuccessful.connect(_teleport.bind(interactedItem))
		task.startExam("normal");
	else:
		_teleport(interactedItem);
	

func _teleport(interactedItem: Teleport):
	if (task.checkSuccessful.is_connected(_teleport)): 
		task.checkSuccessful.disconnect(_teleport);
	#var currentLevel: Map = get_viewport().get_node(interactedItem.teleportFrom)
	if interactedItem.teleportTo != "": 
		#var level: Map = get_viewport().get_node(interactedItem.teleportTo)
		#level.toggleLevel();
		#currentLevel.toggleLevel(); 
		GlobalSettings.save.player.lastMapPositions[teleportFrom] = player.position;
		GlobalSettings.save.player.previousMap = teleportFrom;
		if (GlobalSettings.save.map.pickedItems.get(teleportTo) == null):
			print("Map items is not saved")
			GlobalSettings.save.map.pickedItems[teleportTo] = [];
		var nextLevelName: String = interactedItem.teleportTo;
		levelAnimPlayer.play("ChangeScene");
		levelAnimPlayer.animation_finished.connect(_changeSceneTo.bind(nextLevelName));

func _changeSceneTo(_animName: String, _sceneName:String):
	get_tree().change_scene_to_file("res://Scenes/Levels/%s.tscn" % _sceneName);

func examFinished(successful: bool):
	GlobalSettings.save.map.exams[teleportFrom] = successful;

	

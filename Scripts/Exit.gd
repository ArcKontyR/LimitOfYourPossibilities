extends Level

@onready var exitTrigger = $ExitTrigger as ExitTrigger;
@onready var animPlayer = $AnimationPlayer as AnimationPlayer;
@onready var background = $Background;

# Called when the node enters the scene tree for the first time.
func _ready():
	super();
	print("on exit level");
	#_player.disableProcess();
	exitTrigger.player_entered_exit_trigger.connect(_on_exittrigger_enter);
	
	pass # Replace with function body.



func _on_exittrigger_enter():
	animPlayer.play("ChangeScene");
	await animPlayer.animation_finished;
	GlobalSettings.save.write_savegame();
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn");
	

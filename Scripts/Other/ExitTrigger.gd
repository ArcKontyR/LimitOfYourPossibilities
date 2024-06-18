class_name ExitTrigger
extends Area2D

signal player_entered_exit_trigger;

func _on_body_entered(body):
	if (not body is Player): 
		return;
	player_entered_exit_trigger.emit();

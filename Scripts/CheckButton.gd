extends Button

signal checkTryExceeded;

var tryCount: int = 0;
const maxTryCount = 3;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_task_container_check_failed():
	tryCount += 1;
	print(tryCount);
	if tryCount == maxTryCount: 
		print("Try count exceeded");
		disabled = true;
		checkTryExceeded.emit();


func _on_task_container_task_cleared():
	tryCount = 0;
	disabled = false;
	pass # Replace with function body.

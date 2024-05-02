extends Button

signal checkTryExceeded;

var tryCount: int = 0;
const maxTryCount = 3;

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

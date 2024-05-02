class_name TaskSlot extends Panel

var item: TaskItem = null
var slot_index;

@onready var UI = get_viewport().get_node("Root/UI");

signal slotItemChanged;

func clearItem():
	remove_child(item)
	item = null;
	
func getItem():
	remove_child(item)
	UI.add_child(item)
	slotItemChanged.emit();
	var _item = item;
	item = null;
	return _item;
	
func setItem(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	UI.remove_child(item)
	add_child(item)
	slotItemChanged.emit();

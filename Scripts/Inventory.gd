class_name Inventory
extends Resource

@export var items = [];

func addItem(item: Item):
	items.push_back(item);
	#print(item);
	#_update();
	emit_changed();
	
func removeItem(index: int):
	var _deletedItem: Item = items.pop_at(index);
	

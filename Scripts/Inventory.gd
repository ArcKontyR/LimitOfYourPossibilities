class_name Inventory
extends Resource

@export var items = [];

func addItem(itemUniqueId: String):
	items.push_back(itemUniqueId);
	#print(item);
	#_update();
	emit_changed();
	
func removeItem(index: int):
	var _deletedItem: Item = items.pop_at(index);
	

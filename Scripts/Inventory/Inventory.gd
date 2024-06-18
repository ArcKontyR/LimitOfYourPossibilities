class_name Inventory
extends Resource

@export var items: Dictionary = {}

func addItem(itemUniqueId: String, amount: int = 1):
	var isGroup = true if itemUniqueId[0] == "g" else false;
	print_rich("id is group - [color=blue]%s[/color]" % isGroup);
	var itemId = "%s_%sp" % [itemUniqueId, amount] if isGroup else itemUniqueId;
	var existingId;
	for key in items.keys():
		if key.contains(itemUniqueId):
			existingId = key;
			break;
	print ("group id contains in items - %s" % existingId)
	if existingId in items:
		print_rich("[color=red]replacing item %s...[/color]" % existingId);
		itemId = "%s_%sp" % [itemUniqueId, get_amount(existingId) + 1] if isGroup else itemUniqueId;
		items[itemId] = get_amount(existingId) + 1;
		print_rich("[color=green]item replaced with %s...[/color]" % itemId);
		remove_item(existingId, get_amount(existingId));
	else:
		print_rich("[color=green]adding item %s...[/color]" % itemId)
		items[itemId] = amount;
	#print(item);
	#_update();
	emit_changed();
	
func get_amount(itemUniqueId: String) -> int:
	if not itemUniqueId in items:
		printerr("Trying to get the amount of item %s but the inventory doesn't have it." % itemUniqueId)
		return -1
	
	return items[itemUniqueId]

	
func remove_item(itemUniqueId: String, amount := 1) -> void:
	if not itemUniqueId in items:
		printerr("Trying to remove item %s but the inventory doesn't have it." % itemUniqueId)
		return

	items[itemUniqueId] -= amount;
	if items[itemUniqueId] <= 0:
		items.erase(itemUniqueId);
	emit_changed();
	

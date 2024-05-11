extends Node

# Maps unique IDs of items to ItemData instances.
var ITEMS := {}


func _ready() -> void:
	var items = _load_items();
	for item in items:
		ITEMS[item.uniqueId] = item


func get_item_data(unique_id: String) -> Item:
	if not unique_id in ITEMS:
		printerr("Trying to get nonexistent item %s in items database" % unique_id)
		return null
	
	return ITEMS[unique_id]


static func _load_items() -> Array:
	var item_files = [];
	var items_folder = "res://Resources/Items";
	print("loading items...");
	var directory = DirAccess.open(items_folder);
	
	if not directory:
		print_debug('Could not open directory "%s"' % [items_folder])
		return item_files
	print(directory.get_files());
	directory.list_dir_begin()
	var file_name := directory.get_next()
	while file_name != "":
		var new_file_name = file_name;
		if new_file_name.get_extension() == "remap":
			new_file_name = file_name.trim_suffix('.remap');
			print("new file name is %s" % file_name);
		if new_file_name.get_extension() == "tres":
			item_files.append("%s/%s" % [items_folder, new_file_name])
		file_name = directory.get_next()

	var item_resources := []
	for path in item_files:
		item_resources.append(load(path))
	directory.list_dir_end();
	# Ensure each loaded item has valid data in debug builds.
	if OS.is_debug_build():
		var ids := []
		var bad_items := []
		for item in item_resources:
			if item.uniqueId in ids:
				bad_items.append(item)
			else:
				ids.append(item.uniqueId)
		for item in bad_items:
			printerr("Item %s has a non-unique ID: %s" % [item.title, item.uniqueId])
	
	for item: Item in item_resources:
		print(item.uniqueId);
			
	return item_resources

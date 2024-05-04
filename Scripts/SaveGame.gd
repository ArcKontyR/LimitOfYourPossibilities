class_name SaveGame
extends Resource

const SAVE_GAME_BASE_PATH := "user://save"

@export var player: Resource = PlayerStatistics.new();
@export var inventory: Resource = Inventory.new();

func write_savegame() -> void:
	print_rich("[color=green]saving...[/color]");
	ResourceSaver.save(self, SaveGame.get_save_path());


static func save_exists() -> bool:
	return ResourceLoader.exists(get_save_path());


static func load_savegame() -> Resource:
	var save_path = get_save_path();
	#print(save_path);
	return ResourceLoader.load(save_path, "");

	
static func get_save_path() -> String:
	var extension = ".tres" if OS.is_debug_build() else ".res"
	return SAVE_GAME_BASE_PATH + extension

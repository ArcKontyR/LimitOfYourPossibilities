extends Panel

var item: Item = null;

var itemUniqueId: String;
@onready var texture_rect := $TextureRect;
@onready var name_label := $Name;
@onready var description := $Description;

func setItem(unique_id: String) -> void:
	itemUniqueId = unique_id;

	var data: Item = ItemDatabase.get_item_data(unique_id);
	texture_rect.texture = data.texture;
	name_label.text = data.title;
	description.text = data.description;
	

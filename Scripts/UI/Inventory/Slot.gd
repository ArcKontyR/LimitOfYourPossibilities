class_name UISlot
extends TextureButton

signal itemSelected(itemUniqueId: String);

var itemUniqueId: String;
@onready var texture_rect := $TextureRect;
@onready var name_label := $Label;

func setItem(unique_id: String) -> void:
	itemUniqueId = unique_id;

	var data: Item = ItemDatabase.get_item_data(unique_id);
	texture_rect.texture = data.texture;
	name_label.text = data.title;

func _on_pressed():
	itemSelected.emit(itemUniqueId);

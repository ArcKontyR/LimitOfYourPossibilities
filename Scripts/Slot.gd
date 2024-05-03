extends TextureButton

signal itemSelected(item: Item);

var _Item: Item;

func setItem(_item: Item):
	_Item = _item;
	$TextureRect.texture = _Item.getTexture();
	$Label.text = _Item.getName();

func _on_pressed():
	itemSelected.emit(_Item);

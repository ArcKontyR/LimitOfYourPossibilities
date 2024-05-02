extends Panel

var _Item: Item = null;

func setItem(_item: Item):
	_Item = _item;
	$TextureRect.texture = _Item.getTexture();
	$Name.text = _Item.getName();
	$Description.text = _Item.getDescription();

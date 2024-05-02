extends Panel

signal itemSelected(item: Item);

var _defaultTex = preload("res://Sprites/UI/InventorySlot.png");
var _hoveredTex = preload("res://Sprites/UI/InventorySlotHovered.png");
var _selectedTex = preload("res://Sprites/UI/InventorySlotSelected.png");

@onready var defaultStyle: StyleBoxTexture = StyleBoxTexture.new();
@onready var hoveredStyle: StyleBoxTexture = StyleBoxTexture.new();
@onready var selectedStyle: StyleBoxTexture = StyleBoxTexture.new();

var _Item: Item;

func setItem(_item: Item):
	_Item = _item;
	$TextureRect.texture = _Item.getTexture();
	$Label.text = _Item.getName();

# Called when the node enters the scene tree for the first time.
func _ready():
	defaultStyle.texture = _defaultTex;
	hoveredStyle.texture = _hoveredTex;
	selectedStyle.texture = _selectedTex;
	pass # Replace with function body.

func _on_mouse_entered():
	_changeStyle(hoveredStyle);


func _on_mouse_exited():
	_changeStyle(defaultStyle);

func _on_gui_input(event):
	if not (event is InputEventMouseButton): return;
	if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		_changeStyle(selectedStyle);
		itemSelected.emit(_Item);
		#__debugData();
	if event.is_released():
		_changeStyle(hoveredStyle);
		
func _changeStyle(style: StyleBoxTexture):
	add_theme_stylebox_override("panel", style);
	
func __debugData():
	print("Item name: %s" % _Item.getName());
	print("Item texture: %s" % _Item.getTexture());
	print("Item amount: %s" % _Item.getAmount());
	print("Item description: %s" % _Item.getDescription());

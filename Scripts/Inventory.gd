class_name Inventory extends Node2D
var _inventory = []

@onready var _slot = preload("res://Scenes/InventorySlot.tscn")

@onready var _slotContainer = get_node("ItemContainer/VBox/Control");
@onready var _selectedSlotContainer = get_node("SelectedItemContainer/SelectedSlot");

func addItem(item: Item):
	#if inventory.size() == 7: return false;
	_inventory.push_back(item);
	#print(item);
	_update();
	return true;
	
func removeItem(index: int):
	var _deletedItem: Item = _inventory.pop_at(index);
	pass;

# Called when the node enters the scene tree for the first time.
func _ready():
	toggleVisibility();
	pass # Replace with function body.

func _update():
	#print(inventory);
	var _newItem: Item = _inventory[-1];
	var _newSlot = _slot.instantiate();
	_newSlot.setItem(_newItem);
	_newSlot.itemSelected.connect(_onItemSelection);
	_slotContainer.add_child(_newSlot)
	

func toggleVisibility():
	visible = !visible;

	
func _input(event):
	if event.is_action_pressed("inventory"):
		toggleVisibility();
			

func _onItemSelection(item):
	_selectedSlotContainer.setItem(item);

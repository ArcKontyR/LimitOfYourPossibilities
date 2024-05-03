class_name UIInventory extends Control
var _inventory: Inventory = null; 

const _slot = preload("res://Scenes/UIInventorySlot.tscn")

@onready var _slotContainer = $ItemContainer/VBox/Control;
@onready var _selectedSlotContainer = $SelectedItemContainer/SelectedSlot;

func addItem(item: Item):
	_inventory.addItem(item);
	_update();
	return true;

func _ready():
	_inventory = Inventory.new();
	if visible:
		toggleVisibility();

func _update():
	#print(inventory);
	for item in _slotContainer.get_children():
		item.queue_free();
		
	for item in _inventory.items:
		#var _newItem: Item = _inventory.items[-1];
		var _newSlot = _slot.instantiate();
		_newSlot.setItem(item);
		_newSlot.itemSelected.connect(_onItemSelection);
		_slotContainer.add_child(_newSlot)
	

func toggleVisibility():
	visible = !visible;

	
func _input(event):
	if event.is_action_pressed("inventory"):
		toggleVisibility();
			

func _onItemSelection(item):
	_selectedSlotContainer.setItem(item);

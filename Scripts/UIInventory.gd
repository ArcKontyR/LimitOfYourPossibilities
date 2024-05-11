class_name UIInventory extends Control
var inventory: Inventory = null: 
	set = _setInventory; 

const _slot = preload("res://Scenes/UI/UIInventorySlot.tscn")

@onready var _slotContainer = $ItemContainer/VBox/Control as Control;
@onready var _selectedSlotContainer = $SelectedItemContainer/SelectedSlot;

func addItem(itemUniqueId: String):
	inventory.addItem(itemUniqueId);
	_update();
	return true;

func _setInventory(new_inventory: Inventory) -> void:
	if inventory != new_inventory:
		new_inventory.changed.connect(_update);
	inventory = new_inventory
	_update()

func _ready():
	inventory = Inventory.new();
	if visible:
		toggleVisibility();

func _update():
	#print(inventory);
	for slot in _slotContainer.get_children():
		slot.queue_free();
		
	for itemUniqueId: String in inventory.items:
		var ui_item: UISlot = _slot.instantiate();
		_slotContainer.add_child(ui_item)
		ui_item.itemSelected.connect(_onItemSelection);
		ui_item.setItem(itemUniqueId)
	

func toggleVisibility():
	visible = !visible;

	
func _input(event):
	if event.is_action_pressed("inventory"):
		toggleVisibility();
			

func _onItemSelection(itemUniqueId):
	_selectedSlotContainer.setItem(itemUniqueId);

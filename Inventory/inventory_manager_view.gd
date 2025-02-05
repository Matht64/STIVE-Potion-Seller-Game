extends Control

var grabbed_slot: Slot
var external_inventory


@onready var seller_inventory_view: PanelContainer = $SellerInventory
@onready var grabbed_slot_view: PanelContainer = $GrabbedSlot
@onready var external_inventory_view: PanelContainer = $ExternalInventory


func _physics_process(_delta: float) -> void:
	#make the grabbed object follow the mouse
	if grabbed_slot_view.visible:
		grabbed_slot_view.global_position = get_global_mouse_position() +  Vector2(5, 5)


func set_seller_inventory_view(inventory: Inventory) -> void:
	inventory.inventory_interact.connect(on_inventory_interact)
	seller_inventory_view.set_inventory_view(inventory)


func set_external_inventory_view(_external_inventory : Inventory) -> void:
	external_inventory = _external_inventory
	external_inventory.inventory_interact.connect(on_inventory_interact)
	external_inventory_view.set_inventory_view(external_inventory)
	external_inventory_view.show()

# à recoder
func clear_external_inventory_view() -> void:
	if external_inventory: 
		external_inventory.inventory_interact.disconnect(on_inventory_interact)
		external_inventory_view.clear_inventory_view(external_inventory)
		external_inventory_view.hide()
		external_inventory = null


func on_inventory_interact(inventory: Inventory, index: int, button: int) -> void:
	#check if the slot grabbed is null or not
	match [grabbed_slot, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.grab_slot(index, button)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.drop_slot(grabbed_slot, index)
		[null, MOUSE_BUTTON_RIGHT]:
			grabbed_slot = inventory.grab_slot(index, button)
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot = inventory.drop_single_slot(grabbed_slot, index)
			
	update_grabbed_slot()


func update_grabbed_slot() -> void:
	#make the object flying once grabbed
	if grabbed_slot:
		grabbed_slot_view.show()
		grabbed_slot_view.set_slot_view(grabbed_slot)
	else:
		grabbed_slot_view.hide()

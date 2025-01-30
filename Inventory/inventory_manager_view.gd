extends Control

var grabbed_slot: Slot
var external_inventory_owner


@onready var seller_inventory_view: PanelContainer = $SellerInventory
@onready var grabbed_slot_view: PanelContainer = $GrabbedSlot
@onready var external_inventory_view: PanelContainer = $ExternalInventory



func _physics_process(_delta: float) -> void:
	#make the grabbed object follow the mouse
	if grabbed_slot_view.visible:
		grabbed_slot_view.global_position = get_global_mouse_position() +  Vector2(5, 5)


func set_seller_inventory(inventory: Inventory) -> void:
	inventory.inventory_interact.connect(on_inventory_interact)
	#player_data.inv = inventory
	seller_inventory_view.set_inventory(inventory)


func set_external_inventory(_external_inventory_owner) -> void:
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	
	inventory_data.inventory_interact.connect(on_inventory_interact)
	external_inventory_view.set_inventory(inventory_data)
	
	external_inventory_view.show()


func clear_external_inventory() -> void:
	if external_inventory_owner: 
		var inventory = external_inventory_owner.inventory
		
		inventory.inventory_interact.disconnect(on_inventory_interact)
		external_inventory_view.clear_inventory(inventory)
		
		external_inventory_view.hide()
		external_inventory_owner = null


func on_inventory_interact(inventory: Inventory, index: int, button: int) -> void:
	#check if the slot grabbed is null or not
	match [grabbed_slot, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.grab_slot(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.drop_slot(grabbed_slot, index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot = inventory.drop_single_slot(grabbed_slot, index)
			
	update_grabbed_slot()


func update_grabbed_slot() -> void:
	#make the flying object once grabbed
	if grabbed_slot:
		grabbed_slot_view.show()
		grabbed_slot_view.set_slot_data(grabbed_slot)
	else:
		grabbed_slot_view.hide()

extends Control

var grabbed_slot_data: SlotData
var external_inventory_owner


@onready var player_inventory: PanelContainer = $PlayerInventory
@onready var grabbed_slot: PanelContainer = $GrabbedSlot
@onready var external_inventory: PanelContainer = $ExternalInventory



func _physics_process(delta: float) -> void:
	#make the grabbed object follow the mouse
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() +  Vector2(5, 5)


func set_player_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_data.inv = inventory_data
	player_inventory.set_inventory_data(inventory_data)


func set_external_inventory(_external_inventory_owner) -> void:
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	
	inventory_data.inventory_interact.connect(on_inventory_interact)
	external_inventory.set_inventory_data(inventory_data)
	
	external_inventory.show()


func clear_external_inventory() -> void:
	if external_inventory_owner: 
		var inventory_data = external_inventory_owner.inventory_data
		
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		external_inventory.clear_inventory_data(inventory_data)
		
		external_inventory.hide()
		external_inventory_owner = null


func on_inventory_interact(inventory_data: InventoryData, index: int, button: int) -> void:
	#check if the slot grabbed is null or not
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)
			
	update_grabbed_slot()


func update_grabbed_slot() -> void:
	#make the object flying once grabbed
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()


func create_inventory_data(item_datas : Array[ItemData]) -> InventoryData :
	var new_inventory_data = InventoryData.new()
	for item in item_datas:
		new_inventory_data.slot_datas.append(new_inventory_data.create_slot_data(item))
	return new_inventory_data

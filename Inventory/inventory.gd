extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/NinePatchRect/ItemGrid


func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)


func clear_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.disconnect(populate_item_grid)


func populate_item_grid(inventory_data: InventoryData) -> void:
	
	# clear the inventory
	for child in item_grid.get_children():
		child.queue_free()
	
	# fill the inventory slot by slot
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
			
		if slot_data:
			slot.set_slot_data(slot_data)

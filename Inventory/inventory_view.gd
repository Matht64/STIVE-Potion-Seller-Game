extends PanelContainer

const SlotView = preload("res://Inventory/slot_view.tscn")

@onready var item_grid: GridContainer = $MarginContainer/NinePatchRect/ItemGrid


func set_inventory_view(inventory: Inventory) -> void:
	inventory.inventory_updated.connect(populate_inventory_view)
	populate_inventory_view(inventory)


func clear_inventory_view(inventory: Inventory) -> void:
	inventory.inventory_updated.disconnect(populate_inventory_view)


func populate_inventory_view(inventory: Inventory) -> void:
	# clear the inventory
	for child in item_grid.get_children():
		child.queue_free()
	
	# fill the inventory slot by slot
	for slot in inventory.slots:
		var slot_view = SlotView.instantiate()
		item_grid.add_child(slot_view)
		
		slot_view.slot_clicked.connect(inventory.on_slot_clicked)
		
		if slot.potion:
			slot_view.set_slot_view(slot)

extends Node2D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
				print("coucou")
				toggle_inventory.emit(self)

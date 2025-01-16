extends PanelContainer

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/SuppHBoxContainer/MarginContainer/SupplierImage

signal supplier_clicked(index: int, button: int)


func set_supplier_data(supplier_data: SupplierData) -> void:
	print("supplier data is set %s" % supplier_data)
	var item_data = supplier_data.item_data
	texture_rect.texture = item_data.texture
	#tooltip_text = "%s\n%s" % [item_data.name]
	supplier_data.unlocked = true
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		supplier_clicked.emit(get_index(), event.button_index)

extends PanelContainer

signal slot_clicked(index: int, button: int)

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity_label: Label = $QuantityLabel

func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name]
	
	#show the quantity only if it's more than 1 else make it grey
	if slot_data.quantity > 0:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()
		#item_data.is_grabbable = true
	else:
		quantity_label.hide()
		texture_rect.modulate = Color(1,1,1,0.5)
		#item_data.is_grabbable = false


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)

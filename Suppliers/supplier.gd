extends PanelContainer

@onready var supplier_image: TextureRect = $MarginContainer/VBoxContainer/SuppHBoxContainer/MarginContainer/SupplierImage
@onready var potion_image: TextureRect = $MarginContainer/VBoxContainer/PotHBoxContainer2/MarginContainer/PotionImage
@onready var supplier_info: RichTextLabel = $MarginContainer/VBoxContainer/SuppHBoxContainer/MarginContainer2/SupplierInfo
@onready var potion_info: RichTextLabel = $MarginContainer/VBoxContainer/PotHBoxContainer2/MarginContainer2/PotionInfo
@onready var panel: PanelContainer = $"."

signal supplier_clicked(index: int, button: int)


func set_supplier_data(supplier_data: SupplierData) -> void:
	var item_data = supplier_data.item_data
	supplier_image.texture = supplier_data.texture
	potion_image.texture = item_data.texture
	supplier_info.text = ("\n\n%s" % supplier_data.name)
	potion_info.text = ("\n\n%s" % item_data.name)
	if not supplier_data.unlocked :
		panel.modulate = Color(1,1,1,0.5)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		supplier_clicked.emit(get_index(), event.button_index)

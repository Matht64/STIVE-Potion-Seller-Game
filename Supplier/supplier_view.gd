extends PanelContainer

@onready var supplier_image: TextureRect = $MarginContainer/VBoxContainer/SuppHBoxContainer/MarginContainer/SupplierImage
@onready var potion_image: TextureRect = $MarginContainer/VBoxContainer/PotHBoxContainer2/MarginContainer/PotionImage
@onready var supplier_info: RichTextLabel = $MarginContainer/VBoxContainer/SuppHBoxContainer/MarginContainer2/SupplierInfo
@onready var potion_info: RichTextLabel = $MarginContainer/VBoxContainer/PotHBoxContainer2/MarginContainer2/PotionInfo
@onready var panel: PanelContainer = $"."

signal supplier_clicked(index: int, button: int)


func set_supplier_view(supplier: Supplier) -> void:
	var potion = supplier.offer.potion
	supplier_image.texture = supplier.image
	potion_image.texture = potion.image
	supplier_info.text = ("\n\n%s" % supplier.name)
	potion_info.text = ("\n\n%s" % potion.name)
	if not supplier in S.seller.suppliers:
		panel.modulate = Color(1,1,1,0.5)


func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		supplier_clicked.emit(get_index(), event.button_index)

extends PanelContainer

signal customer_clicked(index: int)

@onready var name_label: Label = %NameLabel
@onready var texture_rect: TextureRect = %TextureRect
@onready var order_label: Label = %OrderLabel


func set_customer_view(customer: Customer) -> void:
	name_label.text = customer.name 
	texture_rect.texture = customer.image
	order_label.text = ""
	order_label.visible = false
	for order_lines in customer.order.order_lines:
		order_label.text += "%s %s(s)\n" % [order_lines.quantity, order_lines.potion.name]


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
				order_label.visible = true
				customer_clicked.emit(get_index())

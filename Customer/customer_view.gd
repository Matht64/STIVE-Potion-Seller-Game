extends Node2D

signal customer_clicked(index: int)

@onready var name_label: Label = $NameLabel
@onready var texture_rect: TextureRect = $TextureRect


func set_customer_view(customer: Customer) -> void:
	name_label.text = customer.name 
	texture_rect.texture = customer.texture


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
				customer_clicked.emit(get_index())

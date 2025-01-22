extends Node2D

signal toggle_inventory(external_inventory_owner)

@onready var name_label: Label = $NameLabel
@onready var texture_rect: TextureRect = $TextureRect

const CUSTOMER_1 = preload("res://Customer/customer_resources/customer_1.tres")

func _ready() -> void:
	var customer_data = generate_customer_data()
	set_customer_data(customer_data)

func set_customer_data(customer_data: CustomerData) -> void:
	name_label.text = customer_data.name 
	texture_rect.texture = customer_data.texture

func generate_customer_data() -> CustomerData:
	return CUSTOMER_1

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
				print("coucou")
				toggle_inventory.emit(self)

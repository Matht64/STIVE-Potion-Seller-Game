extends Control

@onready var margin_container: MarginContainer = $MarginContainer

const CUSTOMER_VIEW = preload("res://Customer/customer_view.tscn")

func set_customer_view(customer: Customer) -> void:
	customer.customer_interract.connect(populate_margin_container)
	populate_margin_container(customer)


func clear_customer_manager_view(customer: Customer) -> void:
	customer.customer_interract.disconnect(populate_margin_container)


func populate_margin_container(customer: Customer) -> void:
	# clear the customer_manager_view
	for child in margin_container.get_children():
		child.queue_free()

	var customer_view = CUSTOMER_VIEW.instantiate()
	margin_container.add_child(customer_view)
	customer_view.slot_clicked.connect(customer.on_customer_clicked)
		
	if customer:
		customer_view.set_customer_view(customer)

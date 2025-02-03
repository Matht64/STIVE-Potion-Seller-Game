extends Control

@onready var margin_container: MarginContainer = $MarginContainer


const CUSTOMER_VIEW = preload("res://Customer/customer_view.tscn")


func set_customer_view(customer_manager: CustomerManager) -> void:
	populate_customer_manager_view(customer_manager)


#func clear_customer_manager_view(customer: Customer) -> void:
	#customer.customer_interract.disconnect(on_customer_interract)


func populate_customer_manager_view(customer_manager: CustomerManager) -> void:
	# clear the customer_manager_view
	for child in margin_container.get_children():
		child.queue_free()

	var customer = customer_manager.customers[0]
	var customer_view = CUSTOMER_VIEW.instantiate()
	margin_container.add_child(customer_view)
	customer_view.customer_clicked.connect(customer_manager.on_customer_clicked)

	if customer:
		customer_view.set_customer_view(customer)

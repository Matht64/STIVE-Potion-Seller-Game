extends Node

class_name CustomerManager

signal customer_interact(customer: Customer)

@export var customers : Array[Customer]

func _init():
	clear_and_create_customers(5)

func clear_and_create_customers(customer_number : int) -> void: # WIP randomness of Orders
	customers.clear()
	for i in range(customer_number):
		var customer = get_random_customer()
		customer.order = Order.new()
		customers.append(customer)

func get_random_customer() -> Customer:
	var base_res = Resources.customers[randi_range(0, Resources.customers.size()-1)]
	var new_random_customer = Customer.new(
		base_res.id,
		base_res.name,
		base_res.image,
	)
	return new_random_customer

func on_customer_clicked(index: int) -> void:
	customer_interact.emit(customers[index])

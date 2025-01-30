extends Node

class_name CustomerManager

signal customer_interact(customer: Customer)

@export var customers : Array[Customer]

func _init():
	clear_and_create_customers(5)

func clear_and_create_customers(customer_number : int) -> void: # WIP randomness of Orders
	customers.clear()
	for i in range(customer_number):
		var customer_res = get_random_customer_resource()
		customer_res.order = Order.new()
		customers.append(customer_res)

func get_random_customer_resource() -> Resource:
	return Resources.customers[randi_range(0, Resources.customers.size()-1)]

func on_customer_clicked(index: int) -> void:
	customer_interact.emit(customers[index])

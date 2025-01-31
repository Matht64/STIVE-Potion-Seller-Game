extends Node

var customers = [
	load("res://Global/Resources/Customers/customer_1.tres"),
	load("res://Global/Resources/Customers/customer_2.tres")
]

var potions = [
	load("res://Global/Resources/Potions/blue_potion.tres"),
	load("res://Global/Resources/Potions/red_potion.tres"),
	load("res://Global/Resources/Potions/yellow_potion.tres")
]

var suppliers = [
	load("res://Global/Resources/Suppliers/supplier_1.tres"),
	load("res://Global/Resources/Suppliers/supplier_2.tres"),
	load("res://Global/Resources/Suppliers/supplier_3.tres")
]

#@export var customers : Array[Customer]
#@export var potions : Array[Potion]
#@export var suppliers : Array[Supplier]
#
#
#func _init() -> void :
	#for potion_res in potions_res:
		#potions.append(Potion.new(
			#potion_res.id,
			#potion_res.name,
			#potion_res.image,
			#potion_res.price,
		#))
		#
	#for supplier_res in suppliers_res:
		#suppliers.append(Supplier.new(
			#supplier_res.id,
			#supplier_res.name,
			#supplier_res.image,
			#supplier_res.unlock_price,
			#supplier_res.offer,
		#))
	#for customer_res in customers_res:
		#customers.append(Customer.new(
			#customer_res.id,
			#customer_res.name,
			#customer_res.image,
			#customer_res.order,
		#))
	#print("Customers ", customers)
	#print("Suppliers ", suppliers)
	#print("Potions ", potions)

extends Node

class_name InventoryManager

@export var seller_inventory : Inventory
@export var external_inventory : Inventory


func get_seller_inventory(inventory_size : int = 0) -> Inventory:
	if not seller_inventory:
		seller_inventory = Inventory.new(inventory_size)
	return seller_inventory


func inventory_to_order(inventory : Inventory) -> Order:
	var new_order = Order.new()
	new_order.order_lines.clear()
	for slot in inventory.slots:
		new_order.order_lines.append(
			new_order.create_order_line(slot.potion, slot.quantity)
			)
	return new_order

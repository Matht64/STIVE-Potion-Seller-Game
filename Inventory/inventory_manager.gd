extends Node

class_name InventoryManager

@export var seller_inventory : Inventory
@export var external_inventory : Inventory


func get_seller_inventory(inventory_size : int = 0) -> Inventory:
	if not seller_inventory:
		seller_inventory = Inventory.new(inventory_size)
	return seller_inventory


func get_external_inventory() -> Inventory :
	if not external_inventory:
		external_inventory = Inventory.new()
		external_inventory.create_empty_slot(3)
	return external_inventory


func inventory_to_order(inventory : Inventory) -> Order:
	var new_order = Order.new()
	new_order.order_lines.clear()
	for slot_data in inventory.slot_datas:
		new_order.order_lines.append(
			new_order.create_order_line(slot_data.potion, slot_data.quantity)
			)
	return new_order

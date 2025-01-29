extends Node

class_name InventoryManager


func create_inventory(inventory_size : int = 0) -> Inventory:
	return Inventory.new(inventory_size)


func inventory_to_order(inventory : Inventory) -> Order:
	var new_order = Order.new()
	new_order.order_lines.clear()
	for slot_data in inventory.slot_datas:
		new_order.order_lines.append(
			new_order.create_order_line(slot_data.potion, slot_data.quantity)
			)
	return new_order

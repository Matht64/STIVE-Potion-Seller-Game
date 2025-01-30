extends Resource

class_name Customer


@export var name : String
@export var image : AtlasTexture
@export var order : Order


func compareOrder(orderB : Order) -> bool :
	return self.order == orderB

func order_to_inventory(order: Order = self.order) -> Inventory:
	var new_inventory = Inventory.new()
	for order_line in order.order_lines:
		new_inventory.slots.append(
			Slot.new(order_line.potion, order_line.quantity)
			)
	return new_inventory

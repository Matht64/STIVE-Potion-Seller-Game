extends Resource

class_name Customer

@export var id : int
@export var name : String
@export var image : AtlasTexture
@export var order : Order


func _init(_id : int = -1, _name : String = "", _image : AtlasTexture = null, _order : Order = null) -> void :
	self.id = _id
	self.name = _name
	self.image = _image
	self.order = _order

func compareOrder(orderB : Order) -> bool :
	return self.order == orderB

func order_to_inventory(_order: Order = self.order) -> Inventory:
	var new_inventory = Inventory.new()
	for order_line in _order.order_lines:
		new_inventory.slots.append(
			Slot.new(order_line.potion, 0)
			)
	return new_inventory

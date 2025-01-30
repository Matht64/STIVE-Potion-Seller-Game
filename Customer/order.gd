extends Resource

class_name Order

@export var order_lines : Array[OrderLine]


func _init() -> void: # WIP randomness
	var potion : Potion = null
	var quantity : int = 0
	potion = Resources.potions[randi_range(0, Resources.potions.size()-1)]
	quantity = randi_range(1, 10)
	order_lines.append(create_order_line(potion, quantity))


func create_order_line(potion : Potion, quantity : int) -> OrderLine :
	var new_order_line = OrderLine.new(potion, quantity)
	return new_order_line

extends Resource

class_name Order

@export var order_lines : Array[OrderLine]


func _init() -> void: # WIP randomness
	var potion_res = Resources.potions[randi_range(0, Resources.potions.size()-1)]
	var quantity = randi_range(1, 10)
	var potion = Potion.new(
		potion_res.id,
		potion_res.name,
		potion_res.image,
		potion_res.price
	)
	order_lines.append(create_order_line(potion, quantity))


func create_order_line(potion : Potion, quantity : int) -> OrderLine :
	var new_order_line = OrderLine.new(potion, quantity)
	return new_order_line

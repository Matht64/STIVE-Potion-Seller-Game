extends Resource

class_name Customer

@export var name : String
@export var image : AtlasTexture
@export var order : Order


func compareOrder(orderA : Order, orderB : Order) -> bool :
	return orderA == orderB

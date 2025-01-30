extends Resource

class_name Customer


@export var name : String
@export var image : AtlasTexture
@export var order : Order


func compareOrder(orderB : Order) -> bool :
	return self.order == orderB

extends Resource

class_name OrderLine

@export var potion : Potion
@export var quantity : int

func _init(_potion : Potion, _quantity : int) -> void:
	self.potion = _potion
	self.quantity = _quantity

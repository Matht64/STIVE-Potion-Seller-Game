extends Node


var seller : Seller
var inventory_interface : InventoryInterface


func _ready() -> void:
	seller = set_seller()
	

func set_seller() -> Seller:
	return Seller.new()

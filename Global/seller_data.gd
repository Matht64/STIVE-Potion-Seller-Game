extends Node

class_name SellerData

signal gold_change(operation)

var seller : Seller

func _init() -> void :
	seller = Seller.new()

func update_seller_golds(new_operation : int):
	seller.golds += new_operation
	gold_change.emit(new_operation)

extends Resource

class_name Seller

@export var golds : int
@export var suppliers : Array[Supplier]
@export var bonuses : Array[Bonus]
@export var inventory : Inventory


func buy(offer: Offer) -> void :
	pass

func sell(order: Order) -> void :
	pass

func unlockSupplier(supplier: Supplier) -> void :
	pass

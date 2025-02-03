extends Resource

class_name Seller

@export var golds : int
@export var suppliers : Array[Supplier]
@export var bonuses : Array
@export var inventory : Inventory


func _init(_golds : int = -1, _suppliers : Array[Supplier] = [], _bonuses : Array = [], _inventory : Inventory = null) -> void:
	self.golds = _golds
	self.suppliers = _suppliers
	self.bonuses = _bonuses
	self.inventory = _inventory


#func buy(offer: Offer) -> void :
	#pass
#
#func sell(order: Order) -> void :
	#pass
#
#func unlockSupplier(supplier: Supplier) -> void :
	#pass

extends Resource

class_name Seller

@export var golds : int
@export var suppliers : Array[Supplier]
@export var bonuses : Array[Bonus]
@export var inventory : Inventory


func _init(_golds : int = -1, _suppliers : Array[Supplier] = [], _bonuses : Array[Bonus] = [], _inventory : Inventory = null) -> void:
	self.golds = _golds
	self.suppliers = _suppliers
	self.bonuses = _bonuses
	self.inventory = _inventory

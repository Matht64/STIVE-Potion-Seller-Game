extends Node

class_name PlayerData

@export var inv: InventoryData
@export var golds: int

func set_player_data(inventory_data, gold) -> void:
	inv = inventory_data
	golds = gold

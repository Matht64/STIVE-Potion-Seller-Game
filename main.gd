extends Node

@onready var inventory_interface: Control = %InventoryInterface


func _ready() -> void:
	inventory_interface.set_inventory_data(get_inventory())
	pass
	

func display_data(data) -> void:
	print(data)
	

func get_inventory() -> Array[SlotData]:
	var inventoryJSON = GameData
	var inventoryLIST = []
	for slot in inventoryJSON:
		var inventory_item = SlotData.new()
		inventory_item.name = slot.name
		print(inventory_item.name)
		inventoryLIST.append(inventory_item)
	return inventoryLIST



var GameData = [
	{
		"id_user" : 1,
		"id_game_data": 0,
		"gold": 0,
		"potions" : [
			{
				"id": 1,
				"quantity": 2
			},
			{
				"id": 2,
				"quantity": 2
			}
		],
		"supliers" : [
			1,
		],
		"bonuses" : [
			{
				"id": 1,
				"end_date": "2024/12/12",
			}
		]
	}
]

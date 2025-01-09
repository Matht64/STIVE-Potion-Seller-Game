extends Node

@onready var inventory_interface: Control = %InventoryInterface
@onready var external_inventory: PanelContainer = $UI/ScreenHbox/RightScreen/InventoryInterface/ExternalInventory
@onready var stock_interface: Control = $UI/ScreenHbox/LeftScreen/StockInterface


const MAIN = preload("res://main.tscn")

var inv_data = preload("res://test_inv.tres")
var stock_data = preload("res://test_stock.tres")

func _ready() -> void:
	inventory_interface.set_player_inventory_data(inv_data)
	stock_interface.set_player_stock_data(stock_data)
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)


func toggle_inventory_interface(external_inventory_owner = null) -> void:
	if external_inventory_owner:
		external_inventory.visible = not external_inventory.visible
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()


func _on_suppliers_pressed() -> void:
	stock_interface.change_visibility()








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

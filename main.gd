extends Node

@onready var inventory_interface: Control = %InventoryInterface
@onready var external_inventory: PanelContainer = $UI/ScreenHbox/RightScreen/InventoryInterface/ExternalInventory
@onready var stock_interface: Control = $UI/ScreenHbox/LeftScreen/StockInterface
@onready var player_stock: Control = $UI/ScreenHbox/LeftScreen/StockInterface/PlayerStock
@onready var golds_label: Label = $UI/ScreenHbox/RightScreen/Golds


const MAIN = preload("res://main.tscn")
const CUSTOMER = preload("res://Customer/customer.tscn")

var inv_data = preload("res://test_inv.tres")
var stock_data = preload("res://test_stock.tres")
var golds = 100


func _ready() -> void:
	inventory_interface.set_player_inventory_data(inv_data)
	player_data.set_player_data(inv_data, golds)
	stock_interface.set_player_stock_data(stock_data)
	%LeftScreen.add_child(CUSTOMER.instantiate())
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)


func _process(delta: float) -> void:
	golds_label.text ="%s gold(s)" % player_data.golds


func toggle_inventory_interface(external_inventory_owner = null) -> void:
	if external_inventory_owner:
		print("oui")
		external_inventory.visible = not external_inventory.visible
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		print("non")
		inventory_interface.clear_external_inventory()


func _on_suppliers_pressed() -> void:
	player_stock.visible = not player_stock.visible





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

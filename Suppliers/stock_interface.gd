extends Control

@onready var player_stock: Control = $PlayerStock


func change_visibility() -> void:
	if player_stock.visible:
		player_stock.visible = false
	else:
		player_stock.visible = true


func set_player_stock_data(stock_data: StockData) -> void:
	#inventory_data.inventory_interact.connect(on_inventory_interact)
	player_stock.set_stock_data(stock_data)

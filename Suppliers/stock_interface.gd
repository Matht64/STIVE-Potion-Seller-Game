extends Control

@onready var player_stock: Control = $PlayerStock


func set_player_stock_data(stock_data: StockData) -> void:
	player_stock.set_stock_data(stock_data)

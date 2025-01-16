extends Resource

class_name StockData

@export var supplier_datas: Array[SupplierData]

signal supplier_interact(stock_data: StockData, quantity: int, price: int)

func on_supplier_clicked(index: int, button: int) -> void :
	var supplier_data = supplier_datas[index]
	var quantity
	if button == MOUSE_BUTTON_RIGHT:
		quantity = 10
	else:
		quantity = 1
	var total_price = supplier_data.price * quantity
	if total_price <= player_data.golds:
		var supplier_item_data = supplier_datas[index].item_data
		player_data.inv.increment_slot_data(supplier_item_data, quantity, total_price)
	else:
		print("Not enough golds, needs : ", total_price, " got : ", player_data.golds, " gold(s)")

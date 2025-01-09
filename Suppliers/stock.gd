extends Control

const Supplier = preload("res://Suppliers/supplier.tscn")

@onready var supplier_grid: GridContainer = $bg/ScrollContainer/MarginContainer/SupplierGrid
const test_stock = preload("res://test_stock.tres")

func set_stock_data(stock_data: StockData) -> void :
	populate_supplier_grid(test_stock)
	

func populate_supplier_grid(stock_data: StockData) -> void:
	
	# clear the inventory
	for child in supplier_grid.get_children():
		child.queue_free()
	
	# fill the inventory slot by slot
	for supplier_data in stock_data.supplier_datas:
		var supplier = Supplier.instantiate()
		supplier_grid.add_child(supplier)
		
		supplier.supplier_clicked.connect(stock_data.on_supplier_clicked)
			
		if supplier_data:
			supplier.set_supplier_data(supplier_data)

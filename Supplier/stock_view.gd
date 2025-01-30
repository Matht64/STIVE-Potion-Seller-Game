extends Control

const SupplierView = preload("res://Supplier/supplier_view.tscn")

@onready var supplier_grid: GridContainer = $bg/ScrollContainer/MarginContainer/SupplierGrid
#const test_stock = preload("res://test_stock.tres")
#
#
#func set_stock_data(stock_data: StockData) -> void :
	#populate_supplier_grid(test_stock)


func populate_supplier_grid(supplier_manager: SupplierManager) -> void:
	# clear the inventory
	for child in supplier_grid.get_children():
		child.queue_free()
	
	# fill the inventory slot by slot
	for supplier in supplier_manager.suppliers:
		var supplier_view = SupplierView.instantiate()
		supplier_grid.add_child(supplier_view)
		
		supplier_view.supplier_clicked.connect(supplier_manager.on_supplier_clicked)
		
		if supplier:
			supplier_view.set_supplier_data(supplier)

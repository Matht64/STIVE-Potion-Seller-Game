extends Control

const SupplierView = preload("res://Supplier/supplier_view.tscn")

@onready var supplier_grid: GridContainer = $bg/ScrollContainer/MarginContainer/SupplierGrid


func set_stock_view(supplier_manager: SupplierManager) -> void :
	populate_supplier_grid(supplier_manager)


func populate_supplier_grid(supplier_manager: SupplierManager) -> void:
	# clear the supplier_grid
	for child in supplier_grid.get_children():
		child.queue_free()

	for supplier in supplier_manager.suppliers:
		var supplier_view = SupplierView.instantiate()
		supplier_grid.add_child(supplier_view)
		supplier_view.supplier_clicked.connect(supplier_manager.on_supplier_clicked)
		
		if supplier:
			supplier_view.set_supplier_view(supplier)
			

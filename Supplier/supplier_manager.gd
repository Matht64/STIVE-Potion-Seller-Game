extends Node

class_name SupplierManager

@export var suppliers : Array[Supplier]

signal supplier_interract(supplier: Supplier, button)

func _init() -> void:
	for supplier_res in Resources.suppliers:
		suppliers.append(supplier_res)

func unlock_supplier(supplier: Supplier) -> void:
	S.seller.suppliers.append(supplier)
	

func get_suppliers_by_id(suppliers_ids : Array) -> Array[Supplier]:
	var suppliers_by_ids : Array[Supplier] = []
	for supplier_id in suppliers_ids:
		for supplier in suppliers:
			if supplier_id == supplier.id:
				suppliers_by_ids.append(supplier)
	return suppliers_by_ids


func on_supplier_clicked(index : int, button : int) -> void :
	supplier_interract.emit(suppliers[index], button)

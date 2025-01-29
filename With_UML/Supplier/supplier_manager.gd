extends Node

class_name SupplierManager

@export var suppliers : Array[Supplier]

func _init() -> void:
	for supplier_res in Resources.suppliers:
		suppliers.append(supplier_res)

func get_suppliers_by_id(suppliers_ids : Array) -> Array[Supplier]:
	var suppliers_by_ids : Array[Supplier] = []
	for supplier_id in suppliers_ids:
		for supplier in suppliers:
			if supplier_id == supplier.id:
				suppliers_by_ids.append(supplier)
	return suppliers_by_ids

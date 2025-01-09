extends Resource

class_name StockData

@export var supplier_datas: Array[SupplierData]

signal supplier_interract(supplier_data: SupplierData, index: int, button: int)

func on_supplier_clicked(index: int, button: int) -> void :
	print("ouiouioui")
	#supplier_interract.emit(self, index, button)

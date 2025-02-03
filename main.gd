extends Node

@onready var inventory_interface: Control = %InventoryInterface
@onready var external_inventory_view: PanelContainer = $UI/ScreenHbox/RightScreen/InventoryInterface/ExternalInventory
@onready var stock_view: Control = $UI/ScreenHbox/LeftScreen/StockView
@onready var golds_label: Label = $UI/ScreenHbox/RightScreen/Golds
@onready var suppliers_button: Button = $UI/ScreenHbox/RightScreen/Suppliers
@onready var customer_interface: Control = $UI/ScreenHbox/LeftScreen/LeftVBoxContainer/BG/CustomerInterface


var inventory_manager = InventoryManager.new()
var supplier_manager = SupplierManager.new()
var customer_manager = CustomerManager.new()


var game_data = GameData.new()
var save = game_data.saves[0]


func _ready() -> void:
	set_seller()
	set_customer()
	set_suppliers()
	#for node in get_tree().get_nodes_in_group("external_inventory"):
		#node.toggle_inventory.connect(toggle_inventory_interface)


func _process(_delta: float) -> void:
	golds_label.text ="%s gold(s)" % S.seller.golds


func set_seller() -> void:
	var inv = inventory_manager.get_seller_inventory()
	inv.set_inventory_from_dict(save.potions)
	inventory_interface.set_seller_inventory_view(inv)
	S.seller.golds = save.golds
	S.seller.suppliers = supplier_manager.get_suppliers_by_id(save.suppliers)
	S.seller.bonuses = save.bonuses
	S.seller.inventory = inv


func set_customer() -> void :
	customer_manager.customer_interact.connect(on_customer_interract)
	customer_interface.set_customer_view(customer_manager)


func set_suppliers() -> void :
	supplier_manager.supplier_interact.connect(on_supplier_interract)
	stock_view.set_stock_view(supplier_manager)


func on_customer_interract(customer : Customer = null) -> void:
	if customer:
		var external_inventory = customer.order_to_inventory()
		external_inventory_view.visible = not external_inventory_view.visible
		inventory_interface.set_external_inventory_view(external_inventory)
	else:
		inventory_interface.clear_external_inventory()


func on_supplier_interract(supplier : Supplier, button : int) -> void:
	match [supplier in S.seller.suppliers, button]:
		[true, MOUSE_BUTTON_LEFT]:
			inventory_manager.seller_inventory.add_quantity(1, supplier.offer)
		[true, MOUSE_BUTTON_RIGHT]:
			inventory_manager.seller_inventory.add_quantity(10, supplier.offer)
		[false, MOUSE_BUTTON_LEFT]:
			pass
		[false, MOUSE_BUTTON_RIGHT]:
			pass
			#popup à coder
	


func _on_suppliers_pressed() -> void:
	if suppliers_button.text == "End Day":
		suppliers_button.text = "Begin Day"
		customer_interface.visible = false
		external_inventory_view.visible = false
	else:
		suppliers_button.text = "End Day"
		customer_interface.visible = true
	stock_view.visible = not stock_view.visible
	

extends Node

@onready var inventory_interface: Control = %InventoryInterface
@onready var stock_view: Control = $UI/ScreenHbox/LeftScreen/StockView
@onready var golds_label: Label = $UI/ScreenHbox/RightScreen/Golds


var inventory_manager = InventoryManager.new()
var supplier_manager = SupplierManager.new()
var customer_manager = CustomerManager.new()

const MAIN = preload("res://main.tscn")
var game_data = GameData.new()
var seller : Seller
var save = game_data.saves[0]


func _ready() -> void:
	set_seller()
	print(seller.suppliers[0].name)
	print(seller.inventory.slots[0].potion.name, seller.inventory.slots[0].quantity)
	print(customer_manager.customers[0].order.order_lines[0].potion.name)
	#stock_interface.set_player_stock_data(stock_data)
	#%LeftScreen.add_child(CUSTOMER.instantiate())
	#for node in get_tree().get_nodes_in_group("external_inventory"):
		#node.toggle_inventory.connect(toggle_inventory_interface)
	

func _process(_delta: float) -> void:
	golds_label.text ="%s gold(s)" % seller.golds


func set_seller() -> void:
	var inv = inventory_manager.create_inventory()
	inv.set_inventory_from_dict(save.potions)
	inventory_interface.set_seller_inventory(inv)
	seller = Seller.new(
		save.golds,
		supplier_manager.get_suppliers_by_id(save.suppliers),
		save.bonuses,
		inv
	)


#func toggle_inventory_interface(external_inventory_owner = null) -> void:
	#if external_inventory_owner:
		#print("oui")
		#external_inventory.visible = not external_inventory.visible
		#inventory_interface.set_external_inventory(external_inventory_owner)
	#else:
		#print("non")
		#inventory_interface.clear_external_inventory()


func _on_suppliers_pressed() -> void:
	stock_view.visible = not stock_view.visible

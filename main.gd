extends Node

@onready var inventory_interface: Control = %InventoryInterface
@onready var external_inventory_view: PanelContainer = $UI/ScreenHbox/RightScreen/InventoryInterface/ExternalInventory
@onready var stock_view: Control = $UI/ScreenHbox/LeftScreen/StockView
@onready var golds_label: Label = $UI/ScreenHbox/RightScreen/Golds
@onready var end_day_button: Button = $UI/ScreenHbox/RightScreen/EndDay
@onready var customer_interface: Control = $UI/ScreenHbox/LeftScreen/LeftVBoxContainer/BG/CustomerInterface
@onready var check_inventory_sell_button : Button = %CheckInventorySell
@onready var popup: Control = %Popups


var inventory_manager = InventoryManager.new()
var supplier_manager = SupplierManager.new()
var customer_manager = CustomerManager.new()


var game_data = GameData.new()
var save = game_data.saves[0]


func _ready() -> void:
	set_seller()
	set_customer()
	set_suppliers()


func _process(_delta: float) -> void:
	golds_label.text ="%s" % S.seller.golds


func check_game_state() -> void :
	if S.seller.golds < 0:
		print("you lose")


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


func apply_sale_result(order_to_check: Order) -> void:
	# check if the sale match the customer.order
	var correct_order = customer_manager.customers[0].compare_order(order_to_check)
	if correct_order:
		# if yes then seller get paid with potion price
		for order_line in order_to_check.order_lines:
			S.seller.golds += order_line.potion.price * order_line.quantity
	else:
		# if not seller get debuff and  reffill with the potions he spend
		S.seller.golds -= 10
		check_game_state()
		inventory_manager.seller_inventory.refill_inventory_with(order_to_check)
	clear_customer()
	set_next_customer()


func clear_customer() -> void:
	inventory_manager.external_inventory = null
	inventory_interface.clear_external_inventory_view()
	customer_manager.customers.remove_at(0)
	customer_interface.clear_customer_manager_view()


func set_next_customer() -> void:
	if customer_manager.customers != []:
		customer_interface.set_customer_view(customer_manager)
	else:
		end_the_day()


func on_customer_interract(customer : Customer = null) -> void:
	if customer:
		var external_inventory = customer.order_to_inventory()
		inventory_manager.external_inventory = external_inventory
		external_inventory_view.visible = not external_inventory_view.visible
		inventory_interface.set_external_inventory_view(external_inventory)
	else:
		inventory_interface.clear_external_inventory_view()


func on_supplier_interract(supplier : Supplier, button : int) -> void:
	match [supplier in S.seller.suppliers, button]:
		[true, MOUSE_BUTTON_LEFT]:
			inventory_manager.seller_inventory.buy_from_supplier(1, supplier.offer)
		[true, MOUSE_BUTTON_RIGHT]:
			inventory_manager.seller_inventory.buy_from_supplier(10, supplier.offer)
		[false, MOUSE_BUTTON_LEFT]:
			popup.info_popup("You must by it first")
		[false, MOUSE_BUTTON_RIGHT]:
			popup.info_popup("You must by it first")
			# Vraie popup à coder


func _on_end_day_pressed() -> void:
	if end_day_button.text == "End Day":
		end_the_day()
	else:
		set_new_day()


func end_the_day() -> void :
	stock_view.visible = not stock_view.visible
	end_day_button.text = "Begin Day"
	customer_interface.visible = false
	external_inventory_view.visible = false
	clear_customer()


func set_new_day() -> void :
	stock_view.visible = not stock_view.visible
	end_day_button.text = "End Day"
	customer_interface.visible = true
	customer_manager.clear_and_create_customers(5)
	customer_interface.set_customer_view(customer_manager)


func _on_check_inventory_sell_button_pressed() -> void:
	var order_to_check = inventory_manager.inventory_to_order(
		inventory_manager.external_inventory
		)
	apply_sale_result(order_to_check)


func _on_external_inventory_visibility_changed() -> void:
	check_inventory_sell_button.visible = not check_inventory_sell_button.visible

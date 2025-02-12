extends Node

#region Variables Graphiques
@onready var inventory_interface: Control = %InventoryInterface
@onready var external_inventory_view: PanelContainer = %ExternalInventory
@onready var stock_view: Control = $UI/ScreenHbox/LeftScreen/StockView
@onready var bonus_interface: Control = %BonusInterface
@onready var golds_label: Label = $UI/ScreenHbox/RightScreen/Golds
@onready var end_day_button: Button = $UI/ScreenHbox/RightScreen/EndDay
@onready var customer_interface: Control = $UI/ScreenHbox/LeftScreen/LeftVBoxContainer/BG/CustomerInterface
@onready var check_inventory_sell_button : Button = %CheckInventorySell
@onready var info_popup: Control = %InfoPopup
@onready var interactive_popup: Control = %InteractivePopup
@onready var save_menu_button: Button = %"Save&Menu"
@onready var coin_animation: Node2D = %CoinAnimation
@onready var audio_lose: AudioStreamPlayer = $AudioLose
@onready var audio_negative_transaction: AudioStreamPlayer = $AudioNegativeTransaction

#endregion

#region Variables Diverses
const MENU = "res://Menu/menu.tscn"
const TITLE_SCREEN = "res://Menu/TitleScreen.tscn"

var inventory_manager = InventoryManager.new()
var supplier_manager = SupplierManager.new()
var customer_manager = CustomerManager.new()
var bonus_manager = BonusManager.new()
var save = game_data.saves[game_data.save_name]
#endregion


func _ready() -> void:
	set_seller()
	set_customer()
	set_suppliers()
	set_bonuses()


func _process(_delta: float) -> void:
	golds_label.text = "%s" % S.seller.golds


func check_game_state() -> void :
	if S.seller.golds < 0:
		interactive_popup.set_interactive_popup("YOU LOSE")
		var to_title_button = Button.new()
		to_title_button.text = "Return to Screen-Title"
		to_title_button.connect("pressed", _on_to_title_button_pressed)
		var exit_game_button = Button.new()
		exit_game_button.text = "Exit the Game"
		exit_game_button.connect("pressed", _on_exit_game_button_pressed)
		audio_lose.play()
		interactive_popup.v_box_container.add_child(to_title_button)
		interactive_popup.v_box_container.add_child(exit_game_button)
		game_data.delete_game_save(game_data.save_name)


func apply_sale_result(order_to_check: Order) -> void:
	# check if the sale match the customer.order
	var correct_order = customer_manager.customers[0].compare_order(order_to_check)
	var operation = 0
	if correct_order:
		# if yes then seller get paid with potion price
		for order_line in order_to_check.order_lines:
			operation += order_line.potion.price * order_line.quantity
		S.update_seller_golds(operation)
	else:
		# if not seller get debuff and  reffill with the potions he spend
		operation = -10
		audio_negative_transaction.play()
		S.update_seller_golds(operation)
		check_game_state()
		inventory_manager.seller_inventory.refill_inventory_with(order_to_check)
	clear_customer()
	set_next_customer()


func set_seller() -> void:
	var inv = inventory_manager.get_seller_inventory()
	inv.set_inventory_from_dict(save.potions)
	inventory_interface.set_seller_inventory_view(inv)
	S.seller.golds = save.golds
	S.seller.suppliers = supplier_manager.get_suppliers_by_id(save.suppliers)
	S.seller.bonuses = bonus_manager.get_bonuses_by_id(save.bonuses)
	S.seller.inventory = inv
	S.gold_change.connect(_on_gold_change)


func set_customer() -> void :
	customer_manager.customer_interact.connect(on_customer_interact)
	customer_interface.set_customers_view(customer_manager)


func set_suppliers() -> void :
	supplier_manager.supplier_interact.connect(on_supplier_interact)
	stock_view.set_stock_view(supplier_manager)


func set_bonuses() -> void :
	bonus_manager.bonus_interact.connect(on_bonus_interact)
	bonus_interface.set_bonuses_view(bonus_manager)


func end_the_day() -> void :
	stock_view.visible = not stock_view.visible
	if external_inventory_view.visible:
		_on_check_inventory_sell_button_pressed()
	end_day_button.text = "Begin Day"
	customer_interface.visible = false
	external_inventory_view.visible = false
	clear_customer()


func set_new_day() -> void :
	stock_view.visible = not stock_view.visible
	end_day_button.text = "End Day"
	customer_interface.visible = true
	customer_manager.clear_and_create_customers(5)
	customer_interface.set_customers_view(customer_manager)


func set_next_customer() -> void:
	if customer_manager.customers != []:
		customer_interface.set_customers_view(customer_manager)
	else:
		end_the_day()


func clear_customer() -> void:
	inventory_manager.external_inventory = null
	inventory_interface.clear_external_inventory_view()
	customer_manager.customers.remove_at(0)
	customer_interface.clear_customer_manager_view()


func handle_supplier_unlocking_popup(supplier: Supplier) -> void :
	interactive_popup.set_interactive_popup("You must buy it first :")
	var price = Label.new()
	price.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	price.text = "%s golds" % supplier.unlock_price
	var unlock_supplier_button = Button.new()
	unlock_supplier_button.text = "Unlock"
	unlock_supplier_button.connect("pressed", _on_unlock_supplier_button_pressed.bind(supplier))
	var cancel_button = Button.new()
	cancel_button.text = "Cancel"
	cancel_button.connect("pressed", _on_cancel_button_pressed)
	interactive_popup.v_box_container.add_child(price)
	interactive_popup.v_box_container.add_child(unlock_supplier_button)
	interactive_popup.v_box_container.add_child(cancel_button)


func on_customer_interact(customer : Customer = null) -> void:
	if customer:
		var external_inventory = customer.order_to_inventory()
		inventory_manager.external_inventory = external_inventory
		external_inventory_view.visible = not external_inventory_view.visible
		inventory_interface.set_external_inventory_view(external_inventory)
	else:
		inventory_interface.clear_external_inventory_view()


func on_supplier_interact(supplier : Supplier, button : int) -> void:
	match [supplier in S.seller.suppliers, button]:
		[true, MOUSE_BUTTON_LEFT]:
			inventory_manager.seller_inventory.buy_from_supplier(1, supplier.offer)
		[true, MOUSE_BUTTON_RIGHT]:
			inventory_manager.seller_inventory.buy_from_supplier(10, supplier.offer)
		[false, MOUSE_BUTTON_LEFT]:
			if not interactive_popup.visible:
				handle_supplier_unlocking_popup(supplier)
		[false, MOUSE_BUTTON_RIGHT]:
			if not interactive_popup.visible:
				handle_supplier_unlocking_popup(supplier)


func on_bonus_interact(bonus: Bonus) -> void:
	pass


func _on_end_day_pressed() -> void:
	if end_day_button.text == "End Day":
		end_the_day()
	else:
		set_new_day()


func _on_check_inventory_sell_button_pressed() -> void:
	var order_to_check = inventory_manager.inventory_to_order(
		inventory_manager.external_inventory
		)
	apply_sale_result(order_to_check)


func _on_external_inventory_visibility_changed() -> void:
	check_inventory_sell_button.visible = not check_inventory_sell_button.visible


func _on_save_menu_pressed() -> void:
	if end_day_button.text == "End Day":
		info_popup.set_info_popup("Finish the day first")
	else:
		game_data.save_game()
		get_tree().change_scene_to_file(MENU)


func _on_to_title_button_pressed() -> void:
	get_tree().change_scene_to_file(TITLE_SCREEN)


func _on_exit_game_button_pressed() -> void:
	get_tree().quit()


func _on_unlock_supplier_button_pressed(supplier: Supplier) -> void:
	if S.seller.golds >= supplier.unlock_price:
		supplier_manager.unlock_supplier(supplier)
		S.update_seller_golds(-supplier.unlock_price)
		stock_view.set_stock_view(supplier_manager)
		interactive_popup.clear_popup()
	else:
		info_popup.set_info_popup("Not enough money")


func _on_cancel_button_pressed() -> void:
	interactive_popup.clear_popup()


func _on_gold_change(operation: int) -> void:
	coin_animation.set_animation(operation)


func _on_addgold_pressed() -> void:
	S.update_seller_golds(100)


func _on_lose_pressed() -> void:
	S.seller.golds = -1
	check_game_state()

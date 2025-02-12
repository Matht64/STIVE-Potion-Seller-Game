extends Resource

class_name Inventory

signal inventory_updated(inventory: Inventory)
signal inventory_interact(inventory: Inventory, index: int, button: int)

@export var slots : Array[Slot]


func _init(inventory_size : int = 0) -> void: # WIP
	for i in range(inventory_size):
		slots.append(Slot.new())


func set_inventory_from_dict(inventory_base) -> void:
	# Populate an inventory from data shape like this :
	#[
		#{
			#"id" : 0,
			#"quantity" : 15
		#},
		#{
			#"id" : 1,
			#"quantity" : 10
		#},
		#{
			#"id" : 2,
			#"quantity" : 0
		#}
	#]
	for potion_type in inventory_base:
		for potion in Resources.potions:
			if potion.id == potion_type.id:
				slots.append(Slot.new(potion, potion_type.quantity))


func create_empty_slot(nb_slot: int):
	for i in range(nb_slot):
		slots.append(Slot.new())
	inventory_updated.emit(self)


func grab_slot(index: int, button: int) -> Slot:
	if slots[index] and slots[index].quantity > 0:
		var slot = Slot.new(slots[index].potion, 0)
		if button == MOUSE_BUTTON_LEFT:
			slot.quantity = slots[index].quantity
			slots[index].quantity = 0
		else:
			slot = Slot.new(
			slots[index].potion,
			slots[index].quantity / 2
			)
			slots[index].quantity -= slot.quantity
		inventory_updated.emit(self)
		return slot
	else:
		return null


func drop_slot(grabbed_slot: Slot, index: int) -> Slot:
	var target_slot = slots[index]
	var returned_slot: Slot
	if target_slot and target_slot.can_fully_merge_with(grabbed_slot):
		target_slot.fully_merge_with(grabbed_slot)
	else:
		returned_slot = grabbed_slot
		
	inventory_updated.emit(self)
	return returned_slot


func drop_single_slot(grabbed_slot: Slot, index: int) -> Slot:
	var target_slot = slots[index]
	if not target_slot:
		slots[index] = grabbed_slot.duplicate_single_slot()
	elif target_slot.can_fully_merge_with(grabbed_slot):
		target_slot.fully_merge_with(grabbed_slot.duplicate_single_slot())
	inventory_updated.emit(self)
	
	if grabbed_slot.quantity > 0:
		return grabbed_slot
	else:
		return null


func buy_from_supplier(quantity : int, offer : Offer) -> void:
	if (quantity * offer.price) <= S.seller.golds:
		#check if slot data exist and if multiple of same item_data add 1 or 10 to only one slot data
		for slot in slots:
			if slot: 
				if slot.potion.id == offer.potion.id:
					slot.increment_potion(offer.quantity * quantity)
					S.update_seller_golds(-(offer.price * quantity))
					inventory_updated.emit(self)
					return
		print("no item corresponding")
	else:
		print("not enough money")


func refill_inventory_with(returned_order: Order) -> void:
	for order_line in returned_order.order_lines:
		for slot in slots:
			if slot: 
				if slot.potion.id == order_line.potion.id:
					slot.increment_potion(order_line.quantity)
					inventory_updated.emit(self)


func on_slot_clicked(index: int, button: int) -> void :
	inventory_interact.emit(self, index, button)

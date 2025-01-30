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
	
	# while there is only 3 potions resources
	var to_fill_empty_space = inventory_base.size() - Resources.potions.size()
	for i in range(to_fill_empty_space):
		slots.append(Slot.new())


func create_slot(potion : Potion) -> Slot:
	var new_slot = Slot.new()
	new_slot.potion = potion
	new_slot.quantity = 0
	return new_slot


func grab_slot(index: int) -> Slot:
	var slot = slots[index]
	if slot:
		slots[index] = null
		inventory_updated.emit(self)
		return slot
	else:
		return null


func drop_slot(grabbed_slot: Slot, index: int) -> Slot:
	var slot = slots[index]
	
	var returned_slot: Slot
	if slot and slot.can_fully_merge_with(grabbed_slot):
		slot.fully_merge_with(grabbed_slot)
	else:
		slots[index] = grabbed_slot
		returned_slot = slot
		
	inventory_updated.emit(self)
	return returned_slot


func drop_single_slot(grabbed_slot: Slot, index: int) -> Slot:
	var slot = slots[index]
	
	if not slot:
		slots[index] = grabbed_slot.duplicate_single_slot()
	elif slot.can_fully_merge_with(grabbed_slot):
		slot.fully_merge_with(grabbed_slot.duplicate_single_slot())
		
	inventory_updated.emit(self)
	
	if grabbed_slot.quantity > 0:
		return grabbed_slot
	else:
		return null


#func increment_slot(potion: Potion, quantity, price) -> void:
	##check if slot data exist and if multiple of same item_data add 1 or 10 to only one slot data
	#for slot in slots:
		#if slot: 
			#if slot.potion == potion:
				#slot.increment_item_data(quantity)
				#seller.golds -= price
				#print(seller.golds)
				#inventory_updated.emit(self)
				#return
	#print("no item corresponding")


func on_slot_clicked(index: int, button: int) -> void :
	inventory_interact.emit(self, index, button)

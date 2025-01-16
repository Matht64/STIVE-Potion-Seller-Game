extends Resource

class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int)

@export var slot_datas: Array[SlotData]


func grab_slot_data(index: int) -> SlotData:
	var slot_data = slot_datas[index]
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null


func drop_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	var returned_slot_data: SlotData
	if slot_data and slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data)
	else:
		slot_datas[index] = grabbed_slot_data
		returned_slot_data = slot_data
		
	inventory_updated.emit(self)
	return returned_slot_data


func drop_single_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	if not slot_data:
		slot_datas[index] = grabbed_slot_data.create_single_slot_data()
	elif slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data.create_single_slot_data())
		
	inventory_updated.emit(self)
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null


func increment_slot_data(item_data: ItemData, quantity, price) -> void:
	#check if slot data exist and if multiple of same item_data add 1 or 10 to only one slot data
	for slot_data in slot_datas:
		if slot_data: 
			if slot_data.item_data == item_data:
				slot_data.increment_item_data(quantity)
				player_data.golds -= price
				print(player_data.golds)
				inventory_updated.emit(self)
				return
	print("no item corresponding")


func on_slot_clicked(index: int, button: int) -> void :
	inventory_interact.emit(self, index, button)

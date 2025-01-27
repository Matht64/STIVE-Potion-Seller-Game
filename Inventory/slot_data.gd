extends Resource

class_name SlotData

@export var item_data: ItemData
@export var quantity: int = 0


func can_fully_merge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data

func fully_merge_with(other_slot_data: SlotData) -> void:
	quantity += other_slot_data.quantity

func duplicate_single_slot_data() -> SlotData:
	var new_slot_data = duplicate()
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data

func increment_item_data(quantity_to_add) -> void :
	quantity += quantity_to_add

extends Resource

class_name SlotData

@export var potion : Potion
@export var quantity : int


func _init(_potion : Potion = null, _quantity : int = 0) -> void:
	self.potion = _potion
	self.quantity = _quantity


func can_fully_merge_with(other_slot_data: SlotData) -> bool:
	return self.potion == other_slot_data.potion


func fully_merge_with(other_slot_data: SlotData) -> void:
	self.quantity += other_slot_data.quantity


func duplicate_single_slot_data() -> SlotData:
	var new_slot_data = duplicate()
	new_slot_data.quantity = 1
	self.quantity -= 1
	return new_slot_data


func increment_potion(quantity_to_add : int) -> void :
	self.quantity += quantity_to_add

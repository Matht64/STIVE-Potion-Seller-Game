extends Resource

class_name Slot

@export var potion : Potion
@export var quantity : int


func _init(_potion : Potion = null, _quantity : int = 0) -> void:
	self.potion = _potion
	self.quantity = _quantity


func can_fully_merge_with(other_slot: Slot) -> bool:
	return self.potion == other_slot.potion


func fully_merge_with(other_slot: Slot) -> void:
	self.quantity += other_slot.quantity


func duplicate_single_slot() -> Slot:
	var new_slot = duplicate()
	new_slot.quantity = 1
	self.quantity -= 1
	return new_slot


func increment_potion(quantity_to_add : int) -> void :
	self.quantity += quantity_to_add

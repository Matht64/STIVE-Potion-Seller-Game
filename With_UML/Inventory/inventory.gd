extends Resource

class_name Inventory

@export var slot_datas : Array[SlotData]


func _init(inventory_size : int = 0) -> void: # WIP
	for i in range(inventory_size):
		slot_datas.append(SlotData.new())


func set_inventory_data_from_dict(inventory_base) -> void:
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
				slot_datas.append(SlotData.new(potion, potion_type.quantity))

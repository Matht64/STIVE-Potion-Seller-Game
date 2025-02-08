extends Node

class_name BonusManager

@export var bonuses: Array[Bonus]

signal bonus_interact(bonus: Bonus)

func _init() -> void:
	for bonus_res in Resources.bonuses:
		bonuses.append(bonus_res)


func get_bonuses_by_id(bonuses_ids : Array) -> Array[Bonus]:
	var bonuses_by_ids : Array[Bonus] = []
	for bonus_id in bonuses_ids:
		for bonus in bonuses:
			if bonus_id == bonus.id:
				bonuses_by_ids.append(bonus)
	return bonuses_by_ids


func apply_bonuses(transaction : int) -> void:
	var bonuses_to_delete = []
	for bonus in S.seller.bonuses:
		if bonus.activated_time != "":
			var actual_time = Time.get_unix_time_from_system()
			var activated_time = Time.get_unix_time_from_datetime_string(bonus.activated_time)
			if actual_time > (activated_time + (bonus.duration * 3600)):
				if bonus.type == "Boost Gold" and transaction > 0:
					apply_bonus_type_1(transaction)
				elif bonus.type == "Reduce Debuff" and transaction < 0:
					apply_bonus_type_2(transaction)
				elif bonus.type == "3":
					apply_bonus_type_3(transaction)
			else:
				bonuses_to_delete.append(bonus)
	for bonus_to_delete in bonuses_to_delete:
		S.seller.bonuses.erase(bonus_to_delete)


func apply_bonus_type_1(transaction : int) -> void:
	# ex : Golds * 2
	S.seller.golds += transaction * 2
	


func apply_bonus_type_2(transaction : int) -> void:
	# ex : Debuff / 2
	S.seller.golds += transaction / 2
	


func apply_bonus_type_3(transaction : int) -> void:
	pass


func _on_bonus_clicked(index : int) -> void:
	bonus_interact.emit(bonuses[index])

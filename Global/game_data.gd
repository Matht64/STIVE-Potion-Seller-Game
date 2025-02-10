extends Node

class_name GameData

@export var saves : Dictionary 
@export var save_name : String

var save_path = "./user_saves.save"


func _init() -> void:
	get_save_file()


func save_game() -> void:
	saves[save_name].golds = S.seller.golds
	
	var potions_to_save = []
	for slot in S.seller.inventory.slots:
		potions_to_save.append({
			"id" : slot.potion.id,
			"quantity" : slot.quantity
		})
	saves[save_name].potions = potions_to_save
	
	var suppliers_to_save = []
	for supplier in S.seller.suppliers:
		suppliers_to_save.append(supplier.id)
	saves[save_name].suppliers = suppliers_to_save
	
	var bonuses_to_save = []
	for bonus in S.seller.bonuses:
		if bonus.activated_time == "":
			bonuses_to_save.append(bonus.id)
	saves[save_name].bonuses = bonuses_to_save
	
	saves[save_name].save_date = Time.get_datetime_string_from_system()
	print(saves)
	set_save_file()


func set_save_file() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(saves)


func get_save_file() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		saves = file.get_var()
	else:
		print("file not found")


func new_game_save(new_save_name: String) -> bool:
	if not saves.has(new_save_name) :
		saves[new_save_name] = {
			"id_user": 0,
			"golds": 100,
			"potions": [
				{
					"id": 0,
					"quantity": 10
				},
				{
					"id": 1,
					"quantity": 10
				},
				{ 
					"id": 2,
					"quantity": 0
				},
				{ 
					"id": 3,
					"quantity": 0
				},
				{ 
					"id": 4,
					"quantity": 0
				},
				{ 
					"id": 5,
					"quantity": 0
				},
				{ 
					"id": 6,
					"quantity": 0
				},
				{ 
					"id": 7,
					"quantity": 0
				},
				{ 
					"id": 8,
					"quantity": 0
				}
			],
			"suppliers": [
				0
			],
			"bonuses": [
				0
			],
			"save_date": ""
		}
		save_name = new_save_name
		return true
	return false


func delete_game_save(to_delete_save_name: String) -> void:
	saves.erase(to_delete_save_name)
	set_save_file()

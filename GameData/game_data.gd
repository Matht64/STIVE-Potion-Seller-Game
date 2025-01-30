extends Resource

class_name GameData

@export var saves = {
	0 : {
		"id_user" : 0,
		"golds": 100,
		"potions" : [
			{
				"id": 0,
				"quantity": 10
			},
			{
				"id": 1,
				"quantity": 6
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
		"suppliers" : [
			0,
			1
		],
		"bonuses" : [
			{
				"id": 0,
				"end_date": "2024/12/12 12:27:38",
			}
		]
	}
}

func game_data_to_json() -> JSON:
	return JSON.new()

func json_to_game_data() -> GameData:
	return GameData.new()

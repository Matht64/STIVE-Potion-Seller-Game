extends Control

const MAIN = preload("res://main.tscn")

#func _ready() -> void:
	#Api.not_working.connect(is_api_connected)
	#if is_api_connected:
		#Api.request_get("Save/" + user_id)
		#var distant_game_data = Api.response.connect(get_distant_game_data.bind(user_id))
		#var local_game_data = get_local_game_data()
		#if distant_game_data != local_game_data:
			#print("Quelle sauvegarde souhaitez vous utiliser ?")
			#print(local_game_data, "\nou\n", distant_game_data)
	
func _on_button_pressed() -> void:
	Api.request_get("User")
	get_tree().change_scene_to_packed(MAIN)

func get_distant_game_data(data) -> JSON:
	var json = JSON.stringify(data)
	return json
	
func get_local_game_data() -> JSON:
	return JSON.new()
	
func is_api_connected() -> bool:
	Api.request_get("")
	return true

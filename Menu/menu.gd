extends Control

const MAIN = preload("res://main.tscn")
const TITLE_SCREEN = preload("res://Menu/TitleScreen.tscn")

@onready var VerticalSaveMenu: VBoxContainer = %VerticalSaveMenu
@onready var new_game_button: Button = %NewGameButton
@onready var interractive_popup: Control = %InterractivePopup


func _ready() -> void:
	for save_name in game_data.saves.keys():
		var new_button = Button.new()
		new_button.text = save_name + ": %s golds" % game_data.saves[save_name].golds
		new_button.connect("pressed", on_save_pressed.bind(save_name))
		VerticalSaveMenu.add_child(new_button)
	
	#Api.not_working.connect(is_api_connected)
	#if is_api_connected:
		#Api.request_get("Save/" + user_id)
		#var distant_game_data = Api.response.connect(get_distant_game_data.bind(user_id))
		#var local_game_data = get_local_game_data()
		#if distant_game_data != local_game_data:
			#print("Quelle sauvegarde souhaitez vous utiliser ?")
			#print(local_game_data, "\nou\n", distant_game_data)
	

func on_save_pressed(button_name) -> void:
	game_data.save_name = button_name
	get_tree().change_scene_to_packed(MAIN)


func _on_new_game_button_pressed() -> void:
	interractive_popup.set_interractive_popup("Write a save name :")
	
	var text_edit = TextEdit.new()
	text_edit.size_flags_vertical = Control.SIZE_EXPAND_FILL
	text_edit.placeholder_text = "ex : new_save_name"
	
	var confirm_button = Button.new()
	confirm_button.text = "Confirm"
	confirm_button.connect("pressed", _on_confirm_button_pressed.bind(text_edit))
	
	interractive_popup.v_box_container.add_child(text_edit)
	interractive_popup.v_box_container.add_child(confirm_button)
	text_edit.grab_focus()


func _on_confirm_button_pressed(text_field: TextEdit) -> void:
	if game_data.new_game_save(text_field.text):
		get_tree().change_scene_to_packed(MAIN)
	else:
		print("Name already taken, try another one pls")


#func _on_gui_input(event: InputEvent) -> void:
	#if event is InputEventKey \
			#and event.button_index == KEY_ESCAPE \
			#and event.is_pressed():
		#if interractive_popup.visible :
			#interractive_popup.clear_popup()
		#else:
			#get_tree().change_scene_to_packed(TITLE_SCREEN)


#func get_distant_game_data(data) -> JSON:
	#var json = JSON.stringify(data)
	#return json
#
#
#func get_local_game_data() -> JSON:
	#return JSON.new()


#func is_api_connected() -> bool:
	#Api.request_get("")
	#return true

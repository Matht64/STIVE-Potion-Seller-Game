extends Control

const MENU = preload("res://Menu/menu.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(MENU)

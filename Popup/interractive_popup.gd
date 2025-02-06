extends Control

@onready var panel_container: PanelContainer = %PanelContainer
@onready var panel: Panel = %Panel
@onready var popup_label: Label = %PopupLabel
@onready var v_box_container: VBoxContainer = %VBoxContainer


#func _ready() -> void:
	#set_interractive_popup("What do you wanna write ?")


func set_interractive_popup(title : String) -> void:
	popup_label.text = title
	panel_container.show()

func clear_popup() -> void:
	for child in v_box_container.get_children():
		if child != popup_label:
			child.queue_free()
	panel_container.hide()

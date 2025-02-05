extends Control

@onready var pb = %ProgressBar
@onready var label: Label = %Label
@onready var infoPopup: PopupPanel = %InfoPopup
@onready var timer: Timer = %Timer


var closed = true

func info_popup(info : String) -> void :
	label.text = info
	infoPopup.visible = true
	timer.wait_time = pb.max_value
	closed = false
	timer.start()


func hide_info_popup() -> void :
	closed = true
	infoPopup.visible = false
	timer.stop()
	pb.value = pb.max_value


func _process(_delta: float) -> void:
	if pb.value > 0:
		pb.value = timer.time_left
	elif pb.value == 0:
		hide_info_popup()


func _on_button_pressed() -> void:
	hide_info_popup()

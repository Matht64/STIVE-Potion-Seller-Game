extends Control

signal bonus_clicked(index: int)
@onready var bonus_name: Label = %BonusName
@onready var bonus_timer: Label = %BonusTimer


func set_bonus_view(bonus: Bonus) -> void:
	bonus_name.text = bonus.type + " %s" % bonus.duration
	if bonus.activated_time == "":
		bonus_timer.text = ""


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
				bonus_clicked.emit(get_index())

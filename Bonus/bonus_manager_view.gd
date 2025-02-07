extends Control

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer


const BONUS_VIEW = preload("res://Bonus/bonus_view.tscn")


func set_bonuses_view(bonus_manager : BonusManager) -> void:
	populate_bonus_manager_view(bonus_manager)


func clear_bonus_manager_view() -> void:
	for child in v_box_container.get_children():
		child.queue_free()


func populate_bonus_manager_view(bonus_manager: BonusManager) -> void:
	# clear the bonus_manager_view
	for child in v_box_container.get_children():
		child.queue_free()

	for bonus in S.seller.bonuses:
		var bonus_view = BONUS_VIEW.instantiate()
		v_box_container.add_child(bonus_view)
		bonus_view.bonus_clicked.connect(bonus_manager._on_bonus_clicked)

		if bonus:
			bonus_view.set_bonus_view(bonus)

extends Node2D

@onready var button: Button = $Button
@onready var tween: Tween

func _ready() -> void:
	set_animation(-10)

func set_animation(operation: int) -> void :
	if tween and tween.is_running():
		tween.kill()

	tween = get_tree().create_tween()
	if operation > 0:
		button.text = "+%s" % operation
		button.font_color = Color("#517a00")
	else:
		button.text = "%s" % operation
		button.font_color = Color("#c50000")
	tween.tween_property(button, "global_position", Vector2(), 1)
	

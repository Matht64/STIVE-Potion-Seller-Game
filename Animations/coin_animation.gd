extends Node2D

@onready var button: Button = %Button
@onready var tween: Tween
@onready var initial_position
@onready var positive_audio: AudioStreamPlayer = $Button/PositiveAudio


func _ready() -> void:
	initial_position = button.position


func set_animation(operation: int) -> void :
	button.position = initial_position
	button.visible = true
	
	if tween and tween.is_running():
		tween.kill()
	tween = get_tree().create_tween()
	
	if operation > 0:
		button.text = "+%s" % operation
		button.add_theme_color_override("font_color", Color.GREEN)
		positive_audio.play()
	else:
		button.text = "%s" % operation
		button.add_theme_color_override("font_color", Color.RED)

	tween.tween_property(button, "position", Vector2(), 0.5)
	tween.tween_callback(button.hide)
	

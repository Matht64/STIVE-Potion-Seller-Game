extends Button

@onready var sound_png = preload("res://Animations/MuteButton/speaker-filled-audio-tool.png")
@onready var mute_png = preload("res://Animations/MuteButton/volume.png")

@onready var mute_button: Button = $"."

func _on_pressed() -> void:
	if bg_music.volume_db == -25 :
		mute_button.icon = mute_png
		bg_music.volume_db = -80
	else:
		mute_button.icon = sound_png
		bg_music.volume_db = -25

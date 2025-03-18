extends Node

class_name AudioController

@onready var level_music = AudioStreamPlayer.new()

func _on_hud_music_toggle() -> void:
	if level_music.playing == false:
		level_music.play()
	else:
		level_music.stop()

func _on_level_start_level_music(music: Variant) -> void:
	level_music.autoplay = true
	level_music.stream = music
	call_deferred("add_child",level_music)

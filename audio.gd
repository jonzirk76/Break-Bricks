extends Node

@onready var level_music = AudioStreamPlayer.new()

func _on_main_hud_music_toggle() -> void:
	if level_music.playing == true:
		level_music.stop()
	else:
		level_music.play()


func _on_mainest_menu_start_level_music(music: Variant) -> void:
	level_music.autoplay = true
	level_music.stream = music
	call_deferred("add_child",level_music)


func _on_mainest_menu_change_level_music(music) -> void:
	level_music.stream = music
	level_music.play()

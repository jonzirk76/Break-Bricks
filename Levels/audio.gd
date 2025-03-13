extends Node

func _on_hud_music_toggle() -> void:
	if $Music.playing == true:
		$Music.playing = false
	else:
		$Music.playing = true

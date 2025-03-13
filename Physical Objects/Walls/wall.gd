extends StaticBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	$SoundEffect.pitch_scale = randf_range(.75, 1.25)
	$SoundEffect.playing	= true

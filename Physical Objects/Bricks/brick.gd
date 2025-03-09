extends StaticBody2D

class_name Brick

signal brick_broken(inventory, brick_points, position)

@onready var brick_points := 1

func _ready() -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	$SoundEffect.pitch_scale = randf_range(.75, 1.25)
	$SoundEffect.playing	= true
	$AnimationPlayer.play("break")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	brick_broken.emit(position, brick_points)
	queue_free()

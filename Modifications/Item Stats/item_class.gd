extends Area2D

class_name Mod

signal pickup_collected(item_stats)

@export var stats : item_stat_sheet

@onready var item_stats = stats.item_stats
@onready var sprite : Sprite2D = $Sprite2D
#@onready var animation := stats.animation
@onready var animation := $AnimationPlayer
@onready var sound_effect := $SoundEffect

func _ready() -> void:
	sprite.texture = stats.texture
	animation.play("default")
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = 2
	spawn_timer.autostart = true
	add_child(spawn_timer)
	await spawn_timer.timeout
	collision_mask = 0b00000000_00000000_00000000_00000010

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		collect_pickup(item_stats, body)

func _physics_process(delta: float) -> void:
	pass

func collect_pickup(item_stats, body):
	pickup_collected.emit(item_stats, body)
	animation.play("break")
	sound_effect.pitch_scale = randf_range(.75, 1.25)
	sound_effect.playing = true

func _on_animation_player_animation_finished(anim_name: StringName = "break") -> void:
	if anim_name == "break":
		queue_free()

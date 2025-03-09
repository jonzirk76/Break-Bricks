extends Area2D

class_name Mod

signal pickup_collected(item_stats)

@export var stats : mod_sheet

@onready var item_stats = stats.item_stats
@onready var sprite : Sprite2D = $Sprite2D
#@onready var animation := stats.animation

func _ready() -> void:
	sprite.texture = stats.texture
	#animation.play
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = 2
	spawn_timer.autostart = true
	add_child(spawn_timer)
	await spawn_timer.timeout
	collision_mask = 0b00000000_00000000_00000000_00000010

func _physics_process(delta: float) -> void:
	var contact = get_overlapping_bodies()
	for body in contact:
		if body is Ball:
			pickup_collected.emit(item_stats, body)
			queue_free()

extends Node

signal brick_broken
signal brick_count(bricks_alive)

@export var brick_scene : PackedScene

var chance_to_drop = .2

@onready var bricks_alive

func _process(delta: float) -> void:
	count_bricks()
	brick_count.emit(bricks_alive)

func make_bricks():
	for child in get_children():
		if child is Marker2D:
			var brick = brick_scene.instantiate()
			brick.position = child.position
			brick.modulate = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),1)
			brick.process_mode = Node.PROCESS_MODE_INHERIT
			brick.brick_broken.connect(brick_break)
			add_child(brick)
			child.process_mode = Node.PROCESS_MODE_DISABLED

func brick_break(brick_inventory,position):
	brick_broken.emit(brick_inventory,position)

func _on_main_reset_game() -> void:
	get_tree().call_group("brick", "queue_free")
	for child in get_children():
		if child is Marker2D:
			child.process_mode = Node.PROCESS_MODE_INHERIT

func _on_main_game_start() -> void:
	make_bricks()

func count_bricks():
	var initial_brick_count := 0
	for child in get_children():
		if child is Brick:
			initial_brick_count += 1
	bricks_alive = initial_brick_count

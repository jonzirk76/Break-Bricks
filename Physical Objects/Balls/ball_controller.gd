extends Node

signal ball_count(balls_alive)

@export var ball_scene : PackedScene

@onready var balls_alive

func _process(delta: float) -> void:
	count_balls()
	ball_count.emit(balls_alive)
	
func _physics_process(delta: float) -> void:
	pass

func make_balls():
	for child in get_children():
		if child is Marker2D:
			var ball = ball_scene.instantiate()
			ball.position = child.position
			ball.process_mode = Node.PROCESS_MODE_INHERIT
			ball.ball_launched = false
			add_child(ball)
			child.process_mode = Node.PROCESS_MODE_DISABLED

func _on_main_game_start() -> void:
	make_balls()

func _on_main_reset_game() -> void:
	get_tree().call_group("ball", "queue_free")
	for child in get_children():
		if child is Marker2D:
			child.process_mode = Node.PROCESS_MODE_INHERIT

func count_balls():
	var initial_ball_count := 0
	for child in get_children():
		if child is Ball:
			initial_ball_count += 1
	balls_alive = initial_ball_count

func _on_kill_zones_kill_area_entered(overlapping_bodies: Variant) -> void:
	for child in get_children():
		for body in overlapping_bodies:
			if child is Ball and child == body:
				child.kill_ball()

func _on_paddle_paddle_position(position: Variant) -> void:
	for child in get_children():
		if child is Ball and child.ball_launched == false:
			child.paddle_position = position

extends Node

signal ball_count(balls_alive)
signal ball_mod(item_stats)
signal extra_ball_count_changed(extra_balls_remaining)
signal no_extra_balls

@export var ball_scene : PackedScene

@onready var balls_alive
@onready var extra_balls_remaining := 5

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass

func make_balls():
	for child in get_children():
		if child is Marker2D:
			var ball = ball_scene.instantiate()
			ball.process_mode = Node.PROCESS_MODE_INHERIT
			ball.ball_launched = false
			ball.tree_exited.connect(count_balls)
			add_child(ball)
			#child.process_mode = Node.PROCESS_MODE_DISABLED
			count_balls()

func _on_main_game_start() -> void:
	make_balls()

#func _on_main_reset_game() -> void:
	#get_tree().call_group("ball", "queue_free")
	#for child in get_children():
		#if child is Marker2D:
			#child.process_mode = Node.PROCESS_MODE_INHERIT

func count_balls():
	var initial_ball_count := 0
	for child in get_children():
		if child is Ball:
			initial_ball_count += 1
		else:
			initial_ball_count = initial_ball_count
	balls_alive = initial_ball_count
	#ball_count.emit(balls_alive)
	if balls_alive == 0 and extra_balls_remaining >= 0:
		extra_balls_remaining -= 1
		spawn_extra_ball()
		extra_ball_count_changed.emit(extra_balls_remaining)
	elif extra_balls_remaining == 0:
		no_extra_balls.emit()

func _on_kill_zones_kill_area_entered(overlapping_bodies: Variant) -> void:
	for child in get_children():
		for body in overlapping_bodies:
			if child is Ball and child == body:
				child.kill_ball()

func _on_paddle_paddle_position(position: Variant) -> void:
	for child in get_children():
		if child is Ball and child.ball_launched == false:
			child.position = position

func _on_level_game_win() -> void:
	for child in get_children():
		if child is Ball:
			child.process_mode = Node.PROCESS_MODE_DISABLED


func _on_loot_loot_area_entered(item_stats: Variant, body: Variant) -> void:
	for child in get_children():
		if child == body:
			child.mod_change(item_stats)
	
func spawn_extra_ball():
	var ball = ball_scene.instantiate()
	ball.process_mode = Node.PROCESS_MODE_INHERIT
	ball.ball_launched = false
	ball.tree_exited.connect(count_balls)
	add_child(ball)
	count_balls()

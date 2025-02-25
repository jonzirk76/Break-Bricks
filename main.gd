extends Node

@export var ball_scene : PackedScene
@export var brick_scene : PackedScene

var balls_to_win := 0
var balls_in_win_area := 0
var bricks_alive := 0
var game_started := false

@onready var score = 0
@onready var balls = $Balls
@onready var bricks = $Bricks

func _ready() -> void:
	hide_walls()

func _process(delta: float) -> void:
	if balls_in_win_area == balls_to_win and game_started:
		lose()
	elif bricks_alive == 0 and game_started:
		win()

func _on_kill_area_body_entered(body: Node2D) -> void:
	balls_in_win_area += 1

func new_game():
	score = 0
	$StartTimer.start()
	$HUD/ScoreLabel.show()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	await $StartTimer.timeout
	
	make_balls()
	make_bricks()
	show_walls()
	$MovingWall.process_mode = Node.PROCESS_MODE_INHERIT
	game_started = true

func lose():
	$HUD.show_game_over()
	reset()
	
func win():
	$HUD.show_win()
	reset()

func add_point():
	if game_started == true:
		score += 1
		bricks_alive -= 1
		$HUD.update_score(score)

func make_balls():
	for child in balls.get_children():
		if child is Marker2D:
			balls_to_win += 1
			var ball = ball_scene.instantiate()
			ball.position = child.position
			ball.process_mode = Node.PROCESS_MODE_INHERIT
			add_child(ball)
			
func make_bricks():
	for child in bricks.get_children():
		if child is Marker2D:
			bricks_alive += 1
			var brick = brick_scene.instantiate()
			brick.position = child.position
			brick.process_mode = Node.PROCESS_MODE_INHERIT
			brick.tree_exited.connect(add_point)
			add_child(brick)

func hide_walls():
	$Wall.hide()
	$Wall.process_mode = Node.PROCESS_MODE_DISABLED
	$MovingWall.hide()
	$MovingWall.process_mode = Node.PROCESS_MODE_DISABLED
	
func show_walls():
	$Wall.show()
	$Wall.process_mode = Node.PROCESS_MODE_INHERIT
	$MovingWall.show()
	$MovingWall.process_mode = Node.PROCESS_MODE_INHERIT
	
func reset():
	hide_walls()
	get_tree().call_group("ball", "queue_free")
	get_tree().call_group("brick", "queue_free")
	$MovingWall.process_mode = Node.PROCESS_MODE_DISABLED
	game_started = false

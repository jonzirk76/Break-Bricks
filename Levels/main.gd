extends Node

signal reset_game
signal intro_start
signal game_start
signal game_lost
signal game_win
signal add_point
signal control_state(main_control_state)

var game_started := false
var main_control_state : String

@onready var score = 0
@onready var balls = $Balls

func _ready() -> void:
	hide_walls()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func new_game():
	score = 0
	intro_start.emit()
	$StartTimer.start()
	
	await $StartTimer.timeout
	game_start.emit()
	show_walls()
	game_started = true
	control_state.emit(main_control_state)
	
func lose():
	game_lost.emit()
	reset()
	
func win():
	game_win.emit()
	reset()

func hide_walls():
	$Wall.hide()
	$Wall.process_mode = Node.PROCESS_MODE_DISABLED

func show_walls():
	$Wall.show()
	$Wall.process_mode = Node.PROCESS_MODE_INHERIT

func reset():
	hide_walls()
	reset_game.emit()
	game_started = false

#func _on_bricks_brick_broken(brick_inventory,brick_points,position) -> void:
	#if game_started == true:
		#add_point.emit(brick_inventory,brick_points,position)

func _on_balls_ball_count(balls_alive: Variant) -> void:
	if balls_alive <= 0 and game_started:
		lose()

func _on_bricks_brick_count(bricks_alive: Variant) -> void:
	if bricks_alive <= 0 and game_started:
		win()

func _on_hud_control_state(control_switch_state: Variant) -> void:
	main_control_state = control_switch_state

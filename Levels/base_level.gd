extends Node2D

signal reset_game
signal intro_start
signal game_start
signal game_lost
signal game_win
signal add_point
signal control_state(main_control_state)
signal change_level_music(music)
signal ball_died

@export var music : AudioStream

var game_started := false
var main_control_state : String

@onready var balls = $Balls

#func _ready() -> void:
	#hide_walls()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func _ready() -> void:
	change_level_music.emit(music)
	intro_start.emit()
	$StartTimer.start()
	
	await $StartTimer.timeout
	game_start.emit()
	show_walls()
	game_started = true
	control_state.emit("MOUSE MODE")
	
func lose():
	game_lost.emit()
	
func win():
	game_win.emit()

func hide_walls():
	$Wall.hide()
	$Wall.process_mode = Node.PROCESS_MODE_DISABLED

func show_walls():
	$Wall.show()
	$Wall.process_mode = Node.PROCESS_MODE_INHERIT

func reset(last_score):
	hide_walls()
	reset_game.emit(last_score)
	game_started = false
	queue_free()

#func _on_balls_ball_count(balls_alive: Variant) -> void:
	#if balls_alive <= 0 and game_started:
		#ball_died.emit()

func _on_bricks_brick_count(bricks_alive: Variant) -> void:
	if bricks_alive <= 0 and game_started:
		win()

func _on_hud_control_state(control_switch_state: Variant) -> void:
	#main_control_state = control_switch_state
	main_control_state = "MOUSE MODE"

func _on_balls_no_extra_balls() -> void:
	lose()

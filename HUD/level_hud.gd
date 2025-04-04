extends CanvasLayer

signal start_game
#signal level_selected(level)
#signal control_state(control_switch_state)
signal music_toggle
signal finished_resetting(last_score)

var score := 0
#var control_switch_state := "MOUSE MODE"
var start_menu_active = true
var last_score
@export var balls_remaining := 5

func _input(event: InputEvent) -> void:
	if start_menu_active == true:
		#if Input.is_action_just_pressed("gamepad_toggle"):
			#_on_control_switch_pressed()
		#if Input.is_action_just_pressed("launch"):
			#_on_start_button_pressed()
		pass
		
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func _ready() -> void:
	#get_tree().call_group("title_ui", "hide")
	start_game.emit()
	#control_state.emit(control_switch_state)
	#start_menu_active = false
	#$ControlSwitch.process_mode = Node.PROCESS_MODE_DISABLED

func _on_message_timer_timeout() -> void:
	$Message.hide()
	$TransitionBackground.hide()
	
func game_reset():
	$TransitionBackground.show()
	await $MessageTimer.timeout
	var last_score = score
	finished_resetting.emit(last_score)
	#$Message.text = "BREAK BRICKS"
	#$Message.show()
	#
	#await get_tree().create_timer(1.0).timeout
	#get_tree().call_group("title_ui", "show")
	#start_menu_active = true
	#$ControlSwitch.process_mode = Node.PROCESS_MODE_INHERIT

#func _on_main_game_start() -> void:
	#pass

func _on_main_game_lost() -> void:
	show_message("You lose, idiot!")
	game_reset()

func _on_main_game_win() -> void:
	show_message("You win, genius!")
	game_reset()

func _on_main_intro_start() -> void:
	$ScoreLabel.show()
	score = 0
	$ScoreLabel.text = str(score)
	show_message("Get Ready")

func _on_bricks_brick_broken(position, brick_points) -> void:
	score += brick_points
	$ScoreLabel.text = str(score)

func _on_loot_loot_area_entered(item_stats: Variant, body: Variant) -> void:
	score += item_stats["loot_points"]
	$ScoreLabel.text = str(score)

#func _on_control_switch_pressed() -> void:
	#if control_switch_state == "MOUSE MODE":
		#control_switch_state = "BUTTON MODE"
	#elif control_switch_state == "BUTTON MODE":
		#control_switch_state = "MOUSE MODE"
	#$ControlSwitch.text = control_switch_state

func _on_balls_extra_ball_count_changed(extra_balls_remaining: Variant) -> void:
	$BallsRemaining.text = "Balls: " + str(extra_balls_remaining)

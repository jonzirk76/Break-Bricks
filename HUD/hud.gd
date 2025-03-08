extends CanvasLayer

signal start_game
signal control_state(control_switch_state)

var score := 0
var control_switch_state := "MOUSE MODE"
var start_menu_active = true

func _input(event: InputEvent) -> void:
	if start_menu_active == true:
		if Input.is_action_just_pressed("gamepad_toggle"):
			_on_control_switch_pressed()
		if Input.is_action_just_pressed("launch"):
			_on_start_button_pressed()
		
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$ControlSwitch.hide()
	$GamepadControls.hide()
	start_game.emit()
	control_state.emit(control_switch_state)
	start_menu_active = false

func _on_message_timer_timeout() -> void:
	$Message.hide()
	
func game_reset():
	await $MessageTimer.timeout
	
	$Message.text = "BREAK BRICKS"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$ControlSwitch.show()
	$GamepadControls.show()
	start_menu_active = true

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
	show_message("Get Ready")

func _on_bricks_brick_broken(position, brick_points) -> void:
	score += brick_points
	$ScoreLabel.text = str(score)

func _on_loot_loot_area_entered(item_stats: Variant) -> void:
	score += item_stats["loot_points"]
	$ScoreLabel.text = str(score)

func _on_control_switch_pressed() -> void:
	if control_switch_state == "MOUSE MODE":
		control_switch_state = "BUTTON MODE"
	elif control_switch_state == "BUTTON MODE":
		control_switch_state = "MOUSE MODE"
	$ControlSwitch.text = control_switch_state

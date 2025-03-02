extends CanvasLayer

signal start_game

var score := 0

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()
	
func game_reset():
	await $MessageTimer.timeout
	
	$Message.text = "BREAK BRICKS"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func _on_main_game_start() -> void:
	pass

func _on_main_game_lost() -> void:
	show_message("You lose, idiot!")
	game_reset()

func _on_main_game_win() -> void:
	show_message("You win, genius!")
	game_reset()

func _on_main_add_point() -> void:
	score += 1
	$ScoreLabel.text = str(score)

func _on_main_intro_start() -> void:
	$ScoreLabel.show()
	score = 0
	show_message("Get Ready")

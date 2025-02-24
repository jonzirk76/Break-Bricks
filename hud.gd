extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("You lose, idiot!")
	game_reset()
	
func show_win():
	show_message("You win, genius!")
	game_reset()

func update_score(score):
	$ScoreLabel.text = str(score)

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

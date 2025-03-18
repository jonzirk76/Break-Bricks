extends Control

signal level_selected(level)

func _on_main_menu_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index == 0:
		var random_level = randi_range(0, $LevelSelect.get_item_count() - 2)
		level_selected.emit(random_level)
	elif index == 1:
		$MainMenu.hide()
		$MainMenu.deselect_all()
		$MainMenu.process_mode = Node.PROCESS_MODE_DISABLED
		$LevelSelect.show()
		$LevelSelect.process_mode = Node.PROCESS_MODE_INHERIT
	elif index == 2:
		pass

func _on_main_menu_item_activated(index: int) -> void:
	if index == 0:
		var random_level = randi_range(0, $LevelSelect.get_item_count() - 2)
		level_selected.emit(random_level)
	elif index == 1:
		$MainMenu.hide()
		$MainMenu.deselect_all()
		$MainMenu.process_mode = Node.PROCESS_MODE_DISABLED
		$LevelSelect.show()
		$LevelSelect.process_mode = Node.PROCESS_MODE_INHERIT
	elif index == 2:
		pass
	
func _on_level_select_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index <= $LevelSelect.get_item_count() - 2:
		level_selected.emit(index)
	else:
		$LevelSelect.hide()
		$LevelSelect.deselect_all()
		$LevelSelect.process_mode = Node.PROCESS_MODE_DISABLED
		$MainMenu.show()
		$MainMenu.process_mode = Node.PROCESS_MODE_INHERIT

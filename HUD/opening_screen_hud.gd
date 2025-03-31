extends CanvasLayer

@onready var levels = {
	"0" = load("res://Levels/level_1.tscn"),
	"1" = load("res://Levels/test_level.tscn")
}

func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var current_level = levels[str(index)].instantiate()
	current_level.position = Vector2.ZERO
	call_deferred("add_child", current_level)
	hide()

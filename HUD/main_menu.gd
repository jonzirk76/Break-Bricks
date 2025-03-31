extends ItemList

func _ready() -> void:
	for i in item_count:
		set_item_tooltip_enabled(i, false)

extends Node

func drop_mod(brick_inventory,position):
	var drop = brick_inventory
	drop.position = position
	add_child(drop)

func _on_bricks_brick_broken(brick_inventory,position) -> void:
	drop_mod(brick_inventory,position)

func _on_main_reset_game() -> void:
	get_tree().call_group("mods", "queue_free")

extends StaticBody2D

class_name Brick

signal brick_broken(inventory,position)

func _on_area_2d_body_entered(body: Node2D) -> void:
	var inventory = $Inventory.inventory_1.instantiate()
	brick_broken.emit(inventory,position)
	queue_free()

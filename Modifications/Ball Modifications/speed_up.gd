extends Area2D

class_name Mod

@export var mods = {
	"speed": 200
}

func _physics_process(delta: float) -> void:
	var contact = self.get_overlapping_bodies()
	for body in contact:
		if body is Ball:
			queue_free()
			pass

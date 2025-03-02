extends Node

signal kill_area_entered(overlapping_bodies)

func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			child.body_entered.connect(kill_area_report)
	
func kill_area_report(body_entered):
	for child in get_children():
		if child is Area2D:
			kill_area_entered.emit(child.get_overlapping_bodies())
	

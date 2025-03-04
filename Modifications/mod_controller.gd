extends Node

signal loot_area_entered(item_stats)

#@onready var base_mod_scene = load("res://Modifications/Base Mod/base_mod.tscn")
#@onready var coin_stats = load("res://Modifications/Ball Modifications/Coin/coin.tres")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func drop_mod(position, brick_points):
	var coin_scene = load("res://Modifications/Ball Modifications/Coin/coin.tscn")
	var coin_instance = coin_scene.instantiate()
	#coin_instance.stats = coin_stats
	coin_instance.position = position
	coin_instance.pickup_collected.connect(loot_report)
	add_child(coin_instance)
	
func loot_report(item_stats):
	loot_area_entered.emit(item_stats)

func _on_bricks_brick_broken(position, brick_points) -> void:
	drop_mod(position, brick_points)

func _on_main_reset_game() -> void:
	get_tree().call_group("pickup", "queue_free")

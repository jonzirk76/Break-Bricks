extends Node

signal loot_area_entered(item_stats)

@onready var base_mod_scene = load("res://Modifications/BaseMod/base_mod.tscn")
@onready var items = {
	coin = load("res://Modifications/Items/coin.tres"),
	blue_gem = load("res://Modifications/Items/blue_gem.tres")
}

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func drop_mod(position, brick_points):
	var drop_rng = randi_range(1,3)
	var stats
	for item in items:
		if drop_rng == items[item].item_stats["rarity"]:
			stats = items[item]
			break
		else:
			stats = null
	#if drop_rng == 1:
		#item_stats = items["coin"]
	#elif drop_rng == 2:
		#item_stats = items["blue_gem"]
	#var coin_scene = load("res://Modifications/Ball Modifications/Coin/coin.tscn")
	if stats != null:
		var item_instance = base_mod_scene.instantiate()
		item_instance.stats = stats
		item_instance.position = position
		item_instance.pickup_collected.connect(loot_report)
		call_deferred("add_child",item_instance)
	
func loot_report(item_stats):
	loot_area_entered.emit(item_stats)

func _on_bricks_brick_broken(position, brick_points) -> void:
	drop_mod(position, brick_points)

func _on_main_reset_game() -> void:
	get_tree().call_group("pickup", "queue_free")

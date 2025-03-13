extends Node

signal loot_area_entered(item_stats)

@onready var base_mod_scene = load("res://Modifications/BaseMod/base_mod.tscn")
@onready var items = {
	coin = load("res://Modifications/Items/coin.tres"),
	blue_gem = load("res://Modifications/Items/blue_gem.tres"),
	rainbow_gem = load("res://Modifications/Items/rainbow_gem.tres"),
	speed_up = load("res://Modifications/Items/speed_up.tres"),
	slow_down = load("res://Modifications/Items/slow_down.tres")
}
@onready var common_items : Array
@onready var uncommon_items : Array
@onready var rare_items : Array

func _ready() -> void:
	for item in items:
		if items[item].item_stats["rarity"] == 1:
			common_items.append(item)
		elif items[item].item_stats["rarity"] == 2:
			uncommon_items.append(item)
		elif items[item].item_stats["rarity"] == 3:
			rare_items.append(item)

func _process(delta: float) -> void:
	pass

func drop_mod(position, brick_points):
	var drop_rng = randi_range(1,3)
	var stats
	if drop_rng == 1:
		var rarity_rng = randi_range(1,6)
		if rarity_rng == 1 or rarity_rng == 2 or rarity_rng == 3:
			var pick_rng = randi_range(1, common_items.size())
			var item_index = 0
			for item in common_items:
				item_index += 1
				if item_index == pick_rng:
					stats = items[item]
					break
		elif rarity_rng == 4 or rarity_rng == 5:
			var pick_rng = randi_range(1, uncommon_items.size())
			var item_index = 0
			for item in uncommon_items:
				item_index += 1
				if item_index == pick_rng:
					stats = items[item]
					break
		elif rarity_rng == 6:
			var pick_rng = randi_range(1, rare_items.size())
			var item_index = 0
			for item in rare_items:
				item_index += 1
				if item_index == pick_rng:
					stats = items[item]
					break
	else:
		stats = null
		
	if stats != null:
		var item_instance = base_mod_scene.instantiate()
		item_instance.stats = stats
		item_instance.position = position
		item_instance.pickup_collected.connect(loot_report)
		call_deferred("add_child",item_instance)
	
func loot_report(item_stats, body):
	loot_area_entered.emit(item_stats, body)

func _on_bricks_brick_broken(position, brick_points) -> void:
	drop_mod(position, brick_points)

func _on_main_reset_game() -> void:
	get_tree().call_group("pickup", "queue_free")

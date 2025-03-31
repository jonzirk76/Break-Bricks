extends Resource

class_name item_stat_sheet

@export var item_stats = {
	"rarity": 1, # 1 is common, 2 is uncommon, 3 is rare
	"loot_points": 10,
	"speed": 20
}

@export var texture: Texture2D = AtlasTexture.new()
#@export var animation: Animation

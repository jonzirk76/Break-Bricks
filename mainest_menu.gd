extends Node

signal reset_hud
signal start_level_music(music)
signal change_level_music

@onready var levels = {
	"0" = load("res://Levels/level_1.tscn"),
	"1" = load("res://Levels/secret_level.tscn"),
	"2" = load("res://Levels/test_level.tscn")
}
@export var title_music : AudioStream

var current_level

func _ready() -> void:
	start_level_music.emit(title_music)

func _on_main_hud_level_selected(level: Variant) -> void:
	current_level = levels[str(level)].instantiate()
	current_level.position = Vector2.ZERO
	current_level.reset_game.connect(reset_game)
	current_level.change_level_music.connect(change_music)
	call_deferred("add_child", current_level)
	$MainHud.get_tree().call_group("title_ui", "hide")

func reset_game(last_score):
	$MainHud.get_tree().call_group("title_ui", "show")
	change_level_music.emit(title_music)
	reset_hud.emit(last_score)

func change_music(music):
	change_level_music.emit(music)

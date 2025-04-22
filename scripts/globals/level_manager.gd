extends Node

const MENU_SCENE := preload("res://scenes/menu/menu.tscn") as PackedScene
const GAME_SCENE := preload("res://scenes/game/game.tscn") as PackedScene

const TOTAL_LEVELS := 9
var curr_level := 1
var max_level := 1

func start_game(level: int) -> void:
	curr_level = level
	get_tree().change_scene_to_packed(GAME_SCENE)

func quit_game() -> void:
	get_tree().change_scene_to_packed(MENU_SCENE)

func can_increase_level() -> bool:
	return curr_level < TOTAL_LEVELS

func increase_level() -> void:
	curr_level += 1

func update_max_level() -> void:
	if curr_level == max_level:
		max_level = curr_level + 1

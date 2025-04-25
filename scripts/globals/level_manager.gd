extends Node

const MENU_SCENE := preload("res://scenes/menu/menu.tscn") as PackedScene
const GAME_SCENE := preload("res://scenes/game/game.tscn") as PackedScene

const TOTAL_LEVELS := 12
var curr_level := 10
var max_level := 1

var best_moves := { }

func start_game(level: int) -> void:
	curr_level = level
	get_tree().change_scene_to_packed(GAME_SCENE)

func quit_game() -> void:
	get_tree().change_scene_to_packed(MENU_SCENE)

func can_increase_level() -> bool:
	return curr_level < TOTAL_LEVELS

func increase_level() -> void:
	curr_level += 1

func complete_level(num_moves: int) -> void:
	if not best_moves.has(curr_level) or num_moves < best_moves[curr_level]:
		best_moves[curr_level] = num_moves
	if curr_level == max_level and can_increase_level():
		max_level = curr_level + 1

func get_curr_best_moves() -> int:
	return best_moves[curr_level]

extends Control

const LEVEL_BUTTON := preload("res://scenes/menu/level_button.tscn")

@onready var main_panel: Control = $MainPanel
@onready var levels_panel: Control = $LevelsPanel
@onready var levels_container: GridContainer = $LevelsPanel/MarginContainer/LevelsContainer
@onready var credits_panel: Control = $CreditsPanel

func _ready() -> void:
	for i in range(LevelManager.TOTAL_LEVELS):
		var level_button = LEVEL_BUTTON.instantiate()
		levels_container.add_child(level_button)
		level_button.level_pressed.connect(on_level_button_pressed)

func on_level_button_pressed(level: int) -> void:
	LevelManager.start_game(level)

func _on_play_button_pressed() -> void:
	LevelManager.start_game(LevelManager.max_level)

func _on_levels_button_pressed() -> void:
	main_panel.hide()
	levels_panel.show()

func _on_levels_back_button_pressed() -> void:
	levels_panel.hide()
	main_panel.show()

func _on_credits_button_pressed() -> void:
	main_panel.hide()
	credits_panel.show()

func _on_credits_back_button_pressed() -> void:
	credits_panel.hide()
	main_panel.show()

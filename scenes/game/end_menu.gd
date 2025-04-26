extends PanelContainer

@onready var total_moves_label: Label = $MarginContainer/VBoxContainer/TotalMovesLabel

func _ready() -> void:
	total_moves_label.text = "Best Total Moves: %d" % LevelManager.get_total_moves()

func _on_quit_button_pressed() -> void:
	LevelManager.quit_game()

func _on_restart_button_pressed() -> void:
	LevelManager.start_game(1)

extends GameButton
class_name LevelButton

var level: int

signal level_pressed(level: int)

func _ready() -> void:
	level = get_index() + 1
	text = "Level %d" % level
	disabled = LevelManager.max_level < level

func _on_pressed() -> void:
	super()
	level_pressed.emit(level)

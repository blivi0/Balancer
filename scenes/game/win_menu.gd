extends PanelContainer
class_name WinMenu

@onready var quit_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/QuitButton
@onready var restart_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/RestartButton
@onready var next_level_button: IconButton = $MarginContainer/VBoxContainer/HBoxContainer/NextLevelButton

var viewport_height: float

func _ready() -> void:
	viewport_height = get_viewport().get_visible_rect().size.y

func show_win_menu() -> void:
	show()
	var position_diff = Vector2.UP * ((viewport_height + size.y) / 2)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", position_diff, 0.5).as_relative()

func hide_win_menu() -> void:
	hide()
	position.y = viewport_height

func hide_next_level_button() -> void:
	next_level_button.hide()
	reset_size()

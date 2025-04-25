extends PanelContainer
class_name WinMenu

@onready var moves_label: Label = $MarginContainer/VBoxContainer/MovesContainer/MovesLabel
@onready var best_label: Label = $MarginContainer/VBoxContainer/MovesContainer/BestLabel
@onready var quit_button: GameButton = $MarginContainer/VBoxContainer/ButtonsContainer/QuitButton
@onready var restart_button: GameButton = $MarginContainer/VBoxContainer/ButtonsContainer/RestartButton
@onready var next_level_button: GameButton = $MarginContainer/VBoxContainer/ButtonsContainer/NextLevelButton
@onready var win_sound: AudioStreamPlayer = $WinSound

var viewport_height: float

func _ready() -> void:
	viewport_height = get_viewport().get_visible_rect().size.y

func show_win_menu(num_moves: int) -> void:
	if not LevelManager.can_increase_level():
		next_level_button.hide()
		reset_size()
	
	moves_label.text = "Moves: %d" % num_moves
	best_label.text = "Best: %d" % LevelManager.get_curr_best_moves()
	
	show()
	var position_diff = Vector2.UP * ((viewport_height + size.y) / 2)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).set_parallel(true)
	tween.tween_property(self, "position", position_diff, 0.5).as_relative()
	tween.tween_callback(win_sound.play).set_delay(0.05)

func hide_win_menu() -> void:
	hide()
	position.y = viewport_height

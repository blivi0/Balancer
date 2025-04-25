extends PanelContainer
class_name PauseMenu

@onready var restart_button: Button = $VBoxContainer/RestartButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		show()

func _on_resume_button_pressed() -> void:
	hide()

func _on_restart_button_pressed() -> void:
	hide()

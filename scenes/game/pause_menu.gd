extends Control
class_name PauseMenu

@onready var quit_button: Button = $VBoxContainer/QuitButton

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		show()

func _on_resume_button_pressed() -> void:
	hide()

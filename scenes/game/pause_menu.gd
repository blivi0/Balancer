extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		show()

func _on_resume_button_pressed() -> void:
	hide()

func _on_quit_button_pressed() -> void:
	LevelManager.quit_game()

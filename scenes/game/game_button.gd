extends Button
class_name GameButton

@export var hover_icon: Texture2D
@export var pressed_icon: Texture2D
var normal_icon: Texture2D

@onready var button_sound: AudioStreamPlayer = $ButtonSound

func _ready() -> void:
	normal_icon = icon

func _on_mouse_entered() -> void:
	icon = hover_icon

func _on_mouse_exited() -> void:
	icon = normal_icon

func _on_button_down() -> void:
	icon = pressed_icon

func _on_button_up() -> void:
	icon = normal_icon

func _on_pressed() -> void:
	button_sound.play()

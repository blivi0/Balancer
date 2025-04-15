extends PanelContainer
class_name DescriptionContainer

@onready var icon_texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/IconTextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/NameLabel
@onready var description_label: Label = $MarginContainer/VBoxContainer/DescriptionLabel

func show_description(texture: Texture2D, name_text: String, description_text: String) -> void:
	icon_texture_rect.texture = texture
	name_label.text = name_text
	description_label.text = description_text
	show()

func hide_description() -> void:
	hide()

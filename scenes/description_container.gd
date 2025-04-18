extends PanelContainer
class_name DescriptionContainer

@onready var icon_texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/IconTextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/NameLabel
@onready var description_label: Label = $MarginContainer/VBoxContainer/DescriptionLabel

func show_description(info: SlotInfo) -> void:
	icon_texture_rect.texture = info.texture
	name_label.text = info.name
	description_label.text = info.description
	show()

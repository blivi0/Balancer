extends PanelContainer
class_name DescriptionContainer

@onready var icon_texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/IconTextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/NameLabel
@onready var description_label: Label = $MarginContainer/VBoxContainer/DescriptionLabel

func show_description(slot_resource: SlotResource) -> void:
	icon_texture_rect.texture = slot_resource.texture
	name_label.text = slot_resource.name
	description_label.text = slot_resource.description
	show()

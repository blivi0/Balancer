extends SlotItem
class_name EffectItem

const OUTLINE_MATERIAL := preload("res://resources/materials/outline_material.tres")

func apply_weight(other_weight: int) -> int:
	return other_weight

func apply_material(texture_rect: TextureRect) -> void:
	Utils.apply_outline_shader(texture_rect, get_outline_color())

func get_outline_color() -> Color:
	return Color.WHITE

extends SlotEffect
class_name HeavyEffect

func apply_weight(weight: int) -> int:
	return weight * 2

func apply_material(item_texture_rect: TextureRect) -> void:
	Utils.apply_outline_shader(item_texture_rect, Color.RED)

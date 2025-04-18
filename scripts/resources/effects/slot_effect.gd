extends SlotInfo
class_name SlotEffect

func apply_weight(weight: int) -> int:
	return weight

func apply_material(item_texture: TextureRect) -> void:
	item_texture.material = null

extends SlotEffect
class_name InvertEffect

const INVERT_MATERIAL = preload("res://resources/materials/invert_material.tres")

func apply_weight(weight: int) -> int:
	return -weight

func apply_material(item_texture: TextureRect) -> void:
	item_texture.material = INVERT_MATERIAL

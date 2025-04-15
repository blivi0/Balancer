extends SlotEffect
class_name LightEffect

const TRANSLUCENT_MATERIAL = preload("res://resources/materials/translucent_material.tres")

func apply_weight(_weight: int) -> int:
	return 0

func apply_material(item_texture: TextureRect) -> void:
	item_texture.material = TRANSLUCENT_MATERIAL

extends SlotEffect
class_name HeavyEffect

const OUTLINE_MATERIAL := preload("res://resources/materials/outline_material.tres")

func apply_weight(weight: int) -> int:
	return weight * 2

func apply_material(item_texture_rect: TextureRect) -> void:
	item_texture_rect.material = OUTLINE_MATERIAL
	item_texture_rect.material.set_shader_parameter("outline_color", Color.RED)
	var atlas_texture := item_texture_rect.texture as AtlasTexture
	if atlas_texture:
		var region := atlas_texture.region
		item_texture_rect.material.set_shader_parameter("texture_region", Vector4(region.position.x, region.position.y, region.size.x, region.size.y))

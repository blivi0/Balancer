class_name Utils

const OUTLINE_MATERIAL := preload("res://resources/materials/outline_material.tres")

static func apply_outline_shader(texture_rect: TextureRect, color: Color) -> void:
	texture_rect.material = OUTLINE_MATERIAL.duplicate()
	texture_rect.material.set_shader_parameter("outline_color", color)
	var atlas_texture := texture_rect.texture as AtlasTexture
	if atlas_texture:
		var region := atlas_texture.region
		texture_rect.material.set_shader_parameter("texture_region", Vector4(region.position.x, region.position.y, region.size.x, region.size.y))

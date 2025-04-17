extends Resource
class_name SlotEffect

@export var texture: Texture2D
@export var name: String
@export var description: String

func apply_weight(weight: int) -> int:
	return weight

func apply_material(item_texture: TextureRect) -> void:
	item_texture.material = null

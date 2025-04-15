extends Resource
class_name SlotEffect

@export var texture: Texture2D
@export var description: String

func can_drop_data() -> bool:
	return true

func apply_effect(weight: int) -> int:
	return weight

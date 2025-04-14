extends Resource
class_name SlotEffectResource

@export var texture: Texture2D

func can_drop_data() -> bool:
	return true

func apply_effect(weight: int) -> int:
	return weight

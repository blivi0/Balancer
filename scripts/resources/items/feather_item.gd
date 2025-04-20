extends EffectItem
class_name FeatherItem

func apply_weight(other_weight: int) -> int:
	return other_weight - 5

func get_outline_color() -> Color:
	return Color.YELLOW

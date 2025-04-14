extends PanelContainer
class_name SlotEffect

@export var effect: SlotEffectResource

@onready var effect_texture_rect: TextureRect = $EffectTextureRect

signal item_dropped(new_slot_item: Slot)

func _ready() -> void:
	effect_texture_rect.texture = effect.texture

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return effect.can_drop_data() and data is Slot

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	item_dropped.emit(data as Slot)

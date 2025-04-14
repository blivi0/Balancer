extends VBoxContainer
class_name SlotItem

@export var item: SlotItemResource

@onready var item_texture_rect: TextureRect = $TextureContainer/ItemTextureRect
@onready var item_label: Label = $LabelContainer/ItemLabel

signal item_dropped(new_slot_item: Slot)

func _get_drag_data(_at_position: Vector2) -> Variant:
	if not item:
		return null
	
	set_drag_preview(duplicate())
	return get_parent()

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Slot

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	item_dropped.emit(data as Slot)

func set_item(new_item: SlotItemResource, effect: SlotEffectResource) -> void:
	item = new_item
	set_item_properties(effect)

func set_item_properties(effect: SlotEffectResource) -> void:
	if item:
		item_texture_rect.texture = item.texture
		item_label.text = str(effect.apply_effect(item.weight))
		show()
	else:
		hide()

func get_weight() -> int:
	if item:
		return item.weight
	else:
		return 0

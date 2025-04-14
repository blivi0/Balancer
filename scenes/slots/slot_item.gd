extends VBoxContainer
class_name SlotItem

@export var item: SlotItemResource

@onready var item_texture_rect: TextureRect = $TextureContainer/ItemTextureRect
@onready var item_label: Label = $LabelContainer/ItemLabel

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
	return item.weight if item else 0

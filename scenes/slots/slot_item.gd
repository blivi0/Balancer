extends VBoxContainer
class_name SlotItem

@export var item: SlotItemResource

@onready var item_texture_rect: TextureRect = $TextureContainer/ItemTextureRect
@onready var item_label: Label = $LabelContainer/ItemLabel

var effective_weight := 0

func set_item(new_item: SlotItemResource, effect: SlotEffectResource) -> void:
	item = new_item
	set_item_properties(effect)

func set_item_properties(effect: SlotEffectResource) -> void:
	if item:
		effective_weight = effect.apply_effect(item.weight)
		item_texture_rect.texture = item.texture
		item_label.text = str(effective_weight)
		show()
	else:
		effective_weight = 0
		hide()

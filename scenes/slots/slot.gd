extends Control
class_name Slot

@export var effect: SlotEffect
@export var item: SlotItem

@onready var effect_texture_rect: TextureRect = $SlotEffect/EffectTextureRect
@onready var slot_item: VBoxContainer = $SlotItem
@onready var item_texture_rect: TextureRect = $SlotItem/TextureContainer/ItemTextureRect
@onready var item_label: Label = $SlotItem/LabelContainer/ItemLabel

var effective_weight := 0
var can_drag = true

signal slot_changed

func _ready() -> void:
	effect_texture_rect.texture = effect.texture

func _get_drag_data(_at_position: Vector2) -> Variant:
	if not item or not can_drag:
		return null
	
	set_drag_preview(slot_item.duplicate())
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return effect.can_drop_data() and data is Slot

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var new_slot = data as Slot
	var temp = item
	item = new_slot.item
	new_slot.item = temp
	slot_changed.emit()

func init_item() -> void:
	if item:
		set_item_weight(effect.apply_effect(item.weight))
		item_texture_rect.texture = item.texture
		slot_item.show()
	else:
		effective_weight = 0
		slot_item.hide()

func apply_item_effect(effect_item: EffectItem) -> void:
	if item:
		set_item_weight(effect_item.apply_effect(effective_weight))

func set_item_weight(weight: int) -> void:
	effective_weight = weight
	item_label.text = str(weight)

func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	pass

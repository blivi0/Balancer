extends Control
class_name Slot

@export var effect: SlotEffect
@export var item: SlotItem

@onready var effect_texture_rect: TextureRect = $VBoxContainer/SlotContainer/EffectTextureRect
@onready var item_texture_rect: TextureRect = $VBoxContainer/SlotContainer/ItemTextureRect
@onready var weight_panel_container: PanelContainer = $VBoxContainer/WeightPanelContainer
@onready var weight_label: Label = $VBoxContainer/WeightPanelContainer/WeightLabel

var effective_weight := 0
var can_drag = true

signal updated
signal hovered(item: SlotItem, effect: SlotEffect)
signal unhovered
signal dragged(item: SlotItem)
signal dropped(item: SlotItem)
signal drop_failed

func _ready() -> void:
	effect_texture_rect.texture = effect.texture

func _get_drag_data(_at_position: Vector2) -> Variant:
	if not item or not can_drag:
		return null
	
	var control = Control.new()
	control.add_child(item_texture_rect.duplicate())
	set_drag_preview(control)
	dragged.emit(item)
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Slot

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var source_slot = data as Slot
	if effect.name == "Locked":
		if source_slot.item.name != "Key":
			drop_failed.emit()
			return
		unlock()
		source_slot.item = null
		_on_mouse_exited()
	else:
		var temp = item
		item = source_slot.item
		source_slot.item = temp
		dropped.emit(item)
		_on_mouse_entered()
	updated.emit()

func init_item() -> void:
	if item:
		item_texture_rect.texture = item.texture
		effect.apply_material(item_texture_rect)
		set_item_weight(effect.apply_weight(item.weight))
		item_texture_rect.show()
		weight_panel_container.show()
	else:
		effective_weight = 0
		item_texture_rect.hide()
		weight_panel_container.hide()

func apply_item_effect(effect_item: EffectItem) -> void:
	if item:
		set_item_weight(effect_item.apply_weight(effective_weight))

func set_item_weight(weight: int) -> void:
	effective_weight = weight
	weight_label.text = str(weight)

func unlock() -> void:
	# TODO: play animation
	effect = load("res://resources/effects/base_effect.tres") as SlotEffect
	effect_texture_rect.texture = effect.texture

func _on_mouse_entered() -> void:
	if (item and item.description) or effect.description:
		hovered.emit(item, effect)

func _on_mouse_exited() -> void:
	unhovered.emit()

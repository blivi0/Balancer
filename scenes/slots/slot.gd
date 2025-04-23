extends Control
class_name Slot

@export var effect: SlotEffect
@export var item: SlotItem

@onready var effect_texture_rect: TextureRect = $VBoxContainer/SlotContainer/EffectTextureRect
@onready var item_texture_rect: TextureRect = $VBoxContainer/SlotContainer/ItemTextureRect
@onready var weight_panel_container: PanelContainer = $VBoxContainer/WeightPanelContainer
@onready var weight_label: Label = $VBoxContainer/WeightPanelContainer/HBoxContainer/WeightLabel
@onready var pickup_sound: AudioStreamPlayer = $PickupSound
@onready var drop_sound: AudioStreamPlayer = $DropSound

var effective_weight := 0
var slot_enabled := true

signal updated
signal item_hovered(slot_resource: SlotResource)
signal effect_hovered(slot_resource: SlotResource)
signal unhovered

func _ready() -> void:
	effect_texture_rect.texture = effect.texture

func _get_drag_data(_at_position: Vector2) -> Variant:
	if not item or not slot_enabled:
		return null
	
	var control := Control.new()
	control.add_child(item_texture_rect.duplicate())
	set_drag_preview(control)
	
	play_pickup_sound()
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Slot

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var source_slot := data as Slot
	var temp := item
	item = source_slot.item
	source_slot.item = temp
	play_drop_sound()
	_on_mouse_entered()
	updated.emit()

func initialize() -> void:
	effect_texture_rect.material = null
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
	effect_item.apply_material(effect_texture_rect)
	if item:
		set_item_weight(effect_item.apply_weight(effective_weight))

func set_item_weight(weight: int) -> void:
	effective_weight = weight
	weight_label.text = str(weight)

func play_pickup_sound() -> void:
	pickup_sound.stream = item.pickup_audio
	pickup_sound.play()

func play_drop_sound() -> void:
	drop_sound.stream = item.drop_audio
	drop_sound.play()

func _on_mouse_entered() -> void:
	if not slot_enabled:
		return
	if item and item.description:
		item_hovered.emit(item)
	if effect.description:
		effect_hovered.emit(effect)

func _on_mouse_exited() -> void:
	unhovered.emit()

extends Slot
class_name LockedSlot

const LOCK_RESOURCE := preload("res://resources/lock_resource.tres")

@onready var locked_sound: AudioStreamPlayer = $LockedSound
@onready var unlock_sound: AudioStreamPlayer = $UnlockSound
@onready var animated_sprite_2d: AnimatedSprite2D = $VBoxContainer/SlotContainer/AnimatedSprite2D

var locked := true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if not locked:
		super(at_position, data)
		return
	
	var source_slot := data as Slot
	if source_slot.item.name != "Key":
		locked_sound.play()
		return
	
	locked = false
	unlock_sound.play()
	animated_sprite_2d.play()
	source_slot.item = null
	_on_mouse_exited()
	updated.emit()

func apply_item_effect(effect_item: EffectItem) -> void:
	if not locked:
		super(effect_item)

func _on_mouse_entered() -> void:
	if not locked:
		super()
		return
	effect_hovered.emit(LOCK_RESOURCE)

func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite_2d.hide()
	animated_sprite_2d.queue_free()

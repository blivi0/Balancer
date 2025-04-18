extends Slot
class_name LockedSlot

const LOCK_INFO := preload("res://resources/lock_info.tres")

@onready var locked_sound: AudioStreamPlayer = $LockedSound

var locked := true

func _ready() -> void:
	pass

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if not locked:
		super(at_position, data)
		return
	
	var source_slot := data as Slot
	if source_slot.item.name != "Key":
		locked_sound.play()
		return
	
	# TODO: play animation
	locked = false
	effect_texture_rect.texture = effect.texture
	source_slot.item = null
	_on_mouse_exited()
	updated.emit()

func _on_mouse_entered() -> void:
	if locked:
		effect_hovered.emit(LOCK_INFO)

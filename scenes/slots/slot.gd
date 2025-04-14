extends Control
class_name Slot

@onready var slot_effect: SlotEffect = $SlotEffect
@onready var slot_item: SlotItem = $SlotItem

signal slot_changed

func _ready() -> void:
	slot_effect.item_dropped.connect(on_item_dropped)
	slot_item.set_item_properties(slot_effect.effect)

func on_item_dropped(new_slot: Slot) -> void:
	var temp = slot_item.item
	set_item(new_slot.slot_item.item)
	new_slot.set_item(temp)
	slot_changed.emit()

func set_item(item: SlotItemResource) -> void:
	slot_item.set_item(item, slot_effect.effect)

func get_weight() -> int:
	var weight := slot_item.get_weight()
	return slot_effect.effect.apply_effect(weight)

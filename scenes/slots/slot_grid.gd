extends GridContainer
class_name SlotGrid

var slots: Array[Slot]

signal grid_changed

func _ready() -> void:
	slots = []
	var children = get_children()
	for child in children:
		var slot = child as Slot
		slot.slot_changed.connect(on_slot_changed)
		slots.append(slot)

func on_slot_changed() -> void:
	grid_changed.emit()

func get_total_weight() -> int:
	var total_weight := 0
	for slot in slots:
		total_weight += slot.effective_weight
	return total_weight

func disable_slots() -> void:
	for slot in slots:
		slot.can_drag = false

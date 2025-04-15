extends GridContainer
class_name SlotGrid

var slots: Array[Slot]
var rows: int

signal grid_changed

func _ready() -> void:
	slots = []
	var children = get_children()
	for child in children:
		var slot = child as Slot
		slot.slot_changed.connect(on_slot_changed)
		slots.append(slot)
	update_slot_weights()
	rows = slots.size() / columns

func on_slot_changed() -> void:
	grid_changed.emit()

func get_total_weight() -> int:
	update_slot_weights()
	var total_weight := 0
	for slot in slots:
		total_weight += slot.effective_weight
	return total_weight

func update_slot_weights() -> void:
	for slot in slots:
		slot.init_item()
	for i in range(slots.size()):
		var slot = slots[i]
		if slot.item is EffectItem:
			apply_item_effect(i, slot.item)

func apply_item_effect(i: int, effect_item: EffectItem) -> void:
	var row = i / columns
	var col = i % columns
	if row > 0:
		get_slot(row - 1, col).apply_item_effect(effect_item)
	if col > 0:
		get_slot(row, col - 1).apply_item_effect(effect_item)
	if row < rows - 1:
		get_slot(row + 1, col).apply_item_effect(effect_item)
	if col < columns - 1:
		get_slot(row, col + 1).apply_item_effect(effect_item)

func get_slot(row: int, col: int) -> Slot:
	return slots[row * columns + col]

func disable_slots() -> void:
	for slot in slots:
		slot.can_drag = false

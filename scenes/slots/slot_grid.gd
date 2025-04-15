extends GridContainer
class_name SlotGrid

var slots: Array[Slot]
var rows: int

signal grid_changed
signal grid_hovered(item: SlotItem, effect: SlotEffect)
signal grid_unhovered

func _ready() -> void:
	slots = []
	var children = get_children()
	for child in children:
		var slot = child as Slot
		connect_signals(slot)
		slots.append(slot)
	update_slot_weights()
	@warning_ignore("integer_division")
	rows = slots.size() / columns

func connect_signals(slot: Slot) -> void:
	slot.slot_changed.connect(on_slot_changed)
	slot.slot_hovered.connect(on_slot_hovered)
	slot.slot_unhovered.connect(on_slot_unhovered)

func on_slot_changed() -> void:
	grid_changed.emit()

func on_slot_hovered(item: SlotItem, effect: SlotEffect) -> void:
	grid_hovered.emit(item, effect)

func on_slot_unhovered() -> void:
	grid_unhovered.emit()

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
	@warning_ignore("integer_division")
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

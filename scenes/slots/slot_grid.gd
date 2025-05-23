extends GridContainer
class_name SlotGrid

var slots: Array[Slot]
var rows: int

func _ready() -> void:
	slots = []
	var children = get_children()
	for child in children:
		var slot = child as Slot
		slots.append(slot)
	update_slot_weights()
	@warning_ignore("integer_division")
	rows = slots.size() / columns

func get_total_weight() -> int:
	update_slot_weights()
	var total_weight := 0
	for slot in slots:
		total_weight += slot.effective_weight
	return total_weight

func update_slot_weights() -> void:
	# First pass: set initial item properties
	for slot in slots:
		slot.initialize()
	
	# Second pass: apply item effects
	for i in range(slots.size()):
		var slot = slots[i]
		if slot.item is EffectItem:
			apply_item_effect(i, slot.item)

func apply_item_effect(i: int, effect_item: EffectItem) -> void:
	@warning_ignore("integer_division")
	var row = i / columns
	var col = i % columns
	if row > 0:
		get_slot(row - 1, col).apply_item_effect(effect_item, DataTypes.Direction.UP)
	if col > 0:
		get_slot(row, col - 1).apply_item_effect(effect_item, DataTypes.Direction.RIGHT)
	if row < rows - 1:
		get_slot(row + 1, col).apply_item_effect(effect_item, DataTypes.Direction.DOWN)
	if col < columns - 1:
		get_slot(row, col + 1).apply_item_effect(effect_item, DataTypes.Direction.LEFT)

func get_slot(row: int, col: int) -> Slot:
	return slots[row * columns + col]

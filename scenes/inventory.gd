extends VBoxContainer
class_name Inventory

const LEVEL_FORMAT := "res://scenes/levels/level_%d_%s.tscn"

@onready var label: Label = $Label

var slot_grid: SlotGrid
var total: int

func load_level(level_num: int, side: String) -> void:
	if slot_grid:
		slot_grid.queue_free()
	
	var level_path := LEVEL_FORMAT % [level_num, side]
	slot_grid = load(level_path).instantiate() as SlotGrid
	add_child(slot_grid)
	move_child(slot_grid, 0)
	update_total()

func get_slots() -> Array[Slot]:
	return slot_grid.slots

func update_total() -> void:
	total = slot_grid.get_total_weight()
	label.text = str(total)

func disable_grid() -> void:
	slot_grid.disable_slots()

extends VBoxContainer
class_name Inventory

const LEVEL_FORMAT = "res://scenes/levels/level_%d_%s.tscn"

@onready var label: Label = $Label

var slot_grid: SlotGrid
var total: int

signal inventory_changed

func load_level(level_num: int, side: String) -> void:
	if slot_grid:
		slot_grid.queue_free()
	
	var level_path := LEVEL_FORMAT % [level_num, side]
	slot_grid = load(level_path).instantiate() as SlotGrid
	add_child(slot_grid)
	move_child(slot_grid, 0)
	slot_grid.grid_changed.connect(on_grid_changed)
	update_total()

func update_total() -> void:
	total = slot_grid.get_total_weight()
	label.text = str(total)

func on_grid_changed() -> void:
	inventory_changed.emit()

func disable_grid() -> void:
	slot_grid.disable_slots()

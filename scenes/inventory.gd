extends VBoxContainer
class_name Inventory

@onready var slot_grid: SlotGrid = $SlotGrid
@onready var label: Label = $Label

var total: int

signal inventory_changed

func _ready() -> void:
	update_total()
	slot_grid.grid_changed.connect(on_grid_changed)

func update_total() -> void:
	total = slot_grid.get_total_weight()
	label.text = str(total)

func on_grid_changed() -> void:
	inventory_changed.emit()

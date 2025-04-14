extends VBoxContainer
class_name Inventory

@onready var slot_grid: SlotGrid = $SlotGrid
@onready var label: Label = $Label

signal inventory_changed

func _ready() -> void:
	update_total()
	slot_grid.grid_changed.connect(on_grid_changed)

func update_total() -> void:
	label.text = str(slot_grid.get_total_weight())

func on_grid_changed() -> void:
	inventory_changed.emit()

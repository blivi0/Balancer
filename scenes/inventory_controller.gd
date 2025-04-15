extends HBoxContainer
class_name InventoryController

@onready var left_container: MarginContainer = $LeftContainer
@onready var right_container: MarginContainer = $RightContainer
@onready var left_inventory: Inventory = $LeftContainer/LeftInventory
@onready var right_inventory: Inventory = $RightContainer/RightInventory

signal balanced
signal hovered(item: SlotItem, effect: SlotEffect)
signal unhovered

func _ready() -> void:
	load_level(1)
	connect_signals(left_inventory.slot_grid)
	connect_signals(right_inventory.slot_grid)

func connect_signals(slot_grid: SlotGrid) -> void:
	slot_grid.grid_changed.connect(on_inventory_changed)
	slot_grid.grid_hovered.connect(on_inventory_hovered)
	slot_grid.grid_unhovered.connect(on_inventory_unhovered)

func load_level(level_num: int) -> void:
	left_inventory.load_level(level_num, "left")
	right_inventory.load_level(level_num, "right")

func on_inventory_changed() -> void:
	left_inventory.update_total()
	right_inventory.update_total()
	if left_inventory.total == right_inventory.total:
		left_inventory.disable_grid()
		right_inventory.disable_grid()
		balanced.emit()

func on_inventory_hovered(item: SlotItem, effect: SlotEffect) -> void:
	hovered.emit(item, effect)

func on_inventory_unhovered() -> void:
	unhovered.emit()

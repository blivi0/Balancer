extends HBoxContainer
class_name InventoryController

@onready var left_container: MarginContainer = $LeftContainer
@onready var right_container: MarginContainer = $RightContainer
@onready var left_inventory: Inventory = $LeftContainer/LeftInventory
@onready var right_inventory: Inventory = $RightContainer/RightInventory

var all_slots: Array[Slot]

signal balanced

func load_level(level_num: int) -> void:
	left_inventory.load_level(level_num, "left")
	right_inventory.load_level(level_num, "right")
	all_slots = left_inventory.get_slots() + right_inventory.get_slots()
	for slot in all_slots:
		slot.updated.connect(on_slot_updated)

func on_slot_updated() -> void:
	left_inventory.update_total()
	right_inventory.update_total()
	if left_inventory.total == right_inventory.total:
		disable_slots()
		balanced.emit()

func disable_slots() -> void:
	for slot in all_slots:
		slot.slot_enabled = false

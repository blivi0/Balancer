extends HBoxContainer
class_name InventoryController

const MIN_MARGIN_TOP := 0
const MAX_MARGIN_TOP := 96
@warning_ignore("integer_division")
const MID_MARGIN_TOP = (MIN_MARGIN_TOP + MAX_MARGIN_TOP) / 2

@onready var left_inventory: Inventory = $LeftInventory
@onready var right_inventory: Inventory = $RightInventory

var all_slots: Array[Slot]
signal balanced

func _ready() -> void:
	# Only need one signal
	left_inventory.tween_finished.connect(on_inventory_tween_finished)

func load_level(level_num: int) -> void:
	left_inventory.load_level(level_num, "left")
	right_inventory.load_level(level_num, "right")
	all_slots = left_inventory.get_slots() + right_inventory.get_slots()
	for slot in all_slots:
		slot.updated.connect(on_slot_updated)
	start_inventory_tweens()

func on_slot_updated() -> void:
	left_inventory.update_total()
	right_inventory.update_total()
	start_inventory_tweens()

func start_inventory_tweens() -> void:
	if left_inventory.total == right_inventory.total:
		left_inventory.start_tween(MID_MARGIN_TOP)
		right_inventory.start_tween(MID_MARGIN_TOP)
	elif left_inventory.total < right_inventory.total:
		left_inventory.start_tween(MIN_MARGIN_TOP)
		right_inventory.start_tween(MAX_MARGIN_TOP)
	else:
		left_inventory.start_tween(MAX_MARGIN_TOP)
		right_inventory.start_tween(MIN_MARGIN_TOP)

func on_inventory_tween_finished() -> void:
	if left_inventory.total == right_inventory.total:
		disable_slots()
		balanced.emit()

func disable_slots() -> void:
	for slot in all_slots:
		slot.slot_enabled = false

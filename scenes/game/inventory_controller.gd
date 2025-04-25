extends HBoxContainer
class_name InventoryController

@onready var left_inventory: Inventory = $LeftInventory
@onready var right_inventory: Inventory = $RightInventory

var all_slots: Array[Slot]
var num_moves := 0
signal balanced(num_moves: int)

func _ready() -> void:
	# Only need one signal
	left_inventory.tween_finished.connect(on_inventory_tween_finished)

func load_level(level_num: int) -> void:
	num_moves = 0
	left_inventory.load_level(level_num, "left")
	right_inventory.load_level(level_num, "right")
	all_slots = left_inventory.get_slots() + right_inventory.get_slots()
	for slot in all_slots:
		slot.updated.connect(on_slot_updated)
	set_inventory_status()

func on_slot_updated() -> void:
	num_moves += 1
	left_inventory.update_total()
	right_inventory.update_total()
	set_inventory_status()

func set_inventory_status() -> void:
	if left_inventory.total == right_inventory.total:
		left_inventory.set_status(DataTypes.InventoryStatus.BALANCED)
		right_inventory.set_status(DataTypes.InventoryStatus.BALANCED)
	elif left_inventory.total < right_inventory.total:
		left_inventory.set_status(DataTypes.InventoryStatus.LIGHT)
		right_inventory.set_status(DataTypes.InventoryStatus.HEAVY)
	else:
		left_inventory.set_status(DataTypes.InventoryStatus.HEAVY)
		right_inventory.set_status(DataTypes.InventoryStatus.LIGHT)

func on_inventory_tween_finished() -> void:
	if left_inventory.total == right_inventory.total:
		disable_slots()
		balanced.emit(num_moves)

func disable_slots() -> void:
	for slot in all_slots:
		slot.slot_enabled = false

extends HBoxContainer
class_name InventoryController

@onready var left_container: MarginContainer = $LeftContainer
@onready var right_container: MarginContainer = $RightContainer
@onready var left_inventory: Inventory = $LeftContainer/LeftInventory
@onready var right_inventory: Inventory = $RightContainer/RightInventory

signal balanced

func _ready() -> void:
	load_level(1)
	left_inventory.inventory_changed.connect(on_inventory_changed)
	right_inventory.inventory_changed.connect(on_inventory_changed)

func load_level(level_num: int) -> void:
	left_inventory.load_level(level_num, "left")
	right_inventory.load_level(level_num, "right")

func on_inventory_changed() -> void:
	var total := left_inventory.total + right_inventory.total
	
	if left_inventory.total == right_inventory.total:
		left_inventory.disable_grid()
		right_inventory.disable_grid()
		balanced.emit()

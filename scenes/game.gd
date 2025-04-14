extends Control

@onready var left_inventory: Inventory = $HBoxContainer/LeftInventory
@onready var right_inventory: Inventory = $HBoxContainer/RightInventory

func _ready() -> void:
	left_inventory.inventory_changed.connect(on_inventory_changed)
	right_inventory.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed() -> void:
	left_inventory.update_total()
	right_inventory.update_total()

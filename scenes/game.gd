extends Control

@onready var left_inventory: Inventory = $MarginContainer/HBoxContainer/LeftInventory
@onready var right_inventory: Inventory = $MarginContainer/HBoxContainer/RightInventory
@onready var win_label: Label = $MarginContainer/WinLabel

func _ready() -> void:
	left_inventory.inventory_changed.connect(on_inventory_changed)
	right_inventory.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed() -> void:
	left_inventory.update_total()
	right_inventory.update_total()
	if left_inventory.total == right_inventory.total:
		win_label.show()

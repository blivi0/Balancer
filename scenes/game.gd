extends Control

const MAX_LEVEL = 2

@onready var inventory_controller: InventoryController = $InventoryController
@onready var win_container: PanelContainer = $WinContainer
@onready var next_level_button: Button = $WinContainer/MarginContainer/VBoxContainer/NextLevelButton

var level := 1

func _ready() -> void:
	inventory_controller.balanced.connect(on_inventory_balanced)
	next_level_button.pressed.connect(on_next_level_pressed)
	
func on_inventory_balanced() -> void:
	level += 1
	if level > MAX_LEVEL:
		next_level_button.hide()
	win_container.show()

func on_next_level_pressed() -> void:
	win_container.hide()
	inventory_controller.load_level(level)

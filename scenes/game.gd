extends Control

const MAX_LEVEL := 1

@onready var inventory_controller: InventoryController = $InventoryController
@onready var win_container: PanelContainer = $WinContainer
@onready var next_level_button: Button = $WinContainer/MarginContainer/VBoxContainer/NextLevelButton
@onready var item_description: DescriptionContainer = $ItemDescription
@onready var slot_description: DescriptionContainer = $SlotDescription

var level := 1

func _ready() -> void:
	inventory_controller.balanced.connect(on_inventory_balanced)
	inventory_controller.hovered.connect(on_hovered)
	inventory_controller.unhovered.connect(on_unhovered)
	next_level_button.pressed.connect(on_next_level_pressed)

func on_hovered(item: SlotItem, effect: SlotEffect) -> void:
	if item is EffectItem:
		item_description.show_description(item.texture, item.name, item.description)
	if effect.description:
		slot_description.show_description(effect.texture, effect.name, effect.description)

func on_unhovered() -> void:
	item_description.hide_description()
	slot_description.hide_description()

func on_inventory_balanced() -> void:
	level += 1
	if level > MAX_LEVEL:
		next_level_button.hide()
	win_container.show()

func on_next_level_pressed() -> void:
	win_container.hide()
	inventory_controller.load_level(level)

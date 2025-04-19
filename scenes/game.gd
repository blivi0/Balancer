extends Control

const MAX_LEVEL := 4

@onready var inventory_controller: InventoryController = $InventoryController
@onready var item_description: DescriptionContainer = $HBoxContainer/ItemDescription
@onready var effect_description: DescriptionContainer = $HBoxContainer/EffectDescription
@onready var win_container: PanelContainer = $WinContainer
@onready var restart_button: Button = $WinContainer/MarginContainer/VBoxContainer/RestartButton
@onready var next_level_button: Button = $WinContainer/MarginContainer/VBoxContainer/NextLevelButton

var level := 1

func _ready() -> void:
	load_level()
	inventory_controller.balanced.connect(on_inventory_balanced)
	restart_button.pressed.connect(on_restart_pressed)
	next_level_button.pressed.connect(on_next_level_pressed)

func load_level() -> void:
	win_container.hide()
	inventory_controller.load_level(level)
	for slot in inventory_controller.all_slots:
		slot.item_hovered.connect(on_slot_item_hovered)
		slot.effect_hovered.connect(on_slot_effect_hovered)
		slot.unhovered.connect(on_slot_unhovered)

func on_inventory_balanced() -> void:
	if level >= MAX_LEVEL:
		next_level_button.hide()
	win_container.reset_size()
	win_container.show()

func on_restart_pressed() -> void:
	load_level()

func on_next_level_pressed() -> void:
	level += 1
	load_level()

func on_slot_item_hovered(slot_resource: SlotResource) -> void:
	item_description.show_description(slot_resource)

func on_slot_effect_hovered(slot_resource: SlotResource) -> void:
	effect_description.show_description(slot_resource)

func on_slot_unhovered() -> void:
	item_description.hide()
	effect_description.hide()

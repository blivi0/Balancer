extends Control

const MENU_SCENE := preload("res://scenes/menu/menu.tscn") as PackedScene

@onready var inventory_controller: InventoryController = $InventoryController
@onready var item_description: DescriptionContainer = $HBoxContainer/ItemDescription
@onready var effect_description: DescriptionContainer = $HBoxContainer/EffectDescription
@onready var win_container: PanelContainer = $WinContainer
@onready var next_level_button: Button = $WinContainer/MarginContainer/VBoxContainer/NextLevelButton

func _ready() -> void:
	load_level()
	inventory_controller.balanced.connect(on_inventory_balanced)

func load_level() -> void:
	win_container.hide()
	inventory_controller.load_level(LevelManager.curr_level)
	for slot in inventory_controller.all_slots:
		slot.item_hovered.connect(on_slot_item_hovered)
		slot.effect_hovered.connect(on_slot_effect_hovered)
		slot.unhovered.connect(on_slot_unhovered)

func on_inventory_balanced() -> void:
	if LevelManager.can_increase_level():
		LevelManager.update_max_level()
	else:
		next_level_button.hide()
	win_container.reset_size()
	win_container.show()

func on_slot_item_hovered(slot_resource: SlotResource) -> void:
	item_description.show_description(slot_resource)

func on_slot_effect_hovered(slot_resource: SlotResource) -> void:
	effect_description.show_description(slot_resource)

func on_slot_unhovered() -> void:
	item_description.hide()
	effect_description.hide()

func _on_next_level_button_pressed() -> void:
	LevelManager.increase_level()
	load_level()

func _on_restart_button_pressed() -> void:
	load_level()

func _on_quit_button_pressed() -> void:
	LevelManager.quit_game()

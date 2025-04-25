extends Control

@onready var inventory_controller: InventoryController = $InventoryController
@onready var item_description: DescriptionContainer = $HBoxContainer/ItemDescription
@onready var effect_description: DescriptionContainer = $HBoxContainer/EffectDescription
@onready var win_menu: WinMenu = $WinMenu
@onready var pause_menu: PauseMenu = $PauseMenu

func _ready() -> void:
	inventory_controller.balanced.connect(on_inventory_balanced)
	win_menu.next_level_button.pressed.connect(on_next_level)
	win_menu.restart_button.pressed.connect(on_restart_level)
	win_menu.quit_button.pressed.connect(on_quit)
	pause_menu.restart_button.pressed.connect(on_restart_level)
	pause_menu.quit_button.pressed.connect(on_quit)
	load_level()

func load_level() -> void:
	win_menu.hide_win_menu()
	inventory_controller.load_level(LevelManager.curr_level)
	for slot in inventory_controller.all_slots:
		slot.item_hovered.connect(on_slot_item_hovered)
		slot.effect_hovered.connect(on_slot_effect_hovered)
		slot.unhovered.connect(on_slot_unhovered)

func on_inventory_balanced(num_moves: int) -> void:
	LevelManager.complete_level(num_moves)
	win_menu.show_win_menu(num_moves)

func on_slot_item_hovered(slot_resource: SlotResource) -> void:
	item_description.show_description(slot_resource)

func on_slot_effect_hovered(slot_resource: SlotResource) -> void:
	effect_description.show_description(slot_resource)

func on_slot_unhovered() -> void:
	item_description.hide()
	effect_description.hide()

func on_next_level() -> void:
	LevelManager.increase_level()
	load_level()

func on_restart_level() -> void:
	load_level()

func on_quit() -> void:
	LevelManager.quit_game()

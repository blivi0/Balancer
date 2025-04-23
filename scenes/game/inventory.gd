extends MarginContainer
class_name Inventory

const LEVEL_FORMAT := "res://scenes/levels/level_%d_%s.tscn"

const TWEEN_DURATION := 0.75
const MIN_MARGIN_TOP := 0
const MAX_MARGIN_TOP := 96
@warning_ignore("integer_division")
const MID_MARGIN_TOP = (MIN_MARGIN_TOP + MAX_MARGIN_TOP) / 2

@export var heavy_icon: Texture2D
@export var balanced_icon: Texture2D
var normal_icon: Texture2D

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var weight_icon: TextureRect = $VBoxContainer/PanelContainer/HBoxContainer/WeightIcon
@onready var weight_label: Label = $VBoxContainer/PanelContainer/HBoxContainer/Control/WeightLabel

var slot_grid: SlotGrid
var total: int
var display_total: int
var margin_top: int
var tween: Tween

signal tween_finished

func _ready() -> void:
	margin_top = get_theme_constant("margin_top")
	normal_icon = weight_icon.texture

func _process(_delta: float) -> void:
	if tween and tween.is_running():
		weight_label.text = str(display_total)
		add_theme_constant_override("margin_top", margin_top)

func load_level(level_num: int, side: String) -> void:
	if slot_grid:
		slot_grid.queue_free()
	
	var level_path := LEVEL_FORMAT % [level_num, side]
	slot_grid = load(level_path).instantiate() as SlotGrid
	v_box_container.add_child(slot_grid)
	v_box_container.move_child(slot_grid, 0)
	update_total()
	display_total = total

func get_slots() -> Array[Slot]:
	return slot_grid.slots

func update_total() -> void:
	total = slot_grid.get_total_weight()

func set_status(status: DataTypes.InventoryStatus) -> void:
	var target_margin_top: int
	match status:
		DataTypes.InventoryStatus.LIGHT:
			target_margin_top = MIN_MARGIN_TOP
			weight_icon.texture = normal_icon
		DataTypes.InventoryStatus.HEAVY:
			target_margin_top = MAX_MARGIN_TOP
			weight_icon.texture = heavy_icon
		DataTypes.InventoryStatus.BALANCED:
			target_margin_top = MID_MARGIN_TOP
			weight_icon.texture = balanced_icon
	
	if tween and tween.is_running():
		tween.stop()
	tween = get_tree().create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	if abs(total - display_total) < 3:
		display_total = total
	else:
		tween.tween_property(self, "display_total", total, TWEEN_DURATION)
	
	if margin_top != target_margin_top:
		tween.tween_property(self, "margin_top", target_margin_top, TWEEN_DURATION)
	
	tween.chain().tween_callback(on_tween_finished)

func on_tween_finished() -> void:
	tween = null
	tween_finished.emit()

extends Node

const DEFAULT_CURSOR := preload("res://resources/cursors/default_cursor.tres")
const CLICK_CURSOR := preload("res://resources/cursors/click_cursor.tres")
const FORBIDDEN_CURSOR := preload("res://resources/cursors/forbidden_cursor.tres")
const CAN_DROP_CURSOR := preload("res://resources/cursors/can_drop_cursor.tres")

func _ready() -> void:
	Input.set_custom_mouse_cursor(DEFAULT_CURSOR)
	Input.set_custom_mouse_cursor(FORBIDDEN_CURSOR, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(CAN_DROP_CURSOR, Input.CURSOR_CAN_DROP)

func _input(event: InputEvent) -> void:
	var mouse_event := event as InputEventMouseButton
	if not mouse_event or mouse_event.button_index != MOUSE_BUTTON_LEFT:
		return
	Input.set_custom_mouse_cursor(CLICK_CURSOR if mouse_event.pressed else DEFAULT_CURSOR)

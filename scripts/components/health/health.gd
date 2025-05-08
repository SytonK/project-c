class_name Health extends Node

signal value_changed(new_health: float)
signal died()

@export var max_value: float
@onready var value: float = max_value : set = _set_value

func _set_value(new_value: float) -> void:
	var old: float = value
	value = clampf(new_value, 0, max_value)
	
	if old != value:
		value_changed.emit(value)
	
	if value == 0:
		died.emit()

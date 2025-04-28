class_name PlayerInput extends Node

static func get_side_strength() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

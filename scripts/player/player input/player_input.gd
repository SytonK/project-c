class_name PlayerInput

const MIN_STRENGHT_FOR_INPUT_DIRECTION: float = 0.3
enum InputDirection{SIDE, UP, DOWN}

static func get_side_strength() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

static func get_input_direction() -> InputDirection:
	var input_dir = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	
	if input_dir.y < -MIN_STRENGHT_FOR_INPUT_DIRECTION:
		return InputDirection.UP
	elif input_dir.y > MIN_STRENGHT_FOR_INPUT_DIRECTION:
		return InputDirection.DOWN
	else:
		return InputDirection.SIDE

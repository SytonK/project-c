extends PlayerState

func physics_process(delta: float) -> void:
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()
	
	_calculate_transition()

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.jump_action.jump()

func _calculate_transition() -> void:
	if !player.is_on_floor():
		transition.emit(PlayerState.AIR)

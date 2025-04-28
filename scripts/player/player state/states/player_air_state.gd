extends PlayerState

func process(delta: float) -> void:
	player.gravity.apply_gravity(delta)
	
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()
	
	player.calculate_transition()

func input(event: InputEvent) -> void:
	if event.is_action_released("jump"):
		player.stop_jump_action.stop_jump()
	if event.is_action_pressed("jump"):
		player.air_jump_action.air_jump()

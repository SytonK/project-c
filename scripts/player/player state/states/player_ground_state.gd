extends PlayerState

func physics_process(delta: float) -> void:
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()

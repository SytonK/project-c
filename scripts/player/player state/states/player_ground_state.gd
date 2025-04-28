extends PlayerState

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	player.air_jump_action.reset_air_jumps()

func physics_process(delta: float) -> void:
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()
	
	player.calculate_transition()

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.jump_action.jump()

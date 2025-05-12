extends PlayerState

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	player.air_jump_action.reset_air_jumps()

func physics_process(delta: float) -> void:
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()
	
	player.look_at_movement_direction()
	
	player.calculate_transition()

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.jump_action.jump()
	if event.is_action_pressed("dash"):
		player.player_dash_action.cast()
	if event.is_action_pressed("block"):
		player.player_block_action.cast()
	player.attack(event)
	if event.is_action_pressed("next_weapon"):
		player.weapon_manager.go_to_next_weapon()

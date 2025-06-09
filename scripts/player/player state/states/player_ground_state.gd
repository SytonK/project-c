extends PlayerState

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	player.air_jump_action.reset_air_jumps()
	if(player.input_buffer.input_event):
		input(player.input_buffer.input_event)
		player.input_buffer.input_event = null

func physics_process(delta: float) -> void:
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()
	
	player.look_at_movement_direction()
	
	player.calculate_transition()
	
	_animate()

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.jump_action.jump()
		return
	if event.is_action_pressed("dash"):
		player.player_dash_action.cast()
		return
	if event.is_action_pressed("block"):
		player.player_block_action.cast()
		return
	if player.weapon_manager.attack(event):
		return
	if event.is_action_pressed("next_weapon"):
		player.weapon_manager.go_to_next_weapon()
		return
	
	player.input_buffer.input_event = event

func _animate() -> void:
	var animation_name: String
	
	if player.velocity.x == 0:
		animation_name = "idle"
	else:
		animation_name = "run"
	
	if player.weapon_manager.current_weapon.animation_player.has_animation(animation_name):
		player.weapon_manager.current_weapon.animation_player.play(animation_name)

extends PlayerState

@onready var edge_forgiveness_timer: Timer = $EdgeForgivenessTimer
var is_edge_forgiveness: bool = false

func enter(previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	if previuse_state_name == PlayerStates.GROUND:
		_start_edge_forgivness()
	
	if(player.input_buffer.input_event):
		input(player.input_buffer.input_event)
		player.input_buffer.input_event = null

func process(delta: float) -> void:
	player.gravity.apply_gravity(delta)
	
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()
	
	player.look_at_movement_direction()
	
	player.calculate_transition()
	
	_animate()

func input(event: InputEvent) -> void:
	if event.is_action_released("jump"):
		player.stop_jump_action.stop_jump()
		return
	if event.is_action_pressed("jump"):
		if is_edge_forgiveness:
			player.jump_action.jump()
			is_edge_forgiveness = false
		else:
			if !player.air_jump_action.air_jump():
				player.input_buffer.input_event = event
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

func _start_edge_forgivness() -> void:
	if player.velocity.y < 0:
		return
	
	is_edge_forgiveness = true
	edge_forgiveness_timer.start()

func _on_edge_forgiveness_timer_timeout() -> void:
	is_edge_forgiveness = false

func _animate() -> void:
	var animation_name: String
	
	if player.velocity.y > 0:
		animation_name = "fall"
	else:
		animation_name = "jump"
	
	if player.weapon_manager.current_weapon.animation_player.has_animation(animation_name):
		player.weapon_manager.current_weapon.animation_player.play(animation_name)

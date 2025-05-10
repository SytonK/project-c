extends PlayerState

@onready var edge_forgiveness_timer: Timer = $EdgeForgivenessTimer
var is_edge_forgiveness: bool = false

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	_start_edge_forgivness()

func process(delta: float) -> void:
	player.gravity.apply_gravity(delta)
	
	player.side_movement_action.side_movement(PlayerInput.get_side_strength(), delta)
	
	player.move_and_slide()
	
	player.look_at_movement_direction()
	
	player.calculate_transition()

func input(event: InputEvent) -> void:
	if event.is_action_released("jump"):
		player.stop_jump_action.stop_jump()
	if event.is_action_pressed("jump"):
		if is_edge_forgiveness:
			player.jump_action.jump()
			is_edge_forgiveness = false
		else:
			player.air_jump_action.air_jump()
	if event.is_action_pressed("dash"):
		player.player_dash_action.cast()
	if event.is_action_pressed("block"):
		player.player_block_action.cast()
	player.attack(event)
	if event.is_action_pressed("next_weapon"):
		player.weapon_manager.next_weapon()

func _start_edge_forgivness() -> void:
	if player.velocity.y < 0:
		return
	
	is_edge_forgiveness = true
	edge_forgiveness_timer.start()

func _on_edge_forgiveness_timer_timeout() -> void:
	is_edge_forgiveness = false

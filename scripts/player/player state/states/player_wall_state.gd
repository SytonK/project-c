extends PlayerState

const MOVE_OUT_OF_WALL_SPEED: float = 1

@export var gravity_force: float
@export var max_fall_speed: float

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	player.velocity = Vector2(0,0)
	_set_gravity()
	_set_facing_direction()
	player.air_jump_action.reset_air_jumps()
	
	if(player.input_buffer.input_event):
		input(player.input_buffer.input_event)
		player.input_buffer.input_event = null

func exit() -> void:
	player.reset_gravity()

func physics_process(delta: float) -> void:
	player.gravity.apply_gravity(delta)
	
	player.move_and_slide()
	
	player.calculate_transition()

func _set_gravity() -> void:
	player.gravity.graivty_force = gravity_force
	player.gravity.max_fall_speed = max_fall_speed

func _set_facing_direction() -> void:
	var collision: KinematicCollision2D = player.get_last_slide_collision()
	assert(collision, "Wall slide without collision with a wall")
	var normal = collision.get_normal()
	assert(normal.x != 0, "Wall slide collide with no side")
	
	player.facing_direction.direction = FacingDirection.DIRECTIONS.RIGHT if normal.x > 0 else FacingDirection.DIRECTIONS.LEFT

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.player_wall_jump_action.jump()
		return
	if event.is_action_pressed("dash"):
		player.player_dash_action.cast()
		return
	if event.is_action_pressed("look_down"):
		_leave_wall_state()
		return
	if event.is_action_pressed("next_weapon"):
		player.weapon_manager.go_to_next_weapon()
		return
	if player.weapon_manager.attack(event):
		return
	
	player.input_buffer.input_event = event

func _leave_wall_state() -> void:
	player.velocity.x = player.get_facing_direction_to_float() * MOVE_OUT_OF_WALL_SPEED

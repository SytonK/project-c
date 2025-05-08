extends PlayerState

@export var gravity_force: float
@export var max_fall_speed: float

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	player.velocity = Vector2(0,0)
	_set_gravity()
	_set_facing_direction()
	player.air_jump_action.reset_air_jumps()

func exit() -> void:
	player.reset_gravity()

func process(delta: float) -> void:
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
	
	player.facing_direction = Player.FACING_DIRECTIONS.RIGHT if normal.x > 0 else Player.FACING_DIRECTIONS.LEFT

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.player_wall_jump_action.jump()
	if event.is_action_pressed("dash"):
		player.player_dash_action.cast()

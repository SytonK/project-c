class_name Player extends CharacterBody2D

enum FACING_DIRECTIONS {LEFT, RIGHT}

@export_category("Gravity")
@export var gravity_force: float
@export var max_fall_speed: float

@export_category("Side Movement")
@export var acceleration: float
@export var friction: float
@export var max_speed: float

@onready var state_machine: StateMachine = $StateMachine

@onready var gravity: Gravity = $Components/Gravity
@onready var side_movement_action: SideMovementAction = $Components/SideMovementAction
@onready var jump_action: JumpAction = $Components/JumpAction
@onready var stop_jump_action: StopJumpAction = $Components/StopJumpAction
@onready var air_jump_action: AirJumpAction = $Components/AirJumpAction
@onready var player_dash_action: PlayerDashAction = $Components/PlayerDashAction
@onready var player_wall_jump_action: PlayerWallJumpAction = $Components/PlayerWallJumpAction

var facing_direction: FACING_DIRECTIONS = FACING_DIRECTIONS.RIGHT: set = _set_facing_direction

func _ready() -> void:
	reset_gravity()
	reset_side_movement()

func reset_gravity() -> void:
	gravity.graivty_force = gravity_force
	gravity.max_fall_speed = max_fall_speed

func reset_side_movement() -> void:
	side_movement_action.acceleration = acceleration
	side_movement_action.friction = friction
	side_movement_action.max_speed = max_speed

func calculate_transition() -> void:
	if is_on_floor():
		state_machine.transition(PlayerStates.GROUND)
	elif _should_transition_to_wall_state():
		state_machine.transition(PlayerStates.WALL)
	else:
		state_machine.transition(PlayerStates.AIR)

func _set_facing_direction(new_value: FACING_DIRECTIONS) -> void:
	facing_direction = new_value
	#if you scale x to -1 while using the move and slide func it scales the y and rotation insted
	scale.y = -1 if facing_direction != FACING_DIRECTIONS.RIGHT else 1
	rotation = (1 if facing_direction != FACING_DIRECTIONS.RIGHT else 0) * PI

func look_at_movement_direction() -> void:
	if velocity.x > 0:
		facing_direction = FACING_DIRECTIONS.RIGHT
	elif velocity.x < 0:
		facing_direction = FACING_DIRECTIONS.LEFT

func get_input_side_direction() -> float:
	var strength: float = PlayerInput.get_side_strength()
	if strength == 0:
		return 1 if facing_direction == FACING_DIRECTIONS.RIGHT else -1
	return strength/abs(strength)

func _should_transition_to_wall_state() -> bool:
	if !is_on_wall() || velocity.y < 0:
		return false
	
	var collision = get_last_slide_collision()
	
	assert(collision, "Calculate stikcy wall without being on a wall")
	
	return collision.get_collider().is_in_group("sticky_walls")

class_name Player extends CharacterBody2D

@export_category("Gravity")
@export var gravity_force: float
@export var max_fall_speed: float

@export_category("Side Movement")
@export var side_movement_resource: SideMovementResource

@export_category("Air Jumps")
@export var max_air_jumps: int = 0

@export_category("Disables")
@export var block_disabled: bool = false
@export var dash_disabled: bool = false

@onready var state_machine: StateMachine = $StateMachine

@onready var weapon_manager: WeaponManager = $WeaponManager

@onready var hurtbox: Hurtbox = $Hurtbox

@onready var gravity: Gravity = $Components/Gravity
@onready var side_movement_action: SideMovementAction = $Components/SideMovementAction
@onready var facing_direction: FacingDirection = $Components/FacingDirection
@onready var jump_action: JumpAction = $Components/JumpAction
@onready var stop_jump_action: StopJumpAction = $Components/StopJumpAction
@onready var air_jump_action: AirJumpAction = $Components/AirJumpAction
@onready var player_dash_action: PlayerDashAction = $Components/PlayerDashAction
@onready var player_wall_jump_action: PlayerWallJumpAction = $Components/PlayerWallJumpAction
@onready var player_hurt: PlayerHurt = $Components/PlayerHurt
@onready var health: Health = $Components/Health
@onready var player_block_action: PlayerBlockAction = $Components/PlayerBlockAction
@onready var input_buffer: InputBuffer = $Components/InputBuffer

func _ready() -> void:
	reset_gravity()
	reset_side_movement()
	
	player_block_action.disabled = block_disabled
	player_dash_action.disabled = dash_disabled
	air_jump_action.max_air_jumps = max_air_jumps

func reset_gravity() -> void:
	gravity.graivty_force = gravity_force
	gravity.max_fall_speed = max_fall_speed

func reset_side_movement() -> void:
	side_movement_action.resource = side_movement_resource

func calculate_transition() -> void:
	if is_on_floor():
		state_machine.transition(PlayerStates.GROUND)
	elif _should_transition_to_wall_state():
		state_machine.transition(PlayerStates.WALL)
	else:
		state_machine.transition(PlayerStates.AIR)

func look_at_movement_direction() -> void:
	if velocity.x > 0:
		facing_direction.direction = FacingDirection.DIRECTIONS.RIGHT
	elif velocity.x < 0:
		facing_direction.direction = FacingDirection.DIRECTIONS.LEFT

func get_input_side_direction() -> float:
	var strength: float = PlayerInput.get_side_strength()
	if strength == 0:
		return facing_direction.get_float()
	return strength/abs(strength)

func _should_transition_to_wall_state() -> bool:
	if !is_on_wall() || velocity.y < 0:
		return false
	
	var collision = get_last_slide_collision()
	
	assert(collision, "Calculate stikcy wall without being on a wall")
	
	return collision.get_collider().is_in_group("sticky_walls")

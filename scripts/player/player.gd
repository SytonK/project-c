class_name Player extends CharacterBody2D

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
		state_machine.transition(PlayerState.GROUND)
	else:
		state_machine.transition(PlayerState.AIR)

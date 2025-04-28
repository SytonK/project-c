class_name Player extends CharacterBody2D

@export var gravity_force: float
@export var max_fall_speed: float

@onready var state_machine: StateMachine = $StateMachine

@onready var gravity: Gravity = $Components/Gravity

func _ready() -> void:
	reset_gravity()

func reset_gravity() -> void:
	gravity.graivty_force = gravity_force
	gravity.max_fall_speed = max_fall_speed

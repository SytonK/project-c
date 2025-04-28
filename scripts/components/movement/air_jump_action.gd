class_name AirJumpAction extends Node

@export var air_jump_force: float
@export var max_air_jumps: int = 1

@onready var air_jump_charges: int = max_air_jumps

func air_jump() -> bool:
	assert(owner is CharacterBody2D, "Owner of the AirJumpAction component must be of type CharacterBody2D")
	if air_jump_charges > 0:
		air_jump_charges -= 1
		owner.velocity.y = -air_jump_force
		return true
	return false

func reset_air_jumps() -> void:
	air_jump_charges = max_air_jumps

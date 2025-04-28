class_name JumpAction extends Node

@export var jump_force: float

func jump() -> void:
	assert(owner is CharacterBody2D, "Owner of the jump action component must be of type CharacterBody2D")
	owner.velocity.y = -jump_force

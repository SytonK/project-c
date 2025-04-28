class_name JumpAction extends Node

@export var jump_force: float

func jump() -> void:
	assert(owner is CharacterBody2D)
	owner.velocity.y = -jump_force

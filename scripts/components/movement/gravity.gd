class_name Gravity extends Node

@export var graivty_force: float = 3000
@export var max_fall_speed: float = 1000

func apply_gravity(delta: float) -> void:
	assert(owner is CharacterBody2D, "Owner of the Gravity component must be of type CharacterBody2D")
	owner.velocity.y = min(max_fall_speed, owner.velocity.y + graivty_force * delta)

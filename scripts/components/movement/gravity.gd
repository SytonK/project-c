class_name Gravity extends Node

@export var graivty_force: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var max_fall_speed: float

func apply_gravity(delta: float) -> void:
	assert(owner is CharacterBody2D, "Owner of the gravity component must be of type CharacterBody2D")
	owner.velocity.y = min(max_fall_speed, owner.velocity.y + graivty_force * delta)

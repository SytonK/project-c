class_name SideMovementAction extends Node

@export var acceleration: float
@export var friction: float
@export var max_speed: float

func side_movement(strength: float, delta: float) -> void:
	assert(owner is CharacterBody2D, "Owner of the SideMovementAction component must be of type CharacterBody2D")
	if strength != 0:
		_apply_acceleration(strength, delta)
	else:
		_apply_friction(delta)
	
	owner.velocity.x = clampf(owner.velocity.x, -max_speed, max_speed)

func _apply_acceleration(strength: float, delta: float) -> void:
	owner.velocity.x += strength * acceleration * delta

func _apply_friction(delta: float) -> void:
	var abs_x_velocity = abs(owner.velocity.x)
	if abs_x_velocity > friction * delta:
		owner.velocity.x -= (owner.velocity.x/abs_x_velocity) * friction * delta
	else:
		owner.velocity.x = 0

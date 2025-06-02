class_name LookAtTargetLeaf extends Leaf

@export var target: Node2D

@export var facing_direction: FacingDirection

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	assert(facing_direction, "LookAtTargetLeaf was used withour a FacingDirection")
	facing_direction.direction = (FacingDirection.DIRECTIONS.RIGHT 
		if target.global_position.x > (facing_direction.owner as Node2D).global_position.x 
		else FacingDirection.DIRECTIONS.LEFT)
	return States.SUCCEEDED

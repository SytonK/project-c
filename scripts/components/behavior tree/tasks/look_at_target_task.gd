class_name LookAtTargetTask extends Task

@export var targer: Node2D
@export var facing_direction: FacingDirection

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	assert(owner is Node2D, "LookAtTargetTask must be a child of a Node2D")
	
	if targer.global_position.x > owner.global_position.x:
		facing_direction.direction = FacingDirection.DIRECTIONS.RIGHT
	elif targer.global_position.x < owner.global_position.x:
		facing_direction.direction = FacingDirection.DIRECTIONS.LEFT
	
	return States.SUCCEEDED

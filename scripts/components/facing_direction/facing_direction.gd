class_name FacingDirection extends Node

enum DIRECTIONS {LEFT, RIGHT}

var direction: DIRECTIONS = DIRECTIONS.RIGHT: set = _set_direction


func _set_direction(new_value: DIRECTIONS) -> void:
	assert(owner is Node2D, "FacingDirection can only be used on a Node2D")
	direction = new_value
	#if you scale x to -1 while using the move and slide func it scales the y and rotation insted
	owner.scale.y = -1 if direction != DIRECTIONS.RIGHT else 1
	owner.rotation = (1 if direction != DIRECTIONS.RIGHT else 0) * PI

func get_float() -> float:
	return 1 if direction == DIRECTIONS.RIGHT else -1

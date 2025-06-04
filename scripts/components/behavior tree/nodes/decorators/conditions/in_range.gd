class_name InRange extends Condition

@export var target: Node2D
@export var distance: float
@export var source: Node2D

func _condition(_delta: float, _blackboard: Dictionary = {}) -> bool:
	if(!target || !source):
		return false
	
	return (target.global_position - source.global_position).length() <= distance

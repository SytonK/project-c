class_name SideMoveToTargetLeaf extends Leaf

@export var target: Node2D

@export var stop_distance: float

@export var side_movement_action: SideMovementAction

func tick(delta: float, _blackboard: Dictionary = {}) -> States:
	if(!(side_movement_action.owner as CharacterBody2D).is_on_floor() || !target):
		return States.FAILED
	
	if(_in_range()):
		(side_movement_action.owner as CharacterBody2D).velocity.x = 0
		return States.SUCCEEDED
	
	side_movement_action.side_movement(_calc_direcion(), delta)
	
	return States.RUNNING

func _calc_direcion() -> float:
	return ((target.global_position.x - (side_movement_action.owner as CharacterBody2D).global_position.x)
	/abs(target.global_position.x - (side_movement_action.owner as CharacterBody2D).global_position.x))

func _in_range() -> bool:
	return abs(target.global_position.x - (side_movement_action.owner as Node2D).global_position.x) < stop_distance

func interrupt(_blackboard: Dictionary = {}) -> void:
	(side_movement_action.owner as CharacterBody2D).velocity.x = 0

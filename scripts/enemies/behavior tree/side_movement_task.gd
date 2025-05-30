class_name SideMovementTask extends Task

@export var targer: Node2D
@export var side_movement_action: SideMovementAction
@export var stop_distance: float
var characret: CharacterBody2D

func _ready() -> void:
	assert(owner is CharacterBody2D, "SideMovementTask must be used on a CharacterBody2D")
	characret = owner

func tick(delta: float, _blackboard: Dictionary = {}) -> States:
	if (!characret.is_on_floor() || !targer):
		return States.FAILED
	
	if (_in_range()):
		characret.velocity.x = 0
		return States.SUCCEEDED
	
	side_movement_action.side_movement(_calc_direcion(), delta)
	
	return States.RUNNING

func _calc_direcion() -> float:
	return (targer.global_position.x - owner.global_position.x)/abs(targer.global_position.x - owner.global_position.x)

func _in_range() -> bool:
	return abs(targer.global_position.x - owner.global_position.x) < stop_distance

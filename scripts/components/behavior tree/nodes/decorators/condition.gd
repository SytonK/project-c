class_name Condition extends Decorator

@export var is_continues: bool = false
var is_condition_met: bool = false


func start(blackboard: Dictionary = {}) -> void:
	super.start(blackboard)
	if(!is_continues):
		is_condition_met = _condition(0, blackboard)

func tick(delta: float, blackboard: Dictionary = {}) -> States:
	if(is_continues):
		return _continues_tick(delta, blackboard)
	else:
		return _not_continues_tick(delta, blackboard)

func interrupt(blackboard: Dictionary = {}) -> void:
	super.interrupt(blackboard)
	is_condition_met = false

func end(blackboard: Dictionary = {}) -> void:
	super.end(blackboard)
	is_condition_met = false

func _condition(_delta: float, _blackboard: Dictionary = {}) -> bool:
	return true

func _continues_tick(delta: float, blackboard: Dictionary = {}) -> States:
	if(_condition(delta, blackboard)):
		return behavior_node.tick(delta, blackboard)
	
	return States.FAILED

func _not_continues_tick(delta: float, blackboard: Dictionary = {}) -> States:
	if(is_condition_met):
		return behavior_node.tick(delta, blackboard)
	
	return States.FAILED

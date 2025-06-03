class_name ContinuesCondition extends Decorator

func tick(delta: float, blackboard: Dictionary = {}) -> States:
	if(_condition(delta, blackboard)):
		return behavior_node.tick(delta, blackboard)
	
	return States.FAILED

func _condition(delta: float, blackboard: Dictionary = {}) -> bool:
	return true

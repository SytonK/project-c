class_name ReturnStateTask extends Task

@export var state: States

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	return state

class_name TaskPrint extends Task

@export var string: String

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	print(string)
	return States.SUCCEEDED

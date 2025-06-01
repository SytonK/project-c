class_name PrintLeaf extends Leaf

@export var string: String

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	print(string)
	return States.SUCCEEDED

class_name StateLeaf extends Leaf

@export var state: States

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	return state

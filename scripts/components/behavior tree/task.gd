class_name Task extends Node

enum States {
	RUNNING,
	FAILED,
	SUCCEEDED
}

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	return States.RUNNING

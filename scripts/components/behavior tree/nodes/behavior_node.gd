class_name BehaviorNode extends Node

enum States {
	RUNNING,
	FAILED,
	SUCCEEDED
}

func start(_blackboard: Dictionary = {}) -> void:
	pass

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	return States.RUNNING

func interrupt(_blackboard: Dictionary = {}) -> void:
	pass

func end(_blackboard: Dictionary = {}) -> void:
	pass

class_name WaitTask extends Task

@export var wait_time: float = 1
var time_passed: float = 0

func tick(delta: float, _blackboard: Dictionary = {}) -> States:
	time_passed += delta
	if time_passed >= wait_time:
		time_passed = 0
		return States.SUCCEEDED
	else:
		return States.RUNNING

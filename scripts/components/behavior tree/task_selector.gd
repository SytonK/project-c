class_name TaskSelector extends Task

@onready var tasks: Array[Task] = TaskHelper.get_bt_nodes(self)
var index: int = 0

func tick(delta: float, blackboard: Dictionary = {}) -> States:
	var current: States
	
	while index < tasks.size():
		current = tasks[index].tick(delta, blackboard)
		if current == States.FAILED:
			index += 1
		if current == States.SUCCEEDED:
			index = 0
			return current
		if current == States.RUNNING:
			return States.RUNNING
	
	index = 0
	return States.FAILED

class_name TaskRoot extends Task

var node: Task
@export var blackboard: Dictionary

func _ready() -> void:
	for child in get_children():
		if child is Task:
			node = child
			return

func _process(delta: float) -> void:
	tick(delta, blackboard)

func tick(delta: float, p_blackboard: Dictionary = {}) -> States:
	return node.tick(delta, p_blackboard)

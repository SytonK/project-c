class_name Composite extends BehaviorNode

@onready var behavior_nodes: Array[BehaviorNode] = BehaviorTreeUtils.get_behavior_nodes(self)
var index: int = -1
var last_index: int = -1


func start(_blackboard: Dictionary = {}) -> void:
	index = 0
	last_index = -1

func interrupt(blackboard: Dictionary = {}) -> void:
	if index >= 0:
		behavior_nodes[index].interrupt(blackboard)
	
	index = -1
	last_index = -1


func end(blackboard: Dictionary = {}) -> void:
	if index >= 0 && index < behavior_nodes.size() - 1:
		behavior_nodes[index].end(blackboard)
	
	index = -1
	last_index = -1

class_name Composite extends BehaviorNode

@onready var behavior_nodes: Array[BehaviorNode] = BehaviorTreeUtils.get_behavior_nodes(self)
var index: int = 0
var last_index: int = -1
var behavior_node: BehaviorNode = null

func interrupt(blackboard: Dictionary = {}) -> void:
	if behavior_node:
		behavior_node.interrupt(blackboard)
	
	index = 0
	last_index = -1


func end(_blackboard: Dictionary = {}) -> void:
	index = 0
	last_index = -1

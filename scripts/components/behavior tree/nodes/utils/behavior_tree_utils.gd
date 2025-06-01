class_name BehaviorTreeUtils

static func get_behavior_nodes(parent: Composite) -> Array[BehaviorNode]:
	var behavior_nodes: Array[BehaviorNode]
	
	for child in parent.get_children():
		if child is BehaviorNode:
			behavior_nodes.append(child)
	
	return behavior_nodes

class_name SequenceComposite extends Composite

func tick(delta: float, blackboard: Dictionary = {}) -> States:
	var current_tick: States
	
	while index < behavior_nodes.size():
		if last_index < index:
			behavior_nodes[index].start(blackboard)
			last_index = index
		
		current_tick = behavior_nodes[index].tick(delta, blackboard)
		
		if current_tick == States.SUCCEEDED:
			behavior_nodes[index].end(blackboard)
			last_index = index
			index += 1
			behavior_node = null
		if current_tick == States.FAILED:
			behavior_nodes[index].end(blackboard)
			index = 0
			last_index = -1
			behavior_node = null
			return States.FAILED
		if current_tick == States.RUNNING:
			behavior_node = behavior_nodes[index]
			return States.RUNNING
	
	return States.SUCCEEDED

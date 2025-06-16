class_name RandomSelectComposite extends SelectComposite

func start(_blackboard: Dictionary = {}) -> void:
	randomize()
	behavior_nodes.shuffle()

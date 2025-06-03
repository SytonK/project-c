class_name Decorator extends BehaviorNode

var behavior_node: BehaviorNode = null
var is_running: bool = false

func _ready() -> void:
	behavior_node = get_child(0)
	assert(behavior_node, "Decorator was used without a BehaviorNode as a first child")

func start(blackboard: Dictionary = {}) -> void:
	behavior_node.start(blackboard)

func tick(delta: float, blackboard: Dictionary = {}) -> States:
	return behavior_node.tick(delta, blackboard)

func interrupt(blackboard: Dictionary = {}) -> void:
	if behavior_node:
		behavior_node.interrupt(blackboard)

func end(blackboard: Dictionary = {}) -> void:
	behavior_node.end(blackboard)

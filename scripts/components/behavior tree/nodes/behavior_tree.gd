class_name BehaviorTree extends BehaviorNode

@export var blackboard: Dictionary = {}

@export var behavior_node: BehaviorNode

func _ready() -> void:
	behavior_node = get_child(0)
	assert(behavior_node, "BehaviorTree was used without a BehaviorNode as a first child")

func _physics_process(delta: float) -> void:
	tick(delta, blackboard)

func tick(delta: float, _blackboard: Dictionary = {}) -> States:
	return behavior_node.tick(delta, blackboard)

func interrupt(_blackboard: Dictionary = {}) -> void:
	behavior_node.interrupt(blackboard)

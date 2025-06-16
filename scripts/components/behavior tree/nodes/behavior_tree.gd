class_name BehaviorTree extends BehaviorNode

@export var blackboard: Dictionary = {}

var behavior_node: BehaviorNode
var is_running: bool = false

func _ready() -> void:
	behavior_node = get_child(0)
	assert(behavior_node, "BehaviorTree was used without a BehaviorNode as a first child")

func _physics_process(delta: float) -> void:
	tick(delta, blackboard)


func start(_blackboard: Dictionary = {}) -> void:
	behavior_node.start(blackboard)

func tick(delta: float, p_blackboard: Dictionary = blackboard) -> States:
	if(!is_running):
		behavior_node.start(p_blackboard)
		is_running = true
	
	var state: States = behavior_node.tick(delta, p_blackboard)
	
	if(state != States.RUNNING):
		is_running = false
		behavior_node.end(p_blackboard)
		end(p_blackboard)

	return state

func interrupt(_blackboard: Dictionary = {}) -> void:
	behavior_node.interrupt(blackboard)

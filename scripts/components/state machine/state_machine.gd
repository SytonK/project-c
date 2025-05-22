class_name StateMachine extends Node

@export var initial_state: State = null

var state: State

func _ready() -> void:
	await owner.ready
	_connect_states()
	_set_initial_state()

func _connect_states() -> void:
	for child in get_children():
		if child is State:
			child.transition.connect(transition)

func _set_initial_state() -> void:
	state = initial_state if initial_state != null else get_child(0)
	state.enter()

func transition(target_state_path: String, data: Dictionary = {}) -> void:
	if state.name == target_state_path:
		return
	
	if not has_node(target_state_path):
		print(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
	
	var previous_state_path: String = state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)

func _process(delta: float) -> void:
	state.process(delta)

func _physics_process(delta: float) -> void:
	state.physics_process(delta)

func _input(event: InputEvent) -> void:
	state.input(event)

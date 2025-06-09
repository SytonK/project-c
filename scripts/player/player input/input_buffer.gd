class_name InputBuffer extends Node

@export var duration: float = 0.1

var input_event: InputEvent: set = _set_input_event

var timer: Timer

func _ready() -> void:
	_init_timer()

func _init_timer() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = duration
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _set_input_event(new_value: InputEvent) -> void:
	if(!timer):
		return
	
	if(!new_value || new_value.is_pressed()):
		input_event = new_value
		timer.start()

func _on_timer_timeout() -> void:
	input_event = null

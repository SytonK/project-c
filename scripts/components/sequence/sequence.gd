class_name Sequence extends Timer

@export var modulo: int
@export var times: Array[float]

var value: int = 0 : set = _set_value

func _init() -> void:
	one_shot = true
	timeout.connect(_on_timeout)

func _on_timeout() -> void:
	value = 0

func _set_value(new_value: int) -> void:
	value = posmod(new_value, modulo)
	if value != 0:
		if times.size() >= value:
			wait_time = times[value - 1]
		start()

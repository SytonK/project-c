extends PlayerState

const MIN_VELOCITY: float = 10

var dash_timer: Timer

func _ready() -> void:
	super._ready()
	_init_dash_timer()

func _init_dash_timer() -> void:
	dash_timer = Timer.new()
	dash_timer.one_shot = true
	dash_timer.timeout.connect(_on_dash_timer_timeout)
	add_child(dash_timer)

func _on_dash_timer_timeout() -> void:
	player.calculate_transition()

func enter(_previuse_state_name: String = "", data: Dictionary = {}) -> void:
	assert(data.has("dash_duration"), "dash have no dash_duration")
	dash_timer.wait_time = data["dash_duration"]
	dash_timer.start()

func physics_process(_delta: float) -> void:
	player.move_and_slide()
	
	_calculate_early_exit()

func _calculate_early_exit() -> void:
	if player.velocity.length() < MIN_VELOCITY:
		dash_timer.stop()
		player.calculate_transition()

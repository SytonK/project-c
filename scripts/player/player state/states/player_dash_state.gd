extends PlayerState

var dash_timer: Timer

func _ready() -> void:
	_init_dash_timer()

func enter(_previuse_state_name: String = "", data: Dictionary = {}) -> void:
	assert(data.has("dash_duration"), "dash have no dash_duration")
	dash_timer.wait_time = data["dash_duration"]
	dash_timer.start()
	_animate()

func _animate() -> void:
	if player.weapon_manager.current_weapon.animation_player.has_animation('dash'):
		player.weapon_manager.current_weapon.animation_player.play('dash')

func physics_process(_delta: float) -> void:
	player.move_and_slide()
	
	_calculate_early_exit()

func input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_try_jump()
		return
	
	player.input_buffer.input_event = event

func exit() -> void:
	dash_timer.stop()

func _init_dash_timer() -> void:
	dash_timer = Timer.new()
	dash_timer.one_shot = true
	dash_timer.timeout.connect(_on_dash_timer_timeout)
	add_child(dash_timer)

func _on_dash_timer_timeout() -> void:
	player.calculate_transition()

func _calculate_early_exit() -> void:
	if player.velocity.length() <= 0:
		_early_exit()

func _early_exit() -> void:
	dash_timer.stop()
	player.calculate_transition()

func _try_jump() -> void:
	if player.is_on_floor():
		player.jump_action.jump()
		_early_exit()
	else:
		if player.air_jump_action.air_jump():
			_early_exit()

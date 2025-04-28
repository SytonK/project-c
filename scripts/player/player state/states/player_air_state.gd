extends PlayerState

func process(delta: float) -> void:
	player.gravity.apply_gravity(delta)
	
	player.move_and_slide()
	
	_calculate_transition()

func _calculate_transition() -> void:
	if player.is_on_floor():
		transition.emit(PlayerState.GROUND)

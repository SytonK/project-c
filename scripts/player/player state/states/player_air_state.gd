extends PlayerState

func process(delta: float) -> void:
	player.gravity.apply_gravity(delta)
	
	player.move_and_slide()

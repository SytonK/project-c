extends PlayerState

var apply_gravity: bool = true

func physics_process(delta: float) -> void:
	if apply_gravity:
		player.gravity.apply_gravity(delta)
	
	player.move_and_slide()

func exit() -> void:
	player.weapon_manager.enter_cooldown()

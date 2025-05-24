extends PlayerState

var aplly_gravity: bool = true

func enter(_previuse_state_name: String = "", data: Dictionary = {}) -> void:
	_apply_enter_data(data)

func _apply_enter_data(data: Dictionary) -> void:
	if data.has("apply_gravity"):
		aplly_gravity = data["apply_gravity"]
	else:
		aplly_gravity = true

func physics_process(delta: float) -> void:
	if aplly_gravity:
		player.gravity.apply_gravity(delta)
	
	player.move_and_slide()

func exit() -> void:
	player.weapon_manager.enter_cooldown()

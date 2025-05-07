extends PlayerState

@onready var hurt_timer: Timer = $HurtTimer

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	hurt_timer.start()

func physics_process(delta: float) -> void:
	player.gravity.apply_gravity(delta)
	
	player.move_and_slide()

func _on_hurt_timer_timeout() -> void:
	player.calculate_transition()

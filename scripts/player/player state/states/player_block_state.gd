extends PlayerState

@onready var block_timer: Timer = $BlockTimer

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	block_timer.start()


func _on_block_timer_timeout() -> void:
	player.calculate_transition()

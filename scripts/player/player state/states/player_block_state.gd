extends PlayerState

@onready var block_timer: Timer = $BlockTimer

@onready var block_sprite: Polygon2D = $"../../BlockSprite"

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	block_timer.start()
	block_sprite.visible = true


func _on_block_timer_timeout() -> void:
	player.calculate_transition()
	block_sprite.visible = false

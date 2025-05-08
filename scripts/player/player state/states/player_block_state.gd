extends PlayerState

@onready var block_timer: Timer = $BlockTimer

@onready var block_sprite: Polygon2D = $"../../BlockSprite"

var blocked: bool = false

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	block_timer.start()
	block_sprite.visible = true
	blocked = false


func exit() -> void:
	if blocked:
		_exit_after_blocking()
	else:
		_exit_after_miss_blocking()

func _on_block_timer_timeout() -> void:
	player.calculate_transition()
	block_sprite.visible = false


func _on_hurtbox_hurt(_hitbox: Hitbox, _hurtbox: Hurtbox) -> void:
	blocked = true

func _exit_after_blocking() -> void:
	print('blocked')

func _exit_after_miss_blocking() -> void:
	print('did not block')

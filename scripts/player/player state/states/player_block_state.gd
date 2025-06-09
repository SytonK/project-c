extends PlayerState

const BLOCK_COOLDOWN_REFUND_ON_BLOCK: float = 1.25

@onready var block_timer: Timer = $BlockTimer

@onready var block_sprite: Polygon2D = $"../../BlockSprite"

var blocked: bool = false

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	block_timer.start()
	block_sprite.visible = true
	blocked = false
	_animate()


func input(event: InputEvent) -> void:
	player.input_buffer.input_event = event

func _animate() -> void:
	if player.weapon_manager.current_weapon.animation_player.has_animation('block'):
		player.weapon_manager.current_weapon.animation_player.play('block')

func exit() -> void:
	if blocked:
		_exit_after_blocking()
	else:
		_exit_after_miss_blocking()

func _on_block_timer_timeout() -> void:
	player.calculate_transition()
	block_sprite.visible = false


func _on_hurtbox_hurt(_attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2) -> void:
	blocked = true

func _exit_after_blocking() -> void:
	player.player_block_action.charge_cooldown(BLOCK_COOLDOWN_REFUND_ON_BLOCK)

func _exit_after_miss_blocking() -> void:
	pass

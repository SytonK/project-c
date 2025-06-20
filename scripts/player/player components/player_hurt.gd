class_name PlayerHurt extends Node

const PUSHBACK_FOCRCE: float = 250
const PUSHUP_FORCE: float = -500

const BLINK_FREQUENCY: float = 0.1
const BLINK_MODULATE_A_VALUE: float = 0.2

@onready var invulnerable_timer: Timer = $InvulnerableTimer
var is_invulnerable: bool = false

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerHurt component was used on an owner that is not a Player")


func _on_hurtbox_hurt(attack_resource: AttackResource, attack_position: Vector2, _defense_resource: DefenseResource, defense_position: Vector2) -> void:
	if is_invulnerable || player.state_machine.state.name == PlayerStates.BLOCK:
		return
	
	player.state_machine.transition(PlayerStates.HURT)
	_launch_player(attack_position, defense_position)
	_start_invulnerable()
	_blink()
	_hurt_player(attack_resource)

func _launch_player(attack_position: Vector2, defense_position: Vector2) -> void:
	var direction: float = 0
	if defense_position.x == attack_position.x:
		direction = player.facing_direction.get_float()
	else:
		direction = (defense_position.x - attack_position.x)/abs(defense_position.x - attack_position.x)
		
		
	player.velocity = Vector2(direction * PUSHBACK_FOCRCE, PUSHUP_FORCE)

func _start_invulnerable() -> void:
	is_invulnerable = true
	invulnerable_timer.start()

func _on_invulnerable_timer_timeout() -> void:
	is_invulnerable = false
	player.hurtbox.monitoring = false
	player.hurtbox.monitoring = true

func _blink() -> void:
	var blinking_tween: Tween = create_tween()
	blinking_tween.set_loops(int(invulnerable_timer.wait_time / (BLINK_FREQUENCY * 2)))
	blinking_tween.tween_property(player, "modulate:a", BLINK_MODULATE_A_VALUE, BLINK_FREQUENCY)
	blinking_tween.tween_property(player, "modulate:a", 1.0, BLINK_FREQUENCY)
	await blinking_tween.finished
	player.modulate.a = 1

func _hurt_player(attack_resource: AttackResource):
	player.health.value -= attack_resource.damage

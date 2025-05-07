extends Node

const PUSHBACK_FOCRCE: float = 250
const PUSHUP_FORCE: float = -500

@onready var invulnerable_timer: Timer = $InvulnerableTimer
var is_invulnerable: bool = false

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerHurt component was used on an owner that is not a Player")


func _on_hurtbox_hurt(hitbox: Hitbox, hurtbox: Hurtbox) -> void:
	if is_invulnerable:
		return
	
	player.state_machine.transition(PlayerStates.HURT)
	
	_launch_player(hitbox, hurtbox)
	
	_start_invulnerable()

func _launch_player(hitbox: Hitbox, hurtbox: Hurtbox) -> void:
	player.velocity = Vector2(
		((hurtbox.global_position.x - hitbox.global_position.x)/abs(hurtbox.global_position.x - hitbox.global_position.x)) * PUSHBACK_FOCRCE
		,PUSHUP_FORCE)

func _start_invulnerable() -> void:
	is_invulnerable = true
	invulnerable_timer.start()


func _on_invulnerable_timer_timeout() -> void:
	is_invulnerable = false

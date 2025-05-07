extends Node

const PUSHBACK_FOCRCE: float = 250
const PUSHUP_FORCE: float = -500

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerHurt component was used on an owner that is not a Player")


func _on_hurtbox_hurt(hitbox: Hitbox, hurtbox: Hurtbox) -> void:
	player.state_machine.transition(PlayerStates.HURT)
	_launch_player(hitbox, hurtbox)

func _launch_player(hitbox: Hitbox, hurtbox: Hurtbox) -> void:
	player.velocity = Vector2(
		((hurtbox.global_position.x - hitbox.global_position.x)/abs(hurtbox.global_position.x - hitbox.global_position.x)) * PUSHBACK_FOCRCE
		,PUSHUP_FORCE)

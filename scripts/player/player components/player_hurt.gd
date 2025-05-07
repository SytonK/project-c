extends Node

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerHurt component was used on an owner that is not a Player")

func _on_hurtbox_hurt(attack_resource: AttackResource, defense_resource: DefenseResource) -> void:
	player.state_machine.transition(PlayerStates.HURT)

class_name PlayerBlockAction extends Ability

@onready var player: Player = PlayerHelpers.get_player_owner(self)

func _ability_effect() -> void:
	player.state_machine.transition(PlayerStates.BLOCK)
	player.velocity = Vector2(0,0)

func _can_cast() -> bool:
	return super._can_cast() && !player.player_hurt.is_invulnerable

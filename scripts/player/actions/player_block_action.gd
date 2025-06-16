class_name PlayerBlockAction extends Ability

@export var disabled: bool = false

@onready var player: Player = PlayerHelpers.get_player_owner(self)

func _ability_effect() -> void:
	if(disabled):
		return
	
	player.state_machine.transition(PlayerStates.BLOCK)
	player.velocity = Vector2(0,0)

func _can_cast() -> bool:
	return super._can_cast() && !player.player_hurt.is_invulnerable

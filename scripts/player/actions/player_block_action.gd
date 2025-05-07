class_name PlayerBlockAction extends Ability

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerDashAction was used on an owner that is not a Player")

func _ability_effect() -> void:
	player.state_machine.transition(PlayerStates.BLOCK)
	player.velocity = Vector2(0,0)

class_name AxeLightSide extends WeaponChild

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func light_side_0() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	animation_player.play("light_side_swing_0")

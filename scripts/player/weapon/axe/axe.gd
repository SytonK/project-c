extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func light_side_ground_attack() -> void:
	animation_player.play("light_side_swing_0")

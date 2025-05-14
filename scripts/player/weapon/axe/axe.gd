extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var light_side: AxeLightSide = $LightSide

func light_side_ground_attack() -> void:
	light_side.cast()

func light_side_air_attack() -> void:
	light_side.cast()

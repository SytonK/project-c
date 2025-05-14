extends Weapon

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var axe_light_side: AxeLightSide = $AxeLightSide

func light_side_ground_attack() -> void:
	axe_light_side.light_side_0()
	

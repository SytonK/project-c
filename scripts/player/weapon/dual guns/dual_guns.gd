extends Weapon

@onready var dual_guns_lisht_side: DualGunsLishtSide = $DualGunsLishtSide

func light_side_ground_attack() -> void:
	dual_guns_lisht_side.cast()

func light_side_air_attack() -> void:
	dual_guns_lisht_side.cast()

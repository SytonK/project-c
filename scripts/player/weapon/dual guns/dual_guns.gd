extends Weapon

@onready var dual_guns_lisht_side: DualGunsLishtSide = $DualGunsLishtSide

@onready var dual_guns_light_down_ground: DualGunsLightDownGround = $DualGunsLightDownGround
@onready var dual_guns_light_down_air: DualGunsLightDownAir = $DualGunsLightDownAir

func light_side_ground_attack() -> void:
	dual_guns_lisht_side.cast()

func light_side_air_attack() -> void:
	dual_guns_lisht_side.cast()

func light_up_ground_attack() -> void:
	pass

func light_up_air_attack() -> void:
	pass

func light_down_ground_attack() -> void:
	dual_guns_light_down_ground.cast()

func light_down_air_attack() -> void:
	dual_guns_light_down_air.cast()

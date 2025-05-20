extends Weapon

@onready var light_side: AxeLightSide = $LightSide
@onready var axe_light_up: AxeLightUp = $AxeLightUp
@onready var axe_light_down_ground: AxeLightDownGround = $AxeLightDownGround
@onready var axe_light_down_air: AxeLightDownAir = $AxeLightDownAir

func light_side_ground_attack() -> void:
	light_side.cast()

func light_side_air_attack() -> void:
	light_side.cast()

func light_up_ground_attack() -> void:
	axe_light_up.cast()

func light_up_air_attack() -> void:
	axe_light_up.cast()

func light_down_ground_attack() -> void:
	axe_light_down_ground.cast()

func light_down_air_attack() -> void:
	axe_light_down_air.cast()

class_name AxeLightSide extends WeaponChild

const ENERGY_COST: float = 12

const LIGHT_SIDE_SWING_BASE = preload("res://data/player/weapons/axe/light side swing 0/light side swing base.tres")
const LIGHT_SIDE_SWING_HEANDLE_0 = preload("res://data/player/weapons/axe/light side swing 0/light side swing heandle 0.tres")

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var axe_head_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHeadShape"

func light_side_0() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	animation_player.play("light_side_swing_0")
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_HEANDLE_0
	else:
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_BASE

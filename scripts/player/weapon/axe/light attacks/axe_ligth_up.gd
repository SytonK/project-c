class_name AxeLightUp extends Ability

const ENERGY_COST: float = 30
const AXE_LIGHT_UP_HEAD = preload("res://data/player/weapons/axe/light/up/axe_light_up_head.tres")
const AXE_LIGHT_BASE = preload("res://data/player/weapons/axe/light/axe_light_base.tres")

@onready var axe_head_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHeadShape"

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@onready var weapon: Weapon = WeaponHelper.get_weapon_owner(self)
@onready var player: Player = weapon.player

func _ability_effect() -> void:
	_attack_setup()
	animation_player.play("light_up")
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = AXE_LIGHT_UP_HEAD
	else:
		axe_head_shape.attack_resource = AXE_LIGHT_BASE


func _attack_setup() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	player.velocity.x = 0
	player.velocity.y = max(player.velocity.y, 0)

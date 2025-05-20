class_name AxeLightDownGround extends Ability

const ENERGY_COST: float = 18
const AXE_LIGHT_DOWN_GROUND = preload("res://data/player/weapons/axe/light/down/axe_light_down_ground.tres")
const AXE_BASE_ATTACK = preload("res://data/player/weapons/axe/light/axe_base_attack.tres")

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var axe_head_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHeadShape"

var player: Player
var weapon: Weapon

func _ready() -> void:
	super._ready()
	assert(owner is Weapon, "weapon ability was used not on a weapon")
	weapon = owner
	await owner.ready
	player = owner.player

func _ability_effect() -> void:
	_attack_setup()
	animation_player.play("light_down_ground")
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = AXE_LIGHT_DOWN_GROUND
	else:
		axe_head_shape.attack_resource = AXE_BASE_ATTACK


func _attack_setup() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	player.velocity.x = 0
	player.velocity.y = max(player.velocity.y, 0)

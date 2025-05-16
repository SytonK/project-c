class_name AxeLightSide extends Ability

const ENERGY_COST: float = 12
const PUSH_BACK_SIDE_FORCE: float = 600

const LIGHT_SIDE_SWING_BASE = preload("res://data/player/weapons/axe/light side swing 0/light side swing base.tres")
const LIGHT_SIDE_SWING_HEANDLE_0 = preload("res://data/player/weapons/axe/light side swing 0/light side swing heandle 0.tres")
const LIGHT_SIDE_SWING_HEANDLE_1 = preload("res://data/player/weapons/axe/light side swing 0/light side swing heandle 1.tres")
const LIGHT_SIDE_SWING_HEANDLE_2 = preload("res://data/player/weapons/axe/light side swing 0/light side swing heandle 2.tres")

const COOLDOWN0: float = 0.3
const COOLDOWN1: float = 0.38
const COOLDOWN2: float = 0.96

const SEQUENCE0: float = 1.2
const SEQUENCE1: float = 1.4
const SEQUENCE2: float = 1.6

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var axe_head_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHeadShape"
@onready var axe_handle_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHandleShape"
@onready var sequence: Sequence = $Sequence

var player: Player
var weapon: Weapon

func _ready() -> void:
	super._ready()
	assert(owner is Weapon, "weapon ability was used not on a weapon")
	weapon = owner
	await owner.ready
	player = owner.player


func _on_handle_hit(_attack_resource: AttackResource, _defense_resource: DefenseResource, _defense_position: Vector2) -> void:
	_push_back_on_handle_hit()

func _push_back_on_handle_hit() -> void:
	player.velocity.x = -player.get_facing_direction_to_float() * PUSH_BACK_SIDE_FORCE

func finish_side_attack() -> void:
	if axe_handle_shape.hit.is_connected(_on_handle_hit):
		axe_handle_shape.hit.disconnect(_on_handle_hit)
	player.velocity.x = 0

func _ability_effect() -> void:
	_attack()

func _attack() -> void:
	match sequence.value:
		0:
			_light_side_0()
		1:
			_light_side_1()
		2:
			_light_side_2()
	
	sequence.value += 1

func _light_side_0() -> void:
	_attack_setup()
	animation_player.play("light_side_swing_0")
	
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_HEANDLE_0
		axe_handle_shape.hit.connect(_on_handle_hit)
	else:
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_BASE
	
	cooldown = COOLDOWN0
	sequence.wait_time = SEQUENCE0

func _light_side_1() -> void:
	_attack_setup()
	animation_player.play("light_side_swing_1")
	
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_HEANDLE_1
		axe_handle_shape.hit.connect(_on_handle_hit)
	else:
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_BASE
	
	cooldown = COOLDOWN1
	sequence.wait_time = SEQUENCE1

func _light_side_2() -> void:
	_attack_setup()
	animation_player.play("light_side_swing_2")
	
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_HEANDLE_2
	else:
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_BASE
	
	cooldown = COOLDOWN2
	sequence.wait_time = SEQUENCE2

func _attack_setup() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	player.velocity.x = 0
	player.velocity.y = max(player.velocity.y, 0)

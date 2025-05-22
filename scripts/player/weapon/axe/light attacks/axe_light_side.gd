class_name AxeLightSide extends Ability

const ENERGY_COST: float = 12
const PUSH_BACK_SIDE_FORCE: float = 600

const AXE_LIGHT_BASE = preload("res://data/player/weapons/axe/light/axe_light_base.tres")
const AXE_LIGHT_SIDE_HEAD_0 = preload("res://data/player/weapons/axe/light/side/axe_light_side_head_0.tres")
const AXE_LIGHT_SIDE_HEAD_1 = preload("res://data/player/weapons/axe/light/side/axe_light_side_head_1.tres")
const AXE_LIGHT_SIDE_HEAD_2 = preload("res://data/player/weapons/axe/light/side/axe_light_side_head_2.tres")

const COOLDOWN_0: float = 0.15
const COOLDOWN_1: float = 0.2
const COOLDOWN_2: float = 0.8

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var axe_head_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHeadShape"
@onready var axe_handle_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHandleShape"
@onready var sequence: Sequence = $Sequence

@onready var weapon: Weapon = WeaponHelper.get_weapon_owner(self)
@onready var player: Player = weapon.player

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
		axe_head_shape.attack_resource = AXE_LIGHT_SIDE_HEAD_0
		axe_handle_shape.hit.connect(_on_handle_hit)
	else:
		axe_head_shape.attack_resource = AXE_LIGHT_BASE
	
	cooldown = COOLDOWN_0

func _light_side_1() -> void:
	_attack_setup()
	animation_player.play("light_side_swing_1")
	
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = AXE_LIGHT_SIDE_HEAD_1
		axe_handle_shape.hit.connect(_on_handle_hit)
	else:
		axe_head_shape.attack_resource = AXE_LIGHT_BASE
	
	cooldown = COOLDOWN_1

func _light_side_2() -> void:
	_attack_setup()
	animation_player.play("light_side_swing_2")
	
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = AXE_LIGHT_SIDE_HEAD_2
	else:
		axe_head_shape.attack_resource = AXE_LIGHT_BASE
	
	cooldown = COOLDOWN_2

func _attack_setup() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	player.velocity.x = 0
	player.velocity.y = max(player.velocity.y, 0)

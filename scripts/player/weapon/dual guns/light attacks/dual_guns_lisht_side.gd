class_name DualGunsLishtSide extends Ability

const DUAL_GUN_LIGHT_SIDE_BASE = preload("res://data/player/weapons/dual guns/light/dual_gun_light_side_base.tres")
const DUAL_GUN_LIGHT_SIDE_0 = preload("res://data/player/weapons/dual guns/light/side/dual_gun_light_side_0.tres")
const DUAL_GUN_LIGHT_SIDE_1 = preload("res://data/player/weapons/dual guns/light/side/dual_gun_light_side_1.tres")

const BASE_BULLET_SPEED: float = 860
const FAST_BULLET_SPEED: float = 2070

const BULLET_LIFE_TIME: float = .4

const BULLET_0 = preload("res://assets/sprites/player/weapons/dual guns/bullet 0.png")
const BULLET_1 = preload("res://assets/sprites/player/weapons/dual guns/bullet 1.png")

const COOLDOWN_0: float = .1
const COOLDOWN_1: float = .7

const ENERGY_COST: float = 15

@onready var sequence: Sequence = $Sequence
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var player: Player
var weapon: Weapon

func _ready() -> void:
	super._ready()
	assert(owner is Weapon, "weapon ability was used not on a weapon")
	weapon = owner
	await weapon.ready
	player = weapon.player

func _ability_effect() -> void:
	match sequence.value:
		0: 
			_attack_0()
		1:
			_attack_1()
	
	sequence.value += 1

func _attack_0() -> void:
	_set_up_attack()
	animation_player.play("light_side_0")
	_spawn_bullet(DUAL_GUN_LIGHT_SIDE_0, BULLET_0)
	
	cooldown = COOLDOWN_0
	
func _attack_1() -> void:
	_set_up_attack()
	animation_player.play("light_side_1")
	_spawn_bullet(DUAL_GUN_LIGHT_SIDE_1, BULLET_1)
	
	cooldown = COOLDOWN_1

func _set_up_attack() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	player.velocity.x = 0

func _spawn_bullet(p_attack_reasource: AttackResource, texture: Texture2D) -> void:
	var attack_resourc: AttackResource
	var speed: float
	var bounce: bool = false
	if weapon.weapon_energy.value >= ENERGY_COST:
		attack_resourc = p_attack_reasource
		speed = FAST_BULLET_SPEED
		weapon.weapon_energy.value -= ENERGY_COST
		bounce = true
	else:
		attack_resourc = DUAL_GUN_LIGHT_SIDE_BASE
		speed = BASE_BULLET_SPEED
	var new_bullet := Bullet.new(attack_resourc, speed, Vector2(player.get_facing_direction_to_float(), 0), BULLET_LIFE_TIME, texture, bounce)
	new_bullet.global_position = weapon.global_position
	get_tree().root.add_child(new_bullet)

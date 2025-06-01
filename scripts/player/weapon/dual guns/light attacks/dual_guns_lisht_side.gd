class_name DualGunsLishtSide extends Ability

const DUAL_GUNS_LIGHT_SIDE_0 = preload("res://data/player/weapons/dual guns/light/side/dual_guns_light_side_0.tres")
const DUAL_GUNS_LIGHT_SIDE_1 = preload("res://data/player/weapons/dual guns/light/side/dual_guns_light_side_1.tres")

const BULLET_0 = preload("res://assets/sprites/player/weapons/dual guns/bullet 0.png")
const BULLET_1 = preload("res://assets/sprites/player/weapons/dual guns/bullet 1.png")

const COOLDOWN_0: float = .1
const COOLDOWN_1: float = .7

const ENERGY_COST: float = 15

@onready var sequence: Sequence = $Sequence
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@onready var weapon: Weapon = WeaponHelper.get_weapon_owner(self)
@onready var player: Player = weapon.player

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
	_spawn_bullet(DUAL_GUNS_LIGHT_SIDE_0, BULLET_0)
	
	cooldown = COOLDOWN_0
	
func _attack_1() -> void:
	_set_up_attack()
	animation_player.play("light_side_1")
	_spawn_bullet(DUAL_GUNS_LIGHT_SIDE_1, BULLET_1)
	
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
		speed = Bullet.FAST_BULLET_SPEED
		bounce = true
		weapon.weapon_energy.value -= ENERGY_COST
	else:
		attack_resourc = Bullet.DUAL_GUNS_LIGHT_BASE
		speed = Bullet.BASE_BULLET_SPEED
	var new_bullet := Bullet.new(texture, Vector2(player.facing_direction.get_float(), 0), attack_resourc, speed, bounce)
	new_bullet.global_position = weapon.global_position
	get_tree().root.add_child(new_bullet)
